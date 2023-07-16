import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tour_apps/page/auth/loginpage.dart';
import 'package:tour_apps/page/profile/profilepage.dart';

import '../../const/const.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  // String? name, about, email, profession, date;

  // shareMetho() async {
  //   email =
  //   name = prefs!.getString('name');
  //   about = prefs!.getString('profession');
  //   profession = prefs!.getString('birth');
  //   date = prefs!.getString('about');
  // }

  String name = "";

  @override
  void initState() {
    // TODO: implement initState
    //updatedata();
    super.initState();
  }

  // DocumentSnapshot<Map<String, dynamic>>? user;

  // updatedata() async {
  //   await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(prefs!.getString('uid')!)
  //       .get()
  //       .then((value) {
  //     user = value;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: SingleChildScrollView(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("admin")
                .doc("admin")
                .snapshots(),
            builder: (context, snapshot) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilePage(),
                            ));
                      },
                      icon: const Icon(Icons.edit)),
                  Center(
                      child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 1)),
                    child: snapshot.data!["image"] == ""
                        ? Icon(
                            Icons.person,
                            size: 144,
                          )
                        : CircleAvatar(
                            radius: 72,
                            backgroundImage:
                                NetworkImage(snapshot.data!["image"])),
                  )),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(snapshot.data!["name"],
                      style: textStyle.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Hello",
                      style: textStyle.copyWith(
                          color: unselectedColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 15)),
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 4,
                    color: unselectedColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("About: ",
                      style: textStyle.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 18)),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(prefs!.getString('about') ?? "",
                      style: textStyle.copyWith(
                          color: unselectedColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 15)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Name: ",
                      style: textStyle.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 18)),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(prefs!.getString('name') ?? "",
                      style: textStyle.copyWith(
                          color: unselectedColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 15)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Profession: ",
                      style: textStyle.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 18)),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(prefs!.getString('profession') ?? "",
                      style: textStyle.copyWith(
                          color: unselectedColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 15)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Date of Birth: ",
                      style: textStyle.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 18)),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(prefs!.getString('birth') ?? "",
                      style: textStyle.copyWith(
                          color: unselectedColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 15)),
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(
                    height: 4,
                    color: unselectedColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ));
                    },
                    title: Text("Logout",
                        style: textStyle.copyWith(
                            color: unselectedColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 15)),
                    leading: const Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
