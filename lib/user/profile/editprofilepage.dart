import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tour_apps/user/widget/textfieldwidget.dart';
import '../../const/const.dart';
import '../mainpage.dart';
import '../widget/textfieldwidget copy.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<EditProfilePage> {
  String downloadurl = "";

  ImagePicker picker = ImagePicker();
  XFile? imageFile;

  String dateValue = prefs!.getString('userbirth')!;

  TextEditingController nameEC = TextEditingController();
  TextEditingController emailEC = TextEditingController();
  TextEditingController prefessionEC = TextEditingController();
  TextEditingController phoneEC = TextEditingController();
  TextEditingController descriptionEC = TextEditingController();

  @override
  void initState() {
    super.initState();

    nameEC.text = prefs!.getString('username') ?? "";
    emailEC.text = prefs!.getString('useremail') ?? "";
    prefessionEC.text = prefs!.getString('userprofession') ?? "";
    phoneEC.text = prefs!.getString('userphone') ?? "";
    descriptionEC.text = prefs!.getString('userabout') ?? "";

    if (kDebugMode) {
      print(prefs!.get("userbirth") ?? "Bangladesh");
    }
  }

  bool isUploading = false;

  takePhoto(ImageSource source) async {
    final pickIfile = await picker.pickImage(source: source);

    setState(() {
      imageFile = pickIfile;
      Navigator.pop(context);
    });
  }

  bottomSheet() {
    return AlertDialog(
      title: const Text(
        "Choose Profile, Photo",
        style: TextStyle(fontSize: 20),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              icon: const Icon(Icons.camera),
              label: const Text("Camera")),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton.icon(
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              icon: const Icon(Icons.image),
              label: const Text("Gallery")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: ListView(
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
                    border: Border.all(color: Colors.white, width: 8)),
                child: imageFile == null
                    ? CircleAvatar(
                        backgroundImage:
                            NetworkImage(prefs!.getString("userimage")!),
                      )
                    : CircleAvatar(
                        backgroundImage: FileImage(File(imageFile!.path)),
                      ),
              ),
            ),
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
                  builder: (context) => bottomSheet(),
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
              ),
              TextFormFieldWidget(
                controller: emailEC,
                hintText: 'Email',
                icon: Icons.email,
                validatorText: '',
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border:
                        Border.all(color: const Color(0xff008FA0), width: 1)),
                child: DateTimePicker(
                    type: DateTimePickerType.date,
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
                        color: const Color.fromRGBO(30, 30, 30, 1)),
                    initialValue: dateValue,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    onChanged: (val) {
                      setState(() {
                        dateValue = val;
                      });
                    }),
              ),
              TextFormFieldWidget(
                keyboardType: TextInputType.number,
                controller: phoneEC,
                hintText: 'Phone Number',
                icon: Icons.person,
                validatorText: '',
              ),
              TextFormFieldWidget(
                keyboardType: TextInputType.number,
                controller: prefessionEC,
                hintText: 'Profession',
                icon: Icons.person,
                validatorText: '',
              ),
              TextFormFieldWidget(
                controller: descriptionEC,
                maxLines: 5,
                hintText: 'description',
                icon: Icons.abc,
                validatorText: '',
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 30)),
                    onPressed: () async {
                      if (imageFile == null) {
                        isUploading == true;
                        setState(() {});
                        FirebaseFirestore.instance
                            .collection("users")
                            .doc(prefs!.getString("uid")!)
                            .update({
                          "name": nameEC.text.trim(),
                          "about": descriptionEC.text.trim(),
                          "profession": prefessionEC.text.trim(),
                          "phone": phoneEC.text.trim(),
                          "email": emailEC.text.trim(),
                          "birth": dateValue,
                        }).then((value) async {
                          await prefs!
                              .setString("username", nameEC.text.trim());
                          await prefs!.setString(
                              "userprofession", prefessionEC.text.trim());
                          await prefs!.setString("userbirth", dateValue);
                          await prefs!
                              .setString("useremail", emailEC.text.trim());

                          await prefs!.setString(
                              "userabout", descriptionEC.text.trim());
                          await prefs!.setString(
                            "userphone",
                            phoneEC.text.trim(),
                          );
                        });
                      } else {
                        //1. upload image to firestorage
                        isUploading == true;
                        setState(() {});
                        String fileName =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        Reference storageRef = FirebaseStorage.instance
                            .ref()
                            .child("adminimage")
                            .child(fileName);

                        // Upload
                        UploadTask uploadTask =
                            storageRef.putFile(File(imageFile!.path));
                        TaskSnapshot taskSnapshot =
                            await uploadTask.whenComplete(() {});
                        await taskSnapshot.ref.getDownloadURL().then((value) {
                          downloadurl = value;
                        });
                        FirebaseFirestore.instance
                            .collection("users")
                            .doc(prefs!.getString("uid")!)
                            .update({
                          "name": nameEC.text.trim(),
                          "about": descriptionEC.text.trim(),
                          "profession": prefessionEC.text.trim(),
                          "phone": phoneEC.text.trim(),
                          "email": emailEC.text.trim(),
                          "birth": dateValue,
                          "image": downloadurl
                        }).then((value) async {
                          await prefs!
                              .setString("username", nameEC.text.trim());
                          await prefs!.setString(
                              "userprofession", prefessionEC.text.trim());
                          await prefs!.setString("userbirth", dateValue);
                          await prefs!
                              .setString("useremail", emailEC.text.trim());

                          await prefs!.setString(
                              "userabout", descriptionEC.text.trim());
                          await prefs!
                              .setString("userphone", phoneEC.text.trim());
                          await prefs!.setString("userimage", downloadurl);
                        });
                      }
                      isUploading == false;
                      setState(() {});
                      // ignore: use_build_context_synchronously
                      showToast(context: context, text: "Update Profile");

                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(index: 4),
                          ));
                    },
                    child: isUploading == true
                        ? const CircularProgressIndicator()
                        : Text(
                            "Update",
                            style: GoogleFonts.inter(
                                fontSize: 15,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.2,
                                color: Colors.white
                                //textStyle: TextStyle()
                                ),
                          )),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    )

        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        //   child: SingleChildScrollView(
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Center(
        //           child: Stack(
        //             children: [
        //               imageFile == null
        //                   ? CircleAvatar(
        //                       radius: 72,
        //                       backgroundImage: NetworkImage(imageInit))
        //                   :
        //                   //: Container(),
        //                   CircleAvatar(
        //                       radius: 72,
        //                       backgroundImage: FileImage(File(imageFile!.path)),
        //                     ),
        //               Positioned(
        //                   bottom: 20,
        //                   right: 20,
        //                   child: InkWell(
        //                     onTap: () {
        //                       showDialog(
        //                         context: context,
        //                         builder: (context) => bottomSheet(),
        //                       );
        //                     },
        //                     child: const Icon(
        //                       Icons.camera_alt,
        //                       color: Colors.white,
        //                       size: 30,
        //                     ),
        //                   ))
        //             ],
        //           ),
        //         ),
        //         const SizedBox(
        //           height: 15,
        //         ),

        //
        //
        //
        // ],
        //     ),
        //   ),
        // ),

        );
  }
}

//

//  Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton.icon(
//                   onPressed: () {
//                     takePhoto(ImageSource.camera);
//                   },
//                   icon: const Icon(Icons.camera),
//                   label: const Text("Camera")),
//               ElevatedButton.icon(
//                   onPressed: () {
//                     takePhoto(ImageSource.gallery);
//                   },
//                   icon: const Icon(Icons.image),
//                   label: const Text("Gallery")),
//             ],
//           )
