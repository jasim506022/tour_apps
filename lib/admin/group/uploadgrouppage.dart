import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tour_apps/model/grouptipmodel.dart';
import 'package:tour_apps/service/database/firebaseservice.dart';

import '../../service/provider/loading_provider.dart';
import '../../service/provider/upload_provider.dart';
import '../../widget/textfieldwidget.dart';
import '../../../admin/adminmainpage.dart';
import '../../others/const.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import '../widget/update_image_widget.dart';
import '../widget/upload_image_widget.dart';

// ignore: must_be_immutable
class UploadGroupPage extends StatefulWidget {
  UploadGroupPage({super.key, this.isUpdate, this.groupTourModel});

  bool? isUpdate;
  GroupTourModel? groupTourModel;

  @override
  State<UploadGroupPage> createState() => _UploadGroupPageState();
}

class _UploadGroupPageState extends State<UploadGroupPage> {
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
  Timestamp? publishdate;

  @override
  void initState() {
    super.initState();

    if (widget.isUpdate == true) {
      Future.delayed(Duration.zero, () {
        var myData = Provider.of<UploadProvider>(context, listen: false);
        myData.setImageUrl(photo: []);
        nameTEC.text = widget.groupTourModel!.tourname!;
        rateTEC.text = widget.groupTourModel!.rate!.toString();
        locationTEC.text = widget.groupTourModel!.location!.toString();
        costEC.text = widget.groupTourModel!.cost!.toString();
        descriptionEC.text = widget.groupTourModel!.description!;
        durationTEC.text = widget.groupTourModel!.duration!;
        progressNumberTEC.text = widget.groupTourModel!.bookingsit!.toString();
        groupId = widget.groupTourModel!.id!;
        publishdate = widget.groupTourModel!.publishdate!;
        myData.setSelectedDate(
            date: DateFormat('yyyy-MM-dd HH:mm:ss')
                .format(widget.groupTourModel!.tourdate!.toDate()));
        for (String images in widget.groupTourModel!.image!) {
          myData.getImageUrl.add(images);
          setState(() {});
        }

        // Access the value of myData here
      });
    } else {
      Future.delayed(Duration.zero, () {
        var myData = Provider.of<UploadProvider>(context, listen: false);
        myData.setImage(photo: []);
        myData.setImageUrl(photo: []);
        myData.setSelectedDate(date: DateTime.now().toString());
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

  @override
  Widget build(BuildContext context) {
    return Consumer<UploadProvider>(
      builder: (context, uploadprovider, child) {
        if (uploadprovider.getImagesListXFile.isEmpty &&
            widget.isUpdate == false) {
          return globalMethod.defaultScreen(context, "Add New Group Tour");
        }
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              title: widget.isUpdate == true
                  ? const Text("Update Group Tour")
                  : const Text("Upload New Group Tour"),
              actions: [
                IconButton(
                    onPressed: widget.isUpdate == true
                        ? () async {
                            if (uploadprovider.getImageUrl.isNotEmpty) {
                              if (key.currentState!.validate()) {
                                Provider.of<LoadingProvider>(context,
                                        listen: false)
                                    .setUploading(value: true);

                                FirebaseServices.updateData(
                                    id: groupId,
                                    collection: "grouptrips",
                                    map: {
                                      "tourname": nameTEC.text.trim(),
                                      "location": locationTEC.text.trim(),
                                      "rate": double.parse(rateTEC.text.trim()),
                                      "cost": double.parse(costEC.text.trim()),
                                      "bookingsit": double.parse(
                                          progressNumberTEC.text.trim()),
                                      "image": uploadprovider.getImageUrl,
                                      "duration": durationTEC.text.trim(),
                                      "description": descriptionEC.text.trim(),
                                      "tourdate": DateTime.parse(
                                          uploadprovider.selectedDate),
                                      "publishdate": publishdate,
                                    }).then((value) {
                                  Provider.of<LoadingProvider>(context,
                                          listen: false)
                                      .setUploading(value: false);
                                  showToast(
                                      context: context,
                                      text: "Succeffully Update");
                                  // ignore: use_build_context_synchronously
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (c) => AdminMainPage(
                                                index: 1,
                                              )));
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
                            if (uploadprovider.getImagesListXFile.isNotEmpty) {
                              if (key.currentState!.validate()) {
                                Provider.of<LoadingProvider>(context,
                                        listen: false)
                                    .setUploading(value: true);
                                for (XFile imageFile
                                    in uploadprovider.getImagesListXFile) {
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
                                  uploadprovider.getImageUrl.add(imageUrl);
                                }

                                FirebaseServices.addTour(
                                    id: groupId,
                                    collection: "grouptrips",
                                    map: {
                                      "id": groupId,
                                      "tourname": nameTEC.text.trim(),
                                      "location": locationTEC.text.trim(),
                                      "rate": double.parse(rateTEC.text.trim()),
                                      "cost": double.parse(costEC.text.trim()),
                                      "bookingsit": double.parse(
                                          progressNumberTEC.text.trim()),
                                      "image": uploadprovider.getImageUrl,
                                      "duration": durationTEC.text.trim(),
                                      "description": descriptionEC.text.trim(),
                                      "tourdate": DateTime.parse(
                                          uploadprovider.selectedDate),
                                      "publishdate": DateTime.now(),
                                    }).then((value) {
                                  Provider.of<LoadingProvider>(context,
                                          listen: false)
                                      .setUploading(value: false);
                                  showToast(
                                      context: context,
                                      text: "Succeffully Added");
                                  // ignore: use_build_context_synchronously
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (c) => AdminMainPage(
                                                index: 1,
                                              )));
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
                Consumer<LoadingProvider>(
                  builder: (context, value, child) {
                    return value.getUploading == true
                        ? const LinearProgressIndicator(
                            backgroundColor: Colors.red,
                          )
                        : Container();
                  },
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Column(
                    children: [
                      widget.isUpdate == true
                          ? UpdateImageWidget(
                              uploadprovider: uploadprovider,
                            )
                          : UploadImageWidget(uploadprovider: uploadprovider),
                      const SizedBox(
                        height: 7,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff008FA0)),
                            onPressed: widget.isUpdate == true
                                ? () async {
                                    final List<XFile> pickImage =
                                        await globalMethod.imagePicker
                                            .pickMultiImage();
                                    if (pickImage.isNotEmpty) {
                                      uploadprovider.getImagesListXFile
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
                                        uploadprovider.getImageUrl
                                            .add(imageUrl);
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
                                        await globalMethod.imagePicker
                                            .pickMultiImage();
                                    if (pickImage.isNotEmpty) {
                                      uploadprovider.getImagesListXFile
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
                            TextFormFieldWidgetWithLabel(
                              controller: nameTEC,
                              hintText: 'Tour Place Name',
                              icon: Icons.location_history,
                              validatorText: 'Field Not Emapy',
                              labelttext: 'Tour Place Name',
                            ),
                            TextFormFieldWidgetWithLabel(
                              controller: locationTEC,
                              hintText: 'Location',
                              icon: Icons.place,
                              validatorText: 'Field Not Emapy',
                              labelttext: 'Location',
                            ),
                            TextFormFieldWidgetWithLabel(
                              controller: durationTEC,
                              hintText: 'Duration',
                              icon: Icons.place,
                              validatorText: 'Field Not Emapy',
                              labelttext: 'Duration',
                            ),
                            TextFormFieldWidgetWithLabel(
                              keyboardType: TextInputType.number,
                              controller: costEC,
                              hintText: 'Cost',
                              icon: Icons.money,
                              validatorText: 'Field Not Emapy',
                              labelttext: 'cost',
                            ),
                            TextFormFieldWidgetWithLabel(
                              keyboardType: TextInputType.number,
                              controller: rateTEC,
                              hintText: 'rate',
                              icon: Icons.rate_review_rounded,
                              validatorText: 'rate not Should be Empty',
                              labelttext: 'rate',
                            ),
                            TextFormFieldWidgetWithLabel(
                              keyboardType: TextInputType.number,
                              controller: progressNumberTEC,
                              hintText: 'Progress number',
                              icon: Icons.rate_review_rounded,
                              validatorText: 'Progress not Should be Empty',
                              labelttext: 'progess',
                            ),
                            TextFormFieldWidgetWithLabel(
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
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  initialValue: uploadprovider.selectedDate,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                  onChanged: (val) {
                                    Provider.of<UploadProvider>(context,
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
}
