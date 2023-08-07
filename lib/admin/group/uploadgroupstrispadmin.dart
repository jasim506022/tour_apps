import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tour_apps/model/grouptipmodel.dart';

import '../../service/provider/admin/uploadgrouptourprovider.dart';
import '../../user/widget/textfieldwidget copy.dart';
import '../../../admin/adminmainpage.dart';
import '../../const/const.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class UploadGroupTripsPageAdmin extends StatefulWidget {
  UploadGroupTripsPageAdmin({super.key, this.isUPdate, this.groupTourModel});

  bool? isUPdate;
  GroupTourModel? groupTourModel;

  @override
  State<UploadGroupTripsPageAdmin> createState() =>
      _UploadGroupTripsPageAdminState();
}

class _UploadGroupTripsPageAdminState extends State<UploadGroupTripsPageAdmin> {
  final ImagePicker imagePicker = ImagePicker();

  @override
  void initState() {
  
    super.initState();

    if (widget.isUPdate == true) {
      
      Future.delayed(Duration.zero, () {
        var myData = Provider.of<UploadGroupProvider>(context, listen: false);
        myData.setImageUrl(photo: []);
        nameTEC.text = widget.groupTourModel!.tourname!;
        rateTEC.text = widget.groupTourModel!.rate!.toString();
        locationTEC.text = widget.groupTourModel!.location!.toString();
        costEC.text = widget.groupTourModel!.cost!.toString();
        descriptionEC.text = widget.groupTourModel!.description!;
        durationTEC.text = widget.groupTourModel!.duration!;
        progressNumberTEC.text = widget.groupTourModel!.bookingsit!.toString();
        groupId = widget.groupTourModel!.id!;

        myData.setSelectedDate(
            date: DateFormat('yyyy-MM-dd HH:mm:ss')
                .format(widget.groupTourModel!.tourdate!.toDate()));
        for (String images in widget.groupTourModel!.image!) {
          myData.imageUrls.add(images);
          // imageUrl.add(images);
          setState(() {});
        }

        // Access the value of myData here
      });
    } else {
      Future.delayed(Duration.zero, () {
        var myData = Provider.of<UploadGroupProvider>(context, listen: false);
        myData.setImage(photo: []);
        myData.setImageUrl(photo: []);
        myData.setSelectedDate(date: DateTime.now().toString());
        

        // Access the value of myData here
      });
    }
  }

  @override
  void dispose() {
    nameTEC.dispose();
    locationTEC.dispose();
    rateTEC.dispose();
    durationTEC.dispose();
    progressNumberTEC.dispose();
    costEC.dispose();
    descriptionEC.dispose();
    tourdate.dispose();
    super.dispose();
  }

  TextEditingController nameTEC = TextEditingController();
  TextEditingController locationTEC = TextEditingController();
  TextEditingController rateTEC = TextEditingController();
  TextEditingController durationTEC = TextEditingController();
  TextEditingController progressNumberTEC = TextEditingController();
  TextEditingController costEC = TextEditingController();
  TextEditingController descriptionEC = TextEditingController();
  TextEditingController tourdate = TextEditingController();

  String groupId = DateTime.now().millisecondsSinceEpoch.toString();

  var key = GlobalKey<FormState>();

  captureImageWithPhoneCamera() async {
    UploadGroupProvider uploadSingleTourProvider =
        Provider.of<UploadGroupProvider>(context, listen: false);
    Navigator.pop(context);
    List<XFile> imagesListXfile = await imagePicker.pickMultiImage();

    uploadSingleTourProvider.setImage(photo: imagesListXfile);
  }

  String? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Consumer<UploadGroupProvider>(
      builder: (context, uploadprovider, child) {
        if (uploadprovider.imagesListXfile.isEmpty &&
            widget.isUPdate == false) {
         
          return defaultScreen(context);
        }
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              title: widget.isUPdate == true
                  ? const Text("Update Group Trips")
                  : const Text("Upload New Group Trips"),
              actions: [
                IconButton(
                    onPressed: widget.isUPdate == true
                        ? () async {
                            if (uploadprovider.imageUrls.isNotEmpty) {
                              if (key.currentState!.validate()) {
                                Provider.of<UploadGroupProvider>(context,
                                        listen: false)
                                    .setUploading(value: true);

                                FirebaseFirestore.instance
                                    .collection("grouptrips")
                                    .doc(groupId)
                                    .update({
                                  "tourname": nameTEC.text.trim(),
                                  "location": locationTEC.text.trim(),
                                  "rate": double.parse(rateTEC.text.trim()),
                                  "cost": double.parse(costEC.text.trim()),
                                  "bookingsit": double.parse(
                                      progressNumberTEC.text.trim()),
                                  "image": uploadprovider.imageUrls,
                                  "duration": durationTEC.text.trim(),
                                  "description": descriptionEC.text.trim(),
                                  "tourdate": DateTime.parse(
                                      uploadprovider.selectedDate),
                                  "publishdate": DateTime.now(),
                                }).then((value) {
                                  Provider.of<UploadGroupProvider>(context,
                                          listen: false)
                                      .setUploading(value: false);
                                  showToast(
                                      context: context,
                                      text: "Succeffully Update");
                                  // ignore: use_build_context_synchronously
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (c) => AdminMainPage()));
                                }).catchError((erorr) {
                                  showToast(
                                      context: context,
                                      text: "An Error  $erorr");
                                });
                              }
                            } else {
                              showToast(
                                  context: context,
                                  text: "At least One Photo added ");
                            }
                          }
                        : () async {
                            if (uploadprovider.imagesListXfile.isNotEmpty) {
                              if (key.currentState!.validate()) {
                                Provider.of<UploadGroupProvider>(context,
                                        listen: false)
                                    .setUploading(value: true);
                                for (XFile imageFile
                                    in uploadprovider.imagesListXfile) {
                                  String fileName = DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString();
                                  Reference storageRef = FirebaseStorage
                                      .instance
                                      .ref()
                                      .child("groupimage")
                                      .child(fileName);
                                  // ignore: unused_local_variable
                                  TaskSnapshot uploadTask = await storageRef
                                      .putFile(File(imageFile.path));
                                  String imageUrl =
                                      await storageRef.getDownloadURL();
                                  uploadprovider.imageUrls.add(imageUrl);
                                }
                                FirebaseFirestore.instance
                                    .collection("grouptrips")
                                    .doc(groupId)
                                    .set({
                                  "id": groupId,
                                  "tourname": nameTEC.text.trim(),
                                  "location": locationTEC.text.trim(),
                                  "rate": double.parse(rateTEC.text.trim()),
                                  "cost": double.parse(costEC.text.trim()),
                                  "bookingsit": double.parse(
                                      progressNumberTEC.text.trim()),
                                  "image": uploadprovider.imageUrls,
                                  "duration": durationTEC.text.trim(),
                                  "description": descriptionEC.text.trim(),
                                  "tourdate": DateTime.parse(
                                      uploadprovider.selectedDate),
                                  "publishdate": DateTime.now(),
                                }).then((value) {
                                  Provider.of<UploadGroupProvider>(context,
                                          listen: false)
                                      .setUploading(value: false);
                                  showToast(
                                      context: context,
                                      text: "Succeffully Added");
                                  // ignore: use_build_context_synchronously
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (c) => AdminMainPage()));
                                }).catchError((erorr) {
                                  showToast(
                                      context: context,
                                      text: "An Error  $erorr");
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
                uploadprovider.uploading == true
                    ? const LinearProgressIndicator(
                        backgroundColor: Colors.red,
                      )
                    : Container(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Column(
                    children: [
                      widget.isUPdate == true
                          ? Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xff008FA0),
                                      width: 1)),
                              child: GridView.builder(
                                itemCount: uploadprovider.imageUrls.length,
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
                                              uploadprovider.imageUrls[index]),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Provider.of<UploadGroupProvider>(
                                                  context,
                                                  listen: false)
                                              .removieImageUrl(index: index);
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
                                      color: const Color(0xff008FA0),
                                      width: 1)),
                              child: GridView.builder(
                                itemCount:
                                    uploadprovider.imagesListXfile.length,
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
                                            File(uploadprovider
                                                .imagesListXfile[index].path),
                                            height: 200,
                                            width: 200,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Provider.of<UploadGroupProvider>(
                                                  context,
                                                  listen: false)
                                              .removieImage(index: index);
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
                                    if (pickImage.isNotEmpty) {
                                      uploadprovider.imagesListXfile
                                          .addAll(pickImage);
                                      for (XFile imageFile in pickImage) {
                                        String fileName = DateTime.now()
                                            .millisecondsSinceEpoch
                                            .toString();
                                        Reference storageRef = FirebaseStorage
                                            .instance
                                            .ref()
                                            .child("groupimage")
                                            .child(fileName);
                                        // ignore: unused_local_variable
                                        TaskSnapshot uploadTask =
                                            await storageRef
                                                .putFile(File(imageFile.path));
                                        String imageUrl =
                                            await storageRef.getDownloadURL();
                                        uploadprovider.imageUrls.add(imageUrl);
                                      }
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
                                    if (pickImage.isNotEmpty) {
                                      uploadprovider.imagesListXfile
                                          .addAll(pickImage);
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
                      Form(
                        key: key,
                        child: Column(
                          children: [
                            TextFormFieldWidgetWithLable(
                              controller: nameTEC,
                              hintText: 'Tour Place Name',
                              icon: Icons.location_history,
                              validatorText: 'Field Not Emapy',
                              labelttext: 'Tour Place Name',
                            ),
                            TextFormFieldWidgetWithLable(
                              controller: locationTEC,
                              hintText: 'Location',
                              icon: Icons.place,
                              validatorText: 'Field Not Emapy',
                              labelttext: 'Location',
                            ),
                            TextFormFieldWidgetWithLable(
                              controller: durationTEC,
                              hintText: 'Duration',
                              icon: Icons.place,
                              validatorText: 'Field Not Emapy',
                              labelttext: 'Duration',
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
                              controller: rateTEC,
                              hintText: 'rate',
                              icon: Icons.rate_review_rounded,
                              validatorText: 'rate not Should be Empty',
                              labelttext: 'rate',
                            ),
                            TextFormFieldWidgetWithValid(
                              keyboardType: TextInputType.number,
                              controller: progressNumberTEC,
                              hintText: 'Progress number',
                              icon: Icons.rate_review_rounded,
                              validatorText: 'Progress not Should be Empty',
                              labelttext: 'progess',
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
                                      color: const Color(0xff008FA0),
                                      width: 1)),
                              child: DateTimePicker(
                                  type: DateTimePickerType.dateTime,
                                  dateHintText: "Select Tour Date and Time",
                                  icon: const Icon(
                                    Icons.event,
                                    color: Color(0xff008FA0),
                                  ),
                                  initialValue: uploadprovider.selectedDate,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                  onChanged: (val) {
                                    Provider.of<UploadGroupProvider>(context,
                                            listen: false)
                                        .setSelectedDate(date: val);
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Scaffold defaultScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Groups "),
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
            const SizedBox(
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
