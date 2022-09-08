import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skynetsecurity/animations/matrix_effect.dart';
import '../components/custom_button.dart';
import '../utils/colors.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ImagePicker imagePicker = ImagePicker();
  String imagepath = "";
  String img64 = "";

  void Camera ()  async{
    PermissionStatus cameraStatus = await Permission.camera.request();
    if(cameraStatus == PermissionStatus.granted){
      try {
        var pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
        if (pickedFile != null) {
          imagepath = pickedFile.path;
          File imagefile = File(imagepath);
          Uint8List imagebytes = await imagefile.readAsBytes();
          img64 = base64.encode(imagebytes);
        } else {
          const Text("No image is selected.");
        }
      } catch (e) {
        const Text("error while picking file.");
      }
    }
    if(cameraStatus == PermissionStatus.denied){
      openAppSettings();
    }
    if(cameraStatus == PermissionStatus.permanentlyDenied){
      openAppSettings();
    }
  }

  // openImageCamera() async {
  //
  // }

  openImage() async {
    try {
      var pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        imagepath = pickedFile.path;
        File imagefile = File(imagepath);
        Uint8List imagebytes = await imagefile.readAsBytes();
        img64 = base64.encode(imagebytes);
      } else {
        const Text("No image is selected.");
      }
    } catch (e) {
      const Text("error while picking file.");
    }
  }


  @override
  Widget build(BuildContext context){
    List todo = List.generate(
      img64.length,
      (index) => img64[index],
    );
    print(todo);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              imagepath = "";
              img64 = "";
              setState(() {
              });
            },
            child:  Center(
                child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text("Clear",
                  style: TextStyle(color: Colors.black, fontSize: 17)),
            )),
          )
        ],
        centerTitle: true,
        title: const Text(
          "SkyNet Matrix",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: headerBakGroundColor,
      ),
      body:
           Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                Image.asset(
                  "assets/images/logo.png",
                  width: 90,
                ),
                Expanded(
                  child: imagepath != ""
                      ? Image.file(
                          File(imagepath
                          ),
                        )
                      : const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            "No Image selected",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: ListTile(
                    title: Center(
                        child: Text(
                      todo.length != 0 ? todo.toString() : "",
                      style: TextStyle(color: Colors.white),
                    )),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MatrixEffect(
                            todo: todo,
                          ),
                        ),
                      );
                    },
                  ),
                )),

                // Expanded(
                //   child: SingleChildScrollView(
                //     child: Text(
                //       img64.toString(),
                //       style: const TextStyle(
                //         fontSize: 12,
                //         color: Colors.white,
                //       ),
                //       textAlign: TextAlign.justify,
                //     ),
                //   ),
                // ),
                Row(
                  //mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      text: "Select Image",
                      onPressed: () {
                        AlertDialog alert = AlertDialog(
                          title: const Text(
                            "Select an Options",
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {
                                  //openImageCamera();
                                  Camera();
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  children: const [
                                    CircleAvatar(
                                      backgroundImage: AssetImage(
                                          'assets/images/camera.jpg'),
                                      radius: 20,
                                      backgroundColor: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text("Camera"),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  openImage();
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  children: const [
                                    CircleAvatar(
                                      backgroundImage: AssetImage(
                                          'assets/images/gallery.png'),
                                      radius: 20,
                                      backgroundColor: Colors.white10,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text("Gallery"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            });
                        //openImage();
                      },
                    ),
                    CustomButton(
                      text: "Copy",
                      onPressed: () {
                        if (img64 == "") {
                        } else {
                          Clipboard.setData(ClipboardData(text: img64)).then(
                              (value) => ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                      const SnackBar(content: Text("Copied"))));
                        }
                      },
                    ),
                  ],
                ),
              ]),
            ),

    );}
}
