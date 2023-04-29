import 'package:camera/camera.dart';
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

int? direction ;

class CameraScreen extends StatefulWidget{
  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
   File? _image ;
   final imagePicker = ImagePicker();
    late CameraController  _cameraController;

   @override
  void initState() {
startCamera(0);
  }
  late List<CameraDescription> camera ;

  Future startCamera(int direction ) async{
   final image  = await imagePicker.getImage(source:ImageSource.camera);

    camera = await availableCameras();
    _cameraController = CameraController(camera[direction], ResolutionPreset.high,enableAudio: false);



    await _cameraController.initialize().then((value){
      if(!mounted){
        return;
      }
      setState(() {
        _image = File(image!.path);
      });
    })
    .catchError((e){
      print(e);
    });


     // setState((){
     //  _image = File(image!.path);
     // });
  }


   @override
  void dispose() {
_cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if(_cameraController.value.isInitialized){
       return Scaffold(
         body: Stack(
           children: [
             CameraPreview(_cameraController),
              GestureDetector(
                onTap: (){
                  setState(() {
                     direction = direction ==0?1:0;
                    startCamera(direction!);
                  });
                },
                child: button(Icons.flip_camera_ios_outlined, Alignment.bottomLeft),

              ),


           GestureDetector(
           onTap: (){
        _cameraController.takePicture().then((XFile? file ) {
         if(mounted){
          if(file != null){
         Image.file(_image!);
            print("picture saved to ${file.path}");
          }
        }
      });
       },
          child:button(Icons.camera_alt_outlined, Alignment.bottomCenter),
           ),
           ],
         ),
       );
    } else{
      return SizedBox(
        height: 5,

      );
    }

  }

  Widget button(IconData icon ,Alignment alignment){
    return Align(
      alignment:  alignment,
      child: Container(
          margin: EdgeInsets.only(
            left: 30,
            bottom: 20,
          ),
          height:50 ,
          width: 50,

          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,

              boxShadow: [
                BoxShadow(
                    color:  Colors.black26,
                    offset: Offset(2,2),
                    blurRadius: 0
                )
              ]
          ),
          child: Center(
              child:Icon(
                icon,
                color:  Colors.black45,

              )
          )
      ),
    );
  }
}