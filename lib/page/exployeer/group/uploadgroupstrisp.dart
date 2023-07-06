import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../widget/textfieldwidget copy.dart';
import '../../../admin/adminmainpage.dart';

class UploadGroupTripsPage extends StatefulWidget {
  const UploadGroupTripsPage({super.key});

  @override
  State<UploadGroupTripsPage> createState() => _UploadGroupTripsPageState();
}

class _UploadGroupTripsPageState extends State<UploadGroupTripsPage> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imagesListXfile = [];

  TextEditingController tourplace = TextEditingController();
  TextEditingController progressNumberEC = TextEditingController();
  TextEditingController locationEC = TextEditingController();
  TextEditingController costEC = TextEditingController();
  TextEditingController descriptionEC = TextEditingController();

  String groupId = DateTime.now().millisecondsSinceEpoch.toString();

  var key = GlobalKey<FormState>();
  List<String> imageUrls = [];

  captureImageWithPhoneCamera() async {
    Navigator.pop(context);
    imagesListXfile = await imagePicker.pickMultiImage();

    setState(() {
      imagesListXfile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return imagesListXfile.isEmpty
        ? defaultScreen(context)
        : Scaffold(
            appBar: AppBar(
              title: const Text("Upload New Trips"),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(3),
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1)),
                    child: GridView.builder(
                      itemCount: imagesListXfile.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.red, width: 1)),
                                child: Image.file(
                                  File(
                                    imagesListXfile[index].path,
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  imagesListXfile.removeAt(index);
                                });
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.5,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        final List<XFile> pickImage =
                            await imagePicker.pickMultiImage();
                        // ignore: unnecessary_null_comparison
                        if (pickImage != null) {
                          setState(() {
                            imagesListXfile.addAll(pickImage);
                          });
                        } else {
                          print("no images selected");
                        }
                      },
                      child: const Text("Pict Image")),
                  Form(
                      key: key,
                      child: Column(
                        children: [
                          TextFormFieldWidgetWithLable(
                            controller: tourplace,
                            hintText: 'Place Name',
                            icon: Icons.place,
                            validatorText: 'Place name not Should be Empty',
                            labelttext: 'Place Name',
                          ),
                          TextFormFieldWidgetWithLable(
                            controller: locationEC,
                            hintText: 'Location',
                            icon: Icons.place,
                            validatorText: 'Location not Should be Empty',
                            labelttext: 'Location',
                          ),
                          TextFormFieldWidgetWithLable(
                            controller: costEC,
                            hintText: 'Cost',
                            icon: Icons.place,
                            validatorText: 'cost not Should be Empty',
                            labelttext: 'cost',
                          ),
                          TextFormFieldWidgetWithLable(
                            controller: progressNumberEC,
                            hintText: 'progress',
                            icon: Icons.place,
                            validatorText: 'rate not Should be Empty',
                            labelttext: 'rate',
                          ),
                          TextFormFieldWidgetWithLable(
                            controller: descriptionEC,
                            hintText: 'description',
                            icon: Icons.place,
                            validatorText: 'description not Should be Empty',
                            labelttext: 'description',
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (imagesListXfile.isNotEmpty) {
                          if (key.currentState!.validate()) {
                            for (XFile imageFile in imagesListXfile) {
                              String fileName = DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString();
                              Reference storageRef = FirebaseStorage.instance
                                  .ref()
                                  .child("groupimage")
                                  .child(fileName);
                              TaskSnapshot uploadTask = await storageRef
                                  .putFile(File(imageFile.path));
                              String imageUrl =
                                  await storageRef.getDownloadURL();
                              imageUrls.add(imageUrl);
                            }
                            // uploadImagesAndSaveToFirestore(imagesListXfile);
                            FirebaseFirestore.instance
                                .collection("grouptrips")
                                .doc(groupId)
                                .set({
                              "grouptrip": groupId,
                              "tripsname": tourplace.text.trim(),
                              "triplocation": locationEC.text.trim(),
                              "tripsrate": progressNumberEC.text.trim(),
                              "tripcost": costEC.text.trim(),
                              "tripimage": imageUrls,
                              "tripdescript": descriptionEC.text.trim(),
                              "publishdate": DateTime.now(),
                            });

                            // ignore: use_build_context_synchronously
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => AdminMainPage(
                                          index: 1,
                                        )));
                          }
                        } else {
                          // Toast
                        }
                      },
                      child: Text("Update"))
                ],
              ),
            ),
          );
  }

  Scaffold defaultScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Groups "),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.add_photo_alternate_outlined,
              color: Colors.black,
              size: 200,
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        title: const Text(
                          "Brand Image",
                          style: TextStyle(
                              color: Colors.purpleAccent,
                              fontWeight: FontWeight.bold),
                        ),
                        children: [
                          SimpleDialogOption(
                            onPressed: () {
                              captureImageWithPhoneCamera();
                            },
                            child: const Text(
                              "Capture image with Camera",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SimpleDialogOption(
                            onPressed: () {
                              captureImageWithPhoneCamera();
                            },
                            child: const Text(
                              "Capture image with Galary",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SimpleDialogOption(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text(
                  "Add Group New Trips",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}
