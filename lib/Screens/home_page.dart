import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:skynetsecurity/animations/matrix_effect.dart';
import '../components/custom_button.dart';
import '../utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker imagePicker = ImagePicker();
  String imagepath = "";
  String img64 = "";
  bool isLoading = false;
  File? imagePicked;
  String showImage = "";




  void cameraImage() async {
    try {
      final picker = ImagePicker();
      setState(() {
        isLoading = true;
        print("acv");
      });
      final pickedImage = await picker.pickImage(

        imageQuality: 80,
        source: ImageSource.camera,
      );

      final pickedImageFile = File(pickedImage!.path);
      showImage = pickedImage.path;
      setState(() {
        imagePicked = pickedImageFile;
      });
      Uint8List imageBytes = await pickedImageFile.readAsBytesSync();
      img64 = base64Encode(imageBytes);
      setState(() {
        isLoading = false;
      });
    } catch (Exception) {
      Center(
        child: Text('image-picker-error ${Exception.toString()}'),
      );
    }
  }



  galleryImage() async {
    try {
      final picker = ImagePicker();

      final pickedImage = await picker.pickImage(
        source: ImageSource.gallery,
      );
      setState(() {
        isLoading = true;
      });
      final pickedImageFile = File(pickedImage!.path);
      showImage = pickedImage.path;
      setState(() {
        imagePicked = pickedImageFile;
      });
      Uint8List imageBytes = await pickedImageFile.readAsBytesSync();
      img64 = base64Encode(imageBytes);
      setState(() {
        isLoading = false;
      });
    } catch (Exception) {
      Center(
        child: Text('image-picker-error ${Exception.toString()}'),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    List todo = List.generate(
      img64.length,
      (index) => img64[index],
    );
    print(todo);
    return  Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              showImage = "";
              img64 = "";
              imagepath = "";
              setState(() {
              });
            },
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text("Clear",
                    style: TextStyle(color: Colors.black, fontSize: 17)),
              ),
            ),
          ),
        ],
        centerTitle: true,
        title: const Text(
          "SkyNet Matrix",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: headerBakGroundColor,
      ),
      body: isLoading != true ?
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Image.asset(
            "assets/images/logo.png",
            width: 90,
          ),
          // Expanded(
          //   child: imagepath != ""
          //       ? Image.file(
          //           File(imagepath),fit: BoxFit.cover,
          //         )
          //       : const Padding(
          //           padding: EdgeInsets.symmetric(vertical: 20),
          //           child: Text(
          //             "No Image selected",
          //             style: TextStyle(color: Colors.white),
          //           ),
          //         ),
          // ),
          Expanded(
            child: showImage != ""
                ? Image.file(
                    File(
                      showImage,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "No Image Selected",
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
                            // openImageCamera();
                            cameraImage();
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: const [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/camera.jpg'),
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
                            galleryImage();
                            setState(() {});
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: const [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/gallery.png'),
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
                        (value) => ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Copied"))));
                  }
                },
              ),
            ],
          ),
        ]),
      ): Center(child: CircularProgressIndicator(
        color: Colors.green,
      ),),
    );
  }
}
