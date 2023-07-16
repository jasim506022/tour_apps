import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tour_apps/page/mainpage.dart';
import '../../const/const.dart';
import '../../widget/textfieldwidget copy.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String imageInit = "";

  updatedata() async {
    var document =
        await FirebaseFirestore.instance.collection("admin").doc("admin").get();
    print(nameEC.text = document["name"]);
    print(prefessionalEC.text = document["profession"]);
    print(dateofbirthEC.text = document["birth"]);
    print(descriptionEC.text = document["about"]);
    print(imageInit = document["image"]);
  }

  ImagePicker picker = ImagePicker();
  XFile? imageFile;

  TextEditingController nameEC = TextEditingController();
  TextEditingController prefessionalEC = TextEditingController();
  TextEditingController dateofbirthEC = TextEditingController();
  TextEditingController descriptionEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    updatedata();
  }

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
      appBar: AppBar(
        title: const Text("Update Profile"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    imageFile == null
                        ? CircleAvatar(
                            radius: 72,
                            backgroundImage: NetworkImage(imageInit))
                        :
                        //: Container(),
                        CircleAvatar(
                            radius: 72,
                            backgroundImage: FileImage(File(imageFile!.path)),
                          ),
                    Positioned(
                        bottom: 20,
                        right: 20,
                        child: InkWell(
                          onTap: () {
                            print(image ?? "BAngladesh");
                            showDialog(
                              context: context,
                              builder: (context) => bottomSheet(),
                            );
                          },
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 30,
                          ),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormFieldWidgetWithLable(
                controller: nameEC,
                hintText: 'Name',
                icon: Icons.person,
                validatorText: '',
                labelttext: prefs!.getString('name') ?? "",
              ),
              TextFormFieldWidgetWithLable(
                controller: prefessionalEC,
                hintText: 'Profession',
                icon: Icons.person,
                validatorText: '',
                labelttext: prefs!.getString('profession') ?? "",
              ),
              TextFormFieldWidgetWithLable(
                controller: dateofbirthEC,
                hintText: 'Date of Birth',
                labelttext: prefs!.getString('birth') ?? "",
                icon: Icons.person,
                validatorText: '',
              ),
              TextFormFieldWidgetWithLable(
                controller: descriptionEC,
                maxLines: 5,
                hintText: 'description',
                icon: Icons.abc,
                validatorText: '',
                labelttext: prefs!.getString('about') ?? "",
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: size.width,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff008FA0),
                        padding: const EdgeInsets.symmetric(vertical: 10)),
                    onPressed: () async {
                      //1. upload image to firestorage
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
                        imageInit = value;
                      });
                      FirebaseFirestore.instance
                          .collection("admin")
                          .doc("admin")
                          .update({
                        "name": nameEC.text.trim(),
                        "about": descriptionEC.text.trim(),
                        "profession": prefessionalEC.text.trim(),
                        "birth": dateofbirthEC.text.trim(),
                        "image": imageInit
                      });
                      showToast(context: context, text: "Update Profile");

                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainPage(),
                          ));
                    },
                    child: Text(
                      "Save",
                      style: GoogleFonts.inter(
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                          color: Colors.white
                          //textStyle: TextStyle()
                          ),
                    )),
              ),
            ],
          ),
        ),
      ),
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
