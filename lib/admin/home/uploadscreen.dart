import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../model/categoriesmodel.dart';
import '../../../widget/textfieldwidget copy.dart';
import '../../../admin/adminmainpage.dart';
import 'package:date_time_picker/date_time_picker.dart';
import '../../const/const.dart';
import '../../model/tripsmodel.dart';
import 'package:intl/intl.dart';

class UploadScreen extends StatefulWidget {
  UploadScreen({super.key, this.isUPdate, this.tripsModels});
  bool? isUPdate;
  TripsModels? tripsModels;
  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  TextEditingController placeNameEC = TextEditingController();
  TextEditingController rateEC = TextEditingController();
  TextEditingController locationEC = TextEditingController();
  TextEditingController costEC = TextEditingController();
  TextEditingController descriptionEC = TextEditingController();

  String tripsId = DateTime.now().millisecondsSinceEpoch.toString();

  @override
  void initState() {
    super.initState();
    if (widget.isUPdate == true) {
      placeNameEC.text = widget.tripsModels!.tourname!;
      rateEC.text = widget.tripsModels!.rate!;
      locationEC.text = widget.tripsModels!.location!;
      costEC.text = widget.tripsModels!.cost!;
      descriptionEC.text = widget.tripsModels!.description!;
      tripsId = widget.tripsModels!.id!;
      dropdownValue = widget.tripsModels!.categoris!;
      selectedDate = DateFormat('yyyy-MM-dd HH:mm:ss')
          .format(widget.tripsModels!.tourdate!.toDate());
      print(selectedDate);
      for (String images in widget.tripsModels!.image!) {
        imageUrls.add(images);
      }
    }
  }

  @override
  void dispose() {
    placeNameEC.dispose();
    rateEC.dispose();
    locationEC.dispose();
    costEC.dispose();
    descriptionEC.dispose();
    super.dispose();
  }

  bool uploading = false;
  var key = GlobalKey<FormState>();
  List<XFile> imagesListXfile = [];
  List<String> imageUrls = [];
  final ImagePicker imagePicker = ImagePicker();
  String dropdownValue = categoryString.first;
  String? selectedDate;
  @override
  Widget build(BuildContext context) {
    if (imagesListXfile.isEmpty && widget.isUPdate == false) {
      return defaultScreen();
    }
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: widget.isUPdate == true
              ? const Text("Update Trips")
              : const Text("Upload New Trips"),
          actions: [
            IconButton(
                onPressed: widget.isUPdate == true
                    ? () async {
                        if (imageUrls.isNotEmpty) {
                          if (key.currentState!.validate()) {
                            setState(() {
                              uploading = true;
                            });

                            FirebaseFirestore.instance
                                .collection("trip")
                                .doc(tripsId)
                                .update({
                              "tourname": placeNameEC.text.trim(),
                              "location": locationEC.text.trim(),
                              "rate": rateEC.text.trim(),
                              "cost": costEC.text.trim(),
                              "image": imageUrls,
                              "categoris": dropdownValue,
                              "description": descriptionEC.text.trim(),
                              "tourdate": DateTime.parse(selectedDate!),
                              "publishdate": DateTime.now(),
                            }).then((value) {
                              setState(() {
                                uploading = false;
                              });
                              showToast(
                                  context: context, text: "Succeffully Added");
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => AdminMainPage()));
                            }).catchError((erorr) {
                              showToast(
                                  context: context, text: "An Error  $erorr");
                            });
                          }
                        } else {
                          showToast(
                              context: context,
                              text: "At least One Photo added ");
                        }
                      }
                    : () async {
                        if (imagesListXfile.isNotEmpty) {
                          if (key.currentState!.validate()) {
                            setState(() {
                              uploading = true;
                            });
                            for (XFile imageFile in imagesListXfile) {
                              String fileName = DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString();
                              Reference storageRef = FirebaseStorage.instance
                                  .ref()
                                  .child("tripimage")
                                  .child(fileName);
                              TaskSnapshot uploadTask = await storageRef
                                  .putFile(File(imageFile.path));
                              String imageUrl =
                                  await storageRef.getDownloadURL();
                              imageUrls.add(imageUrl);
                            }
                            FirebaseFirestore.instance
                                .collection("trip")
                                .doc(tripsId)
                                .set({
                              "id": tripsId,
                              "tourname": placeNameEC.text.trim(),
                              "location": locationEC.text.trim(),
                              "rate": rateEC.text.trim(),
                              "cost": costEC.text.trim(),
                              "image": imageUrls,
                              "categoris": dropdownValue,
                              "description": descriptionEC.text.trim(),
                              "tourdate": DateTime.parse(selectedDate!),
                              "publishdate": DateTime.now(),
                            }).then((value) {
                              setState(() {
                                uploading = false;
                              });
                              showToast(
                                  context: context, text: "Succeffully Added");
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => AdminMainPage()));
                            }).catchError((erorr) {
                              showToast(
                                  context: context, text: "An Error  $erorr");
                            });
                          }
                        } else {
                          showToast(
                              context: context,
                              text: "At least One Photo added ");
                        }
                      },
                icon: const Icon(
                  Icons.cloud_upload,
                  color: Colors.blue,
                ))
          ],
        ),
        body: ListView(
          children: [
            uploading == true
                ? const LinearProgressIndicator(
                    backgroundColor: Colors.red,
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Column(
                children: [
                  widget.isUPdate == true
                      ? Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xff008FA0), width: 1)),
                          child: GridView.builder(
                            itemCount: imageUrls.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.red, width: 1)),
                                      child: Image.network(
                                          height: 200,
                                          width: 200,
                                          fit: BoxFit.fill,
                                          imageUrls[index]),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        imageUrls.removeAt(index);
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      margin: const EdgeInsets.all(2),
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.red,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 1.5,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 2,
                            ),
                          ),
                        )
                      : Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xff008FA0), width: 1)),
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
                                        File(imagesListXfile[index].path),
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
                                      padding: const EdgeInsets.all(4),
                                      margin: const EdgeInsets.all(2),
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.red,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 1.5,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 2,
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 7,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff008FA0)),
                        onPressed: widget.isUPdate == true
                            ? () async {
                                final List<XFile> pickImage =
                                    await imagePicker.pickMultiImage();
                                if (pickImage != null) {
                                  imagesListXfile.addAll(pickImage);
                                  for (XFile imageFile in pickImage) {
                                    String fileName = DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString();
                                    Reference storageRef = FirebaseStorage
                                        .instance
                                        .ref()
                                        .child("tripimage")
                                        .child(fileName);
                                    TaskSnapshot uploadTask = await storageRef
                                        .putFile(File(imageFile.path));
                                    String imageUrl =
                                        await storageRef.getDownloadURL();
                                    imageUrls.add(imageUrl);
                                  }
                                  setState(() {});
                                } else {
                                  // ignore: use_build_context_synchronously
                                  showToast(
                                      context: context,
                                      text: "Now Image Selected");
                                }
                              }
                            : () async {
                                final List<XFile> pickImage =
                                    await imagePicker.pickMultiImage();
                                if (pickImage != null) {
                                  imagesListXfile.addAll(pickImage);
                                  setState(() {});
                                } else {
                                  // ignore: use_build_context_synchronously
                                  showToast(
                                      context: context,
                                      text: "Now Image Selected");
                                }
                              },
                        child: const Text(
                          "Pick Image",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        )),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  DropdownButton<String>(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    underline: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xff008FA0), width: 1)),
                    ),
                    dropdownColor: Colors.white,
                    isExpanded: true,
                    value: dropdownValue,
                    items: categoryString.map<DropdownMenuItem<String>>((e) {
                      return DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                  ),
                  Form(
                    key: key,
                    child: Column(
                      children: [
                        TextFormFieldWidgetWithLable(
                          controller: placeNameEC,
                          hintText: 'Tour Place Name',
                          icon: Icons.location_history,
                          validatorText: 'Field Not Emapy',
                          labelttext: 'Tour Place Name',
                        ),
                        TextFormFieldWidgetWithLable(
                          controller: locationEC,
                          hintText: 'Location',
                          icon: Icons.place,
                          validatorText: 'Field Not Emapy',
                          labelttext: 'Location',
                        ),
                        TextFormFieldWidgetWithLable(
                          keyboardType: TextInputType.number,
                          controller: costEC,
                          hintText: 'Cost',
                          icon: Icons.money,
                          validatorText: 'Field Not Emapy',
                          labelttext: 'cost',
                        ),
                        TextFormFieldWidgetWithValid(
                          keyboardType: TextInputType.number,
                          controller: rateEC,
                          hintText: 'rate',
                          icon: Icons.rate_review_rounded,
                          validatorText: 'rate not Should be Empty',
                          labelttext: 'rate',
                        ),
                        TextFormFieldWidgetWithLable(
                          controller: descriptionEC,
                          hintText: 'description',
                          maxLines: 5,
                          icon: Icons.description,
                          validatorText: 'description not Should be Empty',
                          labelttext: 'description',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: const Color(0xff008FA0), width: 1)),
                          child: DateTimePicker(
                              type: DateTimePickerType.dateTime,
                              dateHintText: "Select Tour Date and Time",
                              icon: const Icon(
                                Icons.event,
                                color: Color(0xff008FA0),
                              ),
                              initialValue: selectedDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              onChanged: (val) => setState(() {
                                    selectedDate = val;
                                  })),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Scaffold defaultScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New  Trips"),
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
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                onPressed: () {
                  obtainImageDialogBox();
                },
                child: const Text(
                  "Add New Trips",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }

  obtainImageDialogBox() {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          backgroundColor: Colors.white,
          title: const Text(
            "Brand Image",
            style: TextStyle(
                color: Colors.purpleAccent, fontWeight: FontWeight.bold),
          ),
          children: [
            SimpleDialogOption(
              onPressed: () {
                captureImageWithPhoneCamera();
              },
              child: const Text(
                "Capture image with Camera",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                captureImageFromGaller();
              },
              child: const Text(
                "Select image from Gallery",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {},
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
  }

  captureImageWithPhoneCamera() async {
    Navigator.pop(context);
    imagesListXfile = await imagePicker.pickMultiImage();
    setState(() {
      imagesListXfile;
    });
  }

  captureImageFromGaller() async {
    Navigator.pop(context);
    imagesListXfile = await imagePicker.pickMultiImage();
    setState(() {
      imagesListXfile;
    });
  }
}
