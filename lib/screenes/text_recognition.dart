// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
class TextRecognition extends StatefulWidget {
  static String id='TextRecognition';
  const TextRecognition({Key? key}) : super(key: key);

  @override
  State<TextRecognition> createState() => _TextRecognitionState();
}

class _TextRecognitionState extends State<TextRecognition> {
  File? _image;
  String text= ' ';
  Future _pickImage(ImageSource source )async{
    try{
      final image = await ImagePicker().pickImage(source: source);
      if(image==null)return;
      setState(() {
        _image=File(image.path);
      });

    }catch (e){
      if (kDebugMode) {
        print(e);
      }
    }

  }
  Future textRecognition(File img) async{
    final textRecognizer=TextRecognizer(script: TextRecognitionScript.latin);
    final inputImage=InputImage.fromFilePath(img.path);
    final RecognizedText recognizedText=
        await textRecognizer.processImage(inputImage);
    setState(() {
      text=recognizedText.text;
    });
    print(text);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('Text Recognition',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.cyan,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(height: 10,),
              Container(
                width: double.infinity,
                height: 250,
                color: Colors.grey,
                child: Center(
                  child: _image==null?
                  Icon(Icons.add_a_photo,color: Colors.white,size: 60,):
                  Image.file(_image!,fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(30)
                ),
                width: double.infinity,
                height: 50,

                child: MaterialButton(
                  onPressed: (){
                    _pickImage(ImageSource.camera).then((value){

                      if(_image !=null){
                       textRecognition(_image!);
                      }
                    });
                  },
                  child: Text(
                    'Take Image From Camera',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23
                    ),
                  ),

                ),
              ),
              SizedBox(height: 15,),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(30)
                ),
                child: MaterialButton(
                  onPressed: (){
                    _pickImage(ImageSource.gallery).then((value){

                      if(_image !=null){
                        textRecognition(_image!);
                      }
                    });
                  },
                  child: Text(
                    'Take Image From Gallery',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23
                    ),
                  ),

                ),
              ),
              SizedBox(height: 20,),
              SelectableText(
                text,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                fontWeight: FontWeight.bold
                ),

              ),


            ],
          ),
        ),
      ),

    );
  }
}
