import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

import 'FilterData.dart';

class ImageToText extends StatefulWidget {
  @override
  _ImageToTextState createState() => _ImageToTextState();
}

class _ImageToTextState extends State<ImageToText> {

  File pickedImage;
  String userName="",userBirth="",userId="";
  bool isImageLoaded = false;

  //..........pick Image From Gallery.............
  Future pickImage() async {
    final file = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      pickedImage = File(file.path);
      isImageLoaded = true;
      if(userName!=""){
        userName="";
      }
      if(userBirth!=""){
        userBirth="";
      }
      if(userId!=""){
        userId="";
      }
    });
  }

  //..........capture Image by Camera.............
  Future captureImage() async {
    final file = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      pickedImage = File(file.path);
      isImageLoaded = true;
      if(userName!=""){
        userName="";
      }
      if(userBirth!=""){
        userBirth="";
      }
      if(userId!=""){
        userId="";
      }
    });
  }

  //..........barcode Scan.............
  Future decode() async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    BarcodeDetector barcodeDetector = FirebaseVision.instance.barcodeDetector();
    List barCodes = await barcodeDetector.detectInImage(ourImage);

    for (Barcode readableCode in barCodes) {
      print("data--> ${readableCode.rawValue}");
    }
  }

  //..........convert Image To Text.............
  Future readText() async {
    if (pickedImage == null) {
      print('No selected image');
    } else {
      print('image found');
      final visionImage = FirebaseVisionImage.fromFile(pickedImage);
      final textRecognizer = FirebaseVision.instance.textRecognizer();
      final readText = await textRecognizer.processImage(visionImage);
      await textRecognizer.close();

      setState(() {
        userName=FilterData.getName(readText);
        userBirth=FilterData.getBirth(readText);
        userId=FilterData.getNid(readText);
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan N-ID Card"),
        backgroundColor: Colors.deepPurple,
      ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),

              Text("This Scanner Only Work BD N-ID",
                style: TextStyle(
                  color: Colors.red,
                ),),

              SizedBox(height: 16,),

              isImageLoaded
                  ? Center(
                      child: Container(
                        height: 200,
                        child: Image(
                          image: FileImage(pickedImage), fit: BoxFit.fill, // use this
                        ),
                       margin: EdgeInsets.all(16),
                        // decoration: BoxDecoration(
                        //     image: DecorationImage(
                        //         image: FileImage(pickedImage), fit: BoxFit.fill))
                      ),
                    )
                  : Container(),

              SizedBox(height: 16.0),

              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Colors.deepPurple,
                      child: Text('Pick BD N-Id Card',
                      style: TextStyle(
                        color: Colors.white,
                      ),),
                      onPressed: pickImage,
                    ),
                  ),

                  SizedBox(width: 16.0),

                  Expanded(
                    child: RaisedButton(
                      color: Colors.deepPurple,
                      child: Text('Capture BD N-Id Card',
                        style: TextStyle(
                          color: Colors.white,
                        ),),
                      onPressed: captureImage,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 8,),

              RaisedButton(
                color: Colors.deepPurple,
                child: Text('Convert',
                  style: TextStyle(
                    color: Colors.white,
                  ),),
                onPressed: readText,
              ),

              SizedBox(height: 16,),

              Text("$userName",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),),

              SizedBox(height: 16,),

              Text("$userBirth",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),),

              SizedBox(height: 16,),

              Text("$userId",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),),

            ],
          ),
        )
    );
  }
}
