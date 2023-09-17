import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tour_apps/service/provider/loading_provider.dart';
import 'package:tour_apps/service/provider/upload_provider.dart';
import '../../../model/categoriesmodel.dart';
import '../../service/database/firebaseservice.dart';
import '../../widget/textfieldwidget.dart';
import '../../../admin/adminmainpage.dart';
import 'package:date_time_picker/date_time_picker.dart';
import '../../others/const.dart';
import '../../model/tourmodel.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import '../widget/update_image_widget.dart';
import '../widget/upload_image_widget.dart';

// ignore: must_be_immutable
class UploadTourPage extends StatefulWidget {
  UploadTourPage({super.key, this.isUpdate = false, this.tourModel});

  bool? isUpdate;
  TourModel? tourModel;

  @override
  State<UploadTourPage> createState() => _UploadTourPageState();
}

class _UploadTourPageState extends State<UploadTourPage> {
  TextEditingController placeNameEC = TextEditingController();
  TextEditingController rateEC = TextEditingController();
  TextEditingController locationEC = TextEditingController();
  TextEditingController costEC = TextEditingController();
  TextEditingController descriptionEC = TextEditingController();
  Timestamp? publishdate;
  String tourId = DateTime.now().millisecondsSinceEpoch.toString();
  var key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.isUpdate == true) {
      Future.delayed(Duration.zero, () {
        UploadProvider uploadProvider =
            Provider.of<UploadProvider>(context, listen: false);
        uploadProvider.setImageUrl(photo: []);
        placeNameEC.text = widget.tourModel!.tourname!;
        rateEC.text = widget.tourModel!.rate!;
        locationEC.text = widget.tourModel!.location!;
        costEC.text = widget.tourModel!.cost!;
        descriptionEC.text = widget.tourModel!.description!;
        tourId = widget.tourModel!.id!;
        publishdate = widget.tourModel!.publishdate!;
        uploadProvider.categorySet(cateory: widget.tourModel!.categoris!);
        uploadProvider.setSelectedDate(
            date: DateFormat('yyyy-MM-dd HH:mm:ss')
                .format(widget.tourModel!.tourdate!.toDate()));
        for (String images in widget.tourModel!.image!) {
          uploadProvider.getImageUrl.add(images);
          setState(() {});
        }
      });
    } else {
      Future.delayed(Duration.zero, () {
        UploadProvider uploadProvider =
            Provider.of<UploadProvider>(context, listen: false);
        uploadProvider.setImage(photo: []);
        uploadProvider.setImageUrl(photo: []);
        uploadProvider.categorySet(cateory: categoryAllString[1]);
      });
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

  @override
  Widget build(BuildContext context) {
    return Consumer<UploadProvider>(
      builder: (context, uploadprovider, child) {
        if (uploadprovider.getImagesListXFile.isEmpty &&
            widget.isUpdate == false) {
          return globalMethod.defaultScreen(context, "Add New Tour");
        }
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
              appBar: AppBar(
                title: widget.isUpdate == true
                    ? const Text("Update Tour")
                    : const Text("Add New Tour"),
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
                                      id: tourId,
                                      collection: "trip",
                                      map: {
                                        "tourname": placeNameEC.text.trim(),
                                        "location": locationEC.text.trim(),
                                        "rate": rateEC.text.trim(),
                                        "cost": costEC.text.trim(),
                                        "image": uploadprovider.getImageUrl,
                                        "categoris":
                                            uploadprovider.getCategoryName,
                                        "description":
                                            descriptionEC.text.trim(),
                                        "tourdate": DateTime.parse(
                                            uploadprovider.selectedDate),
                                        "publishdate": publishdate,
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
                              if (uploadprovider
                                  .getImagesListXFile.isNotEmpty) {
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
                                        .child("tripimage")
                                        .child(fileName);
                                    // ignore: unused_local_variable
                                    TaskSnapshot uploadTask = await storageRef
                                        .putFile(File(imageFile.path));
                                    String imageUrl =
                                        await storageRef.getDownloadURL();
                                    uploadprovider.getImageUrl.add(imageUrl);
                                  }
                                  FirebaseServices.addTour(
                                      id: tourId,
                                      collection: "trip",
                                      map: {
                                        "id": tourId,
                                        "tourname": placeNameEC.text.trim(),
                                        "location": locationEC.text.trim(),
                                        "rate": rateEC.text.trim(),
                                        "cost": costEC.text.trim(),
                                        "image": uploadprovider.getImageUrl,
                                        "categoris":
                                            uploadprovider.getCategoryName,
                                        "description":
                                            descriptionEC.text.trim(),
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
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
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
                                              .child("tripimage")
                                              .child(fileName);
                                          // ignore: unused_local_variable
                                          TaskSnapshot uploadTask =
                                              await storageRef.putFile(
                                                  File(imageFile.path));
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
                        DropdownButton<String>(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          underline: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 1)),
                          ),
                          dropdownColor: Theme.of(context).cardColor,
                          isExpanded: true,
                          value: uploadprovider.getCategoryName,
                          items: categoryAllString
                              .sublist(1, 6)
                              .map<DropdownMenuItem<String>>((e) {
                            return DropdownMenuItem<String>(
                              value: e,
                              child: Text(e),
                            );
                          }).toList(),
                          onChanged: (value) {
                            Provider.of<UploadProvider>(context, listen: false)
                                .categorySet(cateory: value!);
                          },
                          style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).primaryColor),
                        ),
                        Form(
                          key: key,
                          child: Column(
                            children: [
                              TextFormFieldWidgetWithLabel(
                                controller: placeNameEC,
                                hintText: 'Tour Place Name',
                                icon: Icons.location_history,
                                validatorText: 'Field Not Emapy',
                                labelttext: 'Tour Place Name',
                              ),
                              TextFormFieldWidgetWithLabel(
                                controller: locationEC,
                                hintText: 'Location',
                                icon: Icons.place,
                                validatorText: 'Field Not Emapy',
                                labelttext: 'Location',
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
                                controller: rateEC,
                                hintText: 'rate',
                                icon: Icons.rate_review_rounded,
                                validatorText: 'rate not Should be Empty',
                                labelttext: 'rate',
                              ),
                              TextFormFieldWidgetWithLabel(
                                controller: descriptionEC,
                                hintText: 'description',
                                maxLines: 5,
                                icon: Icons.description,
                                validatorText:
                                    'description not Should be Empty',
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
                                        color: Theme.of(context).primaryColor,
                                        width: 1)),
                                child: DateTimePicker(
                                    cursorColor: Colors.white,
                                    type: DateTimePickerType.dateTime,
                                    dateHintText: "Select Tour Date and Time",
                                    style: GoogleFonts.inter(
                                      fontSize: 15,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                    icon: Icon(Icons.event,
                                        color: Theme.of(context).primaryColor),
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
                        const SizedBox(
                          height: 150,
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}
