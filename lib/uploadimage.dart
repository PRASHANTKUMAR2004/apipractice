import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? image ;
  final _picker=ImagePicker();
  bool showSpinner=false;
  Future getImage() async{
    final pickedFile=(await _picker.pickImage(source: ImageSource.gallery,imageQuality: 80)) as PickedFile;
    if(pickedFile!=null){
      image =File(pickedFile.path);
      setState(() {

      });
    }
    else{
      print('No image Selected');
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Upload image'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: image == null ? Center(child: Text('Pick Image'),)
                :
               Container(
                 child: Center(
                   child: Image.file(
                      File(image!.path),
                     height: 100,
                     width: 100,
                     fit: BoxFit.cover,
                   ),
                 ),
               )
          ),
        ],
      ),
    );
  }
}
