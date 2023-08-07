import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tour_apps/user/widget/loadingdialogwidget.dart';

import '../../const/const.dart';
import '../user/widget/textfieldwidget.dart';
import '../service/provider/registerprovider.dart';
import 'loginpage.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController emailEC = TextEditingController();
  TextEditingController passwordEC = TextEditingController();
  TextEditingController nameEC = TextEditingController();
  TextEditingController confirmpasswordEC = TextEditingController();

  var key = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    emailEC.dispose();
    passwordEC.dispose();
    nameEC.dispose();
    confirmpasswordEC.dispose();
    super.dispose();
  }

  String downloadurl = "";

  bottomSheet(RegisterProvider value) {
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
                Provider.of<RegisterProvider>(context, listen: false)
                    .setImage(ImageSource.camera);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.camera),
              label: const Text("Camera")),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton.icon(
              onPressed: () {
                Provider.of<RegisterProvider>(context, listen: false)
                    .setImage(ImageSource.gallery);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.image),
              label: const Text("Gallery")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Consumer<RegisterProvider>(
        builder: (context, value, child) {
          return Scaffold(
            body: Stack(
              children: [
                Positioned(
                    right: -100,
                    child: Image.asset(
                      "asset/image/ion_earth400.png",
                      color: Colors.blue.withOpacity(.07),
                      height: size.height * .45,
                      width: size.width,
                      fit: BoxFit.cover,
                    )),
                Positioned(
                    left: -100,
                    bottom: -50,
                    child: Image.asset(
                      "asset/image/ion_earth400.png",
                      color: Colors.blue.withOpacity(.07),
                      height: size.height * .45,
                      width: size.width,
                      fit: BoxFit.cover,
                    )),
                Container(
                  height: size.height,
                  width: size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 23, vertical: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Let’s start your\nJourney together!",
                          style: GoogleFonts.inter(
                              fontSize: 25,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              color: const Color.fromRGBO(30, 30, 30, 1)
                              //textStyle: TextStyle()
                              ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 3)),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => bottomSheet(value),
                              );
                            },
                            child: CircleAvatar(
                              radius: 72,
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              backgroundImage: value.image == null
                                  ? null
                                  : FileImage(File(value.image!.path)),
                              child: value.image == null
                                  ? const Icon(
                                      Icons.add_photo_alternate,
                                      color: Colors.grey,
                                      size: 72,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Form(
                          key: key,
                          child: Column(
                            children: [
                              TextFormFieldWidget(
                                controller: nameEC,
                                hintText: 'Enter Your name',
                                icon: Icons.person,
                                validatorText: 'Name is Empty',
                              ),
                              TextFormFieldWidget(
                                controller: emailEC,
                                hintText: 'Enter Your Email Address',
                                keyboardType: TextInputType.emailAddress,
                                icon: Icons.email,
                                validatorText: 'email is Empty',
                              ),
                              TextFormFieldWidget(
                                controller: passwordEC,
                                hintText: 'Enter Your Password',
                                obscureText: true,
                                icon: Icons.lock,
                                validatorText: 'password is Empty',
                              ),
                              TextFormFieldWidget(
                                controller: confirmpasswordEC,
                                hintText: 'Enter Your Confirm  Password',
                                obscureText: true,
                                textInputAction: TextInputAction.done,
                                icon: Icons.lock,
                                validatorText: 'Confirm is Empty',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: size.width,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff008FA0),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10)),
                              onPressed: () {
                                registrationForm(value);
                              },
                              child: Text(
                                "Sign Up",
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
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                              text: 'Already have an Account? ',
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1,
                                  color: const Color.fromARGB(255, 36, 36, 36)
                                  //textStyle: TextStyle()
                                  ),
                            ),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const LoginPage(),
                                      ));
                                },
                              text: 'Sign in',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                                decoration: TextDecoration.underline,
                                color: const Color.fromARGB(255, 36, 36, 36),
                              ),
                            )
                          ])),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void registrationForm(RegisterProvider value) async {
    if (value.image == null) {
      //image is not selected
      showToast(context: context, text: 'Please Selected Image');
    } else {
      if (key.currentState!.validate()) {
        if (passwordEC.text.trim() == confirmpasswordEC.text.trim()) {
          showDialog(
            context: context,
            builder: (context) {
              return const LoadingDialogWidget(
                  message: "Registering your account");
            },
          );

          //1. upload image to firestorage
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          Reference storageRef = FirebaseStorage.instance
              .ref()
              .child("usersImage")
              .child(fileName);

          // Upload
          UploadTask uploadTask = storageRef.putFile(File(value.image!.path));
          TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
          await taskSnapshot.ref.getDownloadURL().then((value) {
            downloadurl = value;
          });

          // 2. save the user infor to firestore database

          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: emailEC.text.trim(), password: passwordEC.text.trim())
              .then((value) {
            FirebaseFirestore.instance
                .collection("users")
                .doc(value.user!.uid)
                .set({
              "uid": value.user!.uid,
              "email": emailEC.text.trim(),
              "password": passwordEC.text.trim(),
              "image": downloadurl,
              "name": nameEC.text.trim(),
              "profession": "junior developer",
              "birth": "15/12/1998",
              "about": "about",
              "status": "approved",
            });
          }).catchError((errorMessage) {
            showToast(
                context: context, text: "Error Occured : \n $errorMessage");
          });

          // ignore: use_build_context_synchronously
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ));

          // ignore: use_build_context_synchronously
          showToast(context: context, text: 'Registration Succesffully');
        } else {
          Navigator.pop(context);
          showToast(
              context: context,
              text: 'Password and Confirm Password Does not Same');
        }
      }
    }
  }
}
