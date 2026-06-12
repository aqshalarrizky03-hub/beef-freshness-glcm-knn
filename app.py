from flask import Flask, render_template, request

import os

import cv2

import numpy as np

import pandas as pd

import joblib

import pymysql



from skimage.feature import (

    graycomatrix,

    graycoprops

)

from reportlab.platypus import (
    SimpleDocTemplate,
    Paragraph,
    Spacer
)

from reportlab.lib.styles import getSampleStyleSheet

from flask import send_file



app = Flask(__name__)



UPLOAD_FOLDER = "static/uploads"



if not os.path.exists(

    UPLOAD_FOLDER

):

    os.makedirs(

        UPLOAD_FOLDER

    )



app.config[

    "UPLOAD_FOLDER"

] = UPLOAD_FOLDER



model = joblib.load(

    "model_glcm_knn.pkl"

)



db = pymysql.connect(



    host="localhost",



    user="root",



    password="",



    database="beef_freshness"



)



cursor = db.cursor()



def extract_glcm_features(

    image_path

):



    img = cv2.imread(

        image_path

    )



    gray = cv2.cvtColor(



        img,



        cv2.COLOR_BGR2GRAY



    )



    gray = cv2.resize(



        gray,



        (224,224)



    )



    glcm = graycomatrix(



        gray,



        distances=[1],



        angles=[

            0,

            np.pi/4,

            np.pi/2,

            3*np.pi/4

        ],



        levels=256,



        symmetric=True,



        normed=True



    )



    contrast = graycoprops(

        glcm,

        "contrast"

    ).mean()



    correlation = graycoprops(

        glcm,

        "correlation"

    ).mean()



    energy = graycoprops(

        glcm,

        "energy"

    ).mean()



    homogeneity = graycoprops(

        glcm,

        "homogeneity"

    ).mean()



    return [



        contrast,



        correlation,



        energy,



        homogeneity



    ]

   

@app.route(

    "/",

    methods=[

        "GET",

        "POST"

    ]

)

def index():



    result = None



    image_path = None



    features = None



    features_chart = None



    confidence = None



    if request.method == "POST":



        file = request.files[

            "image"

        ]



        if file:



            filepath = os.path.join(



                app.config[

                    "UPLOAD_FOLDER"

                ],



                file.filename



            )



            file.save(

                filepath

            )



            image_path = filepath



            feature = extract_glcm_features(

                filepath

            )



            feature_df = pd.DataFrame(



                [feature],



                columns=[



                    "Contrast",



                    "Correlation",



                    "Energy",



                    "Homogeneity"



                ]



            )

       

            prediction = model.predict(

                feature_df

            )[0]



            prob = model.predict_proba(

                feature_df

            ).max() * 100



            result = prediction



            confidence = round(

                prob,

                2

            )



            sql = """

            INSERT INTO history

            (

                filename,

                prediction,

                confidence,

                contrast,

                correlation,

                energy,

                homogeneity

            )

            VALUES

            (

                %s,%s,%s,%s,%s,%s,%s

            )

            """



            val = (



                file.filename,



                prediction,



                confidence,



                float(feature[0]),



                float(feature[1]),



                float(feature[2]),



                float(feature[3])



            )



            cursor.execute(

                sql,

                val

            )



            db.commit()

           

            features = {



                "contrast":

                round(

                    feature[0],

                    3

                ),



                "correlation":

                round(

                    feature[1],

                    3

                ),



                "energy":

                round(

                    feature[2],

                    3

                ),



                "homogeneity":

                round(

                    feature[3],

                    3

                )



            }



        features_chart = {



            "contrast": float(feature[0]),



            "correlation": float(feature[1] * 100),



            "energy": float(feature[2] * 100),



            "homogeneity": float(feature[3] * 100)



        }

       

    return render_template(



        "index.html",



        result=result,



        image_path=image_path,



        features=features,



        features_chart=features_chart,



        confidence=confidence



    )

   

@app.route("/history")

def history():



    cursor.execute(

        """

        SELECT

            id,

            filename,

            prediction,

            confidence,

            contrast,

            correlation,

            energy,

            homogeneity,

            created_at

        FROM history

        ORDER BY id DESC

        """

    )



    data = cursor.fetchall()



    return render_template(

        "history.html",

        data=data

    )
    
@app.route("/export_pdf/<int:id>")
def export_pdf(id):

    cursor.execute(
        """
        SELECT
            filename,
            prediction,
            confidence,
            contrast,
            correlation,
            energy,
            homogeneity,
            created_at
        FROM history
        WHERE id=%s
        """,
        (id,)
    )

    data = cursor.fetchone()

    if not data:
        return "Data tidak ditemukan"

    pdf_name = f"laporan_{id}.pdf"

    doc = SimpleDocTemplate(pdf_name)

    styles = getSampleStyleSheet()

    content = []

    content.append(
        Paragraph(
            "LAPORAN ANALISIS KESEGARAN DAGING",
            styles["Title"]
        )
    )

    content.append(
        Spacer(1,20)
    )

    content.append(
        Paragraph(
            f"Nama File : {data[0]}",
            styles["Normal"]
        )
    )

    content.append(
        Paragraph(
            f"Hasil Prediksi : {data[1]}",
            styles["Normal"]
        )
    )

    content.append(
        Paragraph(
            f"Confidence : {data[2]} %",
            styles["Normal"]
        )
    )

    content.append(
        Paragraph(
            f"Contrast : {data[3]}",
            styles["Normal"]
        )
    )

    content.append(
        Paragraph(
            f"Correlation : {data[4]}",
            styles["Normal"]
        )
    )

    content.append(
        Paragraph(
            f"Energy : {data[5]}",
            styles["Normal"]
        )
    )

    content.append(
        Paragraph(
            f"Homogeneity : {data[6]}",
            styles["Normal"]
        )
    )

    content.append(
        Paragraph(
            f"Tanggal : {data[7]}",
            styles["Normal"]
        )
    )

    doc.build(content)

    return send_file(
        pdf_name,
        as_attachment=True
    )




if __name__ == "__main__":

    app.run(debug=True)