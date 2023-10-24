import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translator/translator.dart';

class ImageAi extends StatefulWidget {
  static String id ='ImageAi';
  const ImageAi({Key? key}) : super(key: key);


  @override
  State<ImageAi> createState() => _ImageAiState();
}

class _ImageAiState extends State<ImageAi> {

GoogleTranslator translator=GoogleTranslator();


  String imageLabels=' ';
  File? imageFile;


void pickedImage() async{
  try{
    final pickedImage= await ImagePicker().pickImage(
        source: ImageSource.gallery);
    if(pickedImage!= null){
      getImageLabels(pickedImage);
      setState(() {
        imageFile=File(pickedImage.path);
      });
    }

  }catch(e){
    print(e);
  }
}
void openCamera() async{
  try{
    final pickedImage= await ImagePicker().pickImage(
        source: ImageSource.camera);
    if(pickedImage!= null){
      getImageLabels(pickedImage);
      setState(() {
        imageFile=File(pickedImage.path);
      });
    }

  }catch(e){
    print(e);
  }
}

void getImageLabels (XFile image )async{
  final inputImage =InputImage.fromFilePath(image.path);
  ImageLabeler imageLabeler =ImageLabeler(options: ImageLabelerOptions());
  List<ImageLabel> labels =await imageLabeler.processImage(inputImage);
  StringBuffer sd=StringBuffer();
  for (ImageLabel imageLabel in labels){
    String labelText= imageLabel.label;
    double confidence=imageLabel.confidence;
    sd.write(labelText);
    sd.write(':');
    sd.write((confidence * 100).toStringAsFixed(2));
    sd.write('%\n');
  }

  imageLabeler.close();
  imageLabels= sd.toString();

  setState(() {
    translate(imageLabels);
});

}
void translate(String label){
  translator.translate(label,to: "ar-ae").then((output){
    setState(() {
      label=output.toString();
    });
  });
}



  @override
  Widget build(BuildContext context) {
    return Container(

      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.lightBlueAccent,
          title: const Text('Image AI',
            style: TextStyle(
              color: Colors.white,
            fontWeight: FontWeight.bold
            ),),
        ),
        body:  Padding(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height/2,
                  color: Colors.grey,
                  child: imageFile==null?Container():Image.file(imageFile!,fit: BoxFit.cover,),

                ),
                const SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.cyan,
                    borderRadius: BorderRadius.circular(30)
                  ),
                  width: double.infinity,
                  height: 55,

                  child: MaterialButton(
                    onPressed: (){
                      pickedImage();

                    },
                    child: const Text('Pick Image',style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),),

                  ),

                ),
                // Container(
                //   decoration: BoxDecoration(
                //       color: Colors.cyan,
                //     borderRadius: BorderRadius.circular(30)
                //   ),
                //   width: double.infinity,
                //   height: 55,
                //   child: MaterialButton(
                //     onPressed: (){
                //       openCamera();
                //
                //     },
                //     child: const Text('Pick Image',style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 20
                //     ),),
                //
                //   ),
                //
                // ),
                const SizedBox(height: 10,),
                Text(imageLabels,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
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
