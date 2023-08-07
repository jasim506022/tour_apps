import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:tour_apps/admin/home/searchpage.dart';
import 'package:tour_apps/user/chatroom/chatroompage.dart';
import 'package:tour_apps/user/profile/profilepages.dart';
import 'package:tour_apps/user/save/savetourpage.dart';
import 'package:tour_apps/user/widget/apis.dart';

import '../const/const.dart';
import 'home/homepage.dart';

// ignore: must_be_immutable
class MainPage extends StatefulWidget {
  MainPage({super.key, this.index});
  int? index;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    updatedata();
    FirebaseMessagingHelper.getFirebaseMessagingToken();
    super.initState();
  }

  var _currentIndex = 0;
  updatedata() async {
    try {
      var documentSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (documentSnapshot.exists) {
       
        // DateTime birthdayDate = documentSnapshot["birth"].t;
        // DateTime justDate =
        //     DateTime(birthdayDate.year, birthdayDate.month, birthdayDate.day);
        // String birthday = justDate.toString();
        // print("Bangladesh");

        await prefs!.setString("uid", documentSnapshot["uid"]);
        await prefs!.setString("username", documentSnapshot["name"]);
        await prefs!
            .setString("userprofession", documentSnapshot["profession"]);
        
        await prefs!.setString("useremail", documentSnapshot["email"]);
        await prefs!.setString("userimage", documentSnapshot["image"]);
        await prefs!.setString("userabout", documentSnapshot["about"]);
        await prefs!.setString("userphone", documentSnapshot["phone"]);
        await prefs!.setStringList(
            "savetour", List.from(documentSnapshot.data()!['savetour']));
        await prefs!.setStringList("savegrouptour",
            List.from(documentSnapshot.data()!['savegrouptour']));

          print(prefs!.getStringList("savetour")!);

        await prefs!.setStringList("bookingtour", []);

         print("Bangladesh");
        print(documentSnapshot["birth"]);

        var firebaseTimestamp = documentSnapshot["birth"];

        DateTime dateTime = firebaseTimestamp.toDate();
        DateTime justDate =
            DateTime(dateTime.year, dateTime.month, dateTime.day);
        String birthday = justDate.toString();

        print("DateTime from Firebase Timestamp: $dateTime");
        await prefs!.setString("userbirth", birthday);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching document data: $e');
      }
    }
  }

  var list = [
    const HomePage(),
    const SearchPage(),
    const ChatRoomPage(),
    const SaveTipsPage(),
    const ProfilePages(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: widget.index == null ? list[_currentIndex] : list[widget.index!],
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: widget.index == null ? _currentIndex : widget.index!,
          onTap: (i) => setState(() {
            _currentIndex = i;
            widget.index = null;
          }),
          items: [
            SalomonBottomBarItem(
                icon: const Icon(Icons.home),
                title: const Text("Home"),
                selectedColor: Theme.of(context).primaryColor,
                unselectedColor: unselectedColor),
            SalomonBottomBarItem(
                icon: const Icon(Ionicons.search),
                title: const Text("Search"),
                selectedColor: Theme.of(context).primaryColor,
                unselectedColor: unselectedColor),
            SalomonBottomBarItem(
                icon: const Icon(Ionicons.chatbox),
                title: const Text("Chat Room"),
                selectedColor: Theme.of(context).primaryColor,
                unselectedColor: unselectedColor),
            SalomonBottomBarItem(
                icon: const Icon(Ionicons.heart),
                title: const Text("Save"),
                selectedColor: Theme.of(context).primaryColor,
                unselectedColor: unselectedColor),
            SalomonBottomBarItem(
                icon: const Icon(Ionicons.person),
                title: const Text("Profile"),
                selectedColor: Theme.of(context).primaryColor,
                unselectedColor: unselectedColor),
          ],
        ),
      ),
    );
  }
}
