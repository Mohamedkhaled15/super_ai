// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:super_ai/screenes/image_ai_picker.dart';
import 'package:super_ai/screenes/text_recognition.dart';
class Home extends StatelessWidget {
  static String id='Home';
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin:Alignment.topCenter ,
               end: Alignment.bottomCenter,
              colors: const [
                Colors.green,
                Colors.cyan,
                Colors.lightBlueAccent,


              ]
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        body: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                SizedBox(height: 80,),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, ImageAi.id);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    boxShadow:const [
                      BoxShadow(
                        blurRadius: 8,
                        blurStyle: BlurStyle.solid,
                      )
                    ]

                    ),
                    width: double.infinity,
                    height: 250,
                    child: Center(child: Text(
                      'Image Recognition'
                          ,style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),
                    ),),

                  ),
                ),
                SizedBox(height: 30,),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, TextRecognition.id);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                        boxShadow:const [
                          BoxShadow(
                            blurRadius: 8,
                            blurStyle: BlurStyle.solid,
                          )
                        ]
                    ),
                    width: double.infinity,
                    height: 250,
                    child: Center(child: Text(
                      'Text Recognition'
                      ,style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    ),
                    ),),

                  ),
                ),
                SizedBox(height: 30,),
                GestureDetector(
                  onTap: (){
                   // Navigator.pushNamed(context, TextRecognition.id);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow:const [
                          BoxShadow(
                            blurRadius: 8,
                            blurStyle: BlurStyle.solid,
                          )
                        ]
                    ),
                    width: double.infinity,
                    height: 250,
                    child: Center(child: Text(
                      'ChatGpt ( Soon )'
                      ,style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    ),
                    ),),

                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
