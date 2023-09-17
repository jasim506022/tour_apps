import 'dart:io';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tour_apps/others/utilies.dart';
import 'package:tour_apps/service/database/firebaseservice.dart';
import 'package:tour_apps/service/provider/image_upload_provider.dart';
import 'package:tour_apps/service/provider/loading_provider.dart';

import 'package:tour_apps/widget/textfieldwidget.dart';
import '../../others/const.dart';

import '../adminmainpage.dart';

// ignore: must_be_immutable
class EditProfilePageAdmin extends StatefulWidget {
  EditProfilePageAdmin({super.key, this.isEditProfile = false});
  bool? isEditProfile;
  @override
  State<EditProfilePageAdmin> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<EditProfilePageAdmin> {
  String downloadurl = "";

  String dateValue = prefs!.getString('adminbirth')!;

  TextEditingController nameEC = TextEditingController();
  TextEditingController emailEC = TextEditingController();
  TextEditingController prefessionEC = TextEditingController();
  TextEditingController phoneEC = TextEditingController();
  TextEditingController descriptionEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<ImageUploadProvider>(context, listen: false).setImage(null);
    });
    nameEC.text = prefs!.getString('adminname') ?? "";
    emailEC.text = prefs!.getString('adminemail') ?? "";
    prefessionEC.text = prefs!.getString('adminprofession') ?? "";
    phoneEC.text = prefs!.getString('adminphone') ?? "";
    descriptionEC.text = prefs!.getString('adminabout') ?? "";
  }

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    return Scaffold(body: Consumer<ImageUploadProvider>(
        builder: (context, imageUploadProvider, child) {
      return ListView(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).primaryColor,
              ),
              Positioned(
                top: 100,
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 8)),
                  child: imageUploadProvider.imageFile == null
                      ? CircleAvatar(
                          backgroundImage:
                              NetworkImage(prefs!.getString("adminimage")!),
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(
                              File(imageUploadProvider.imageFile!.path)),
                        ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 140, top: 50),
            child: Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => globalMethod.bottomSheet(context),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300, shape: BoxShape.circle),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              children: [
                TextFormFieldWidget(
                  controller: nameEC,
                  hintText: 'Name',
                  icon: Icons.person,
                  validatorText: '',
                  enabled: widget.isEditProfile! ? true : false,
                ),
                TextFormFieldWidget(
                  controller: emailEC,
                  hintText: 'Email',
                  icon: Icons.email,
                  validatorText: '',
                  enabled: widget.isEditProfile! ? true : false,
                ),
                const SizedBox(
                  height: 15,
                ),
                widget.isEditProfile!
                    ? Container(
                        padding: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                            )),
                        child: DateTimePicker(
                            enabled: widget.isEditProfile! ? true : false,
                            type: DateTimePickerType.date,
                            dateHintText: "Select Tour Date and Time",
                            icon: Icon(
                              Icons.event,
                              color: Theme.of(context).primaryColor,
                            ),
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            initialValue: dateValue,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                            onChanged: (val) {
                              setState(() {
                                dateValue = val;
                              });
                            }),
                      )
                    : DateTimePicker(
                        enabled: false,
                        type: DateTimePickerType.date,
                        dateHintText: "Select Tour Date and Time",
                        icon: Icon(
                          Icons.event,
                          color: Theme.of(context).primaryColor,
                        ),
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        initialValue: dateValue,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        onChanged: (val) {
                          setState(() {
                            dateValue = val;
                          });
                        }),
                TextFormFieldWidget(
                  keyboardType: TextInputType.number,
                  controller: phoneEC,
                  hintText: 'Phone Number',
                  icon: Icons.phone,
                  validatorText: '',
                  enabled: widget.isEditProfile! ? true : false,
                ),
                TextFormFieldWidget(
                  keyboardType: TextInputType.number,
                  controller: prefessionEC,
                  hintText: 'Profession',
                  icon: Icons.work,
                  validatorText: '',
                  enabled: widget.isEditProfile! ? true : false,
                ),
                TextFormFieldWidget(
                  controller: descriptionEC,
                  maxLines: 5,
                  hintText: 'description',
                  icon: Icons.abc,
                  validatorText: '',
                  enabled: widget.isEditProfile! ? true : false,
                ),
                const SizedBox(
                  height: 15,
                ),
                Consumer<LoadingProvider>(
                  builder: (context, loadingProvider, child) {
                    return widget.isEditProfile!
                        ? SizedBox(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.secondary,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 30)),
                                onPressed: () async {
                                  if (imageUploadProvider.imageFile == null) {
                                    loadingProvider.setUploading(value: true);

                                    FirebaseServices.updateData(
                                        id: "admin",
                                        collection: "admin",
                                        map: {
                                          "name": nameEC.text.trim(),
                                          "about": descriptionEC.text.trim(),
                                          "profession":
                                              prefessionEC.text.trim(),
                                          "phone": phoneEC.text.trim(),
                                          "email": emailEC.text.trim(),
                                          "birth": dateValue,
                                        }).then((value) async {
                                      await prefs!.setString(
                                          "adminname", nameEC.text.trim());
                                      await prefs!.setString("adminprofession",
                                          prefessionEC.text.trim());
                                      await prefs!
                                          .setString("adminbirth", dateValue);
                                      await prefs!.setString(
                                          "adminemail", emailEC.text.trim());
                                      await prefs!.setString("adminabout",
                                          descriptionEC.text.trim());
                                      await prefs!.setString(
                                        "adminphone",
                                        phoneEC.text.trim(),
                                      );
                                    });
                                  } else {
                                    //1. upload image to firestorage
                                    loadingProvider.setUploading(value: true);
                                    String fileName = DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString();
                                    Reference storageRef = FirebaseStorage
                                        .instance
                                        .ref()
                                        .child("adminimage")
                                        .child(fileName);

                                    // Upload Image
                                    UploadTask uploadTask = storageRef.putFile(
                                        File(imageUploadProvider
                                            .imageFile!.path));
                                    TaskSnapshot taskSnapshot =
                                        await uploadTask.whenComplete(() {});
                                    await taskSnapshot.ref
                                        .getDownloadURL()
                                        .then((value) {
                                      downloadurl = value;
                                      setState(() {});
                                    });

                                    FirebaseServices.updateData(
                                        id: "admin",
                                        collection: "admin",
                                        map: {
                                          "name": nameEC.text.trim(),
                                          "about": descriptionEC.text.trim(),
                                          "profession":
                                              prefessionEC.text.trim(),
                                          "phone": phoneEC.text.trim(),
                                          "email": emailEC.text.trim(),
                                          "birth": dateValue,
                                          "image": downloadurl
                                        }).then((value) async {
                                      await prefs!.setString(
                                          "adminname", nameEC.text.trim());
                                      await prefs!.setString("adminprofession",
                                          prefessionEC.text.trim());
                                      await prefs!
                                          .setString("adminbirth", dateValue);
                                      await prefs!.setString(
                                          "adminemail", emailEC.text.trim());
                                      await prefs!.setString("adminabout",
                                          descriptionEC.text.trim());
                                      await prefs!.setString(
                                          "adminphone", phoneEC.text.trim());
                                      await prefs!
                                          .setString("adminimage", downloadurl);
                                    });
                                  }
                                  loadingProvider.setUploading(value: false);

                                  // ignore: use_build_context_synchronously
                                  showToast(
                                      context: context, text: "Update Profile");

                                  // ignore: use_build_context_synchronously
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AdminMainPage(index: 3),
                                      ));
                                },
                                child: loadingProvider.getUploading == true
                                    ? const CircularProgressIndicator()
                                    : Text(
                                        "Update",
                                        style: GoogleFonts.inter(
                                            fontSize: 15,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 1.2,
                                            color: utils.getColor
                                            //textStyle: TextStyle()
                                            ),
                                      )),
                          )
                        : Container();
                  },
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      );
    }));
  }
}
