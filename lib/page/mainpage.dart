import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:tour_apps/page/chatroom/chatroompage.dart';
import 'package:tour_apps/page/profile/profileedit.dart';
import 'package:tour_apps/page/profile/profilepage.dart';
import 'package:tour_apps/page/save/savetipspage.dart';

import '../const/const.dart';
import 'exployeer/exployerpage.dart';
import 'home/homepage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _currentIndex = 0;

  var list = [
    const ExployeerPage(),
    const ExployeerPage(),
    const ChatRoomPage(),
    const SaveTipsPage(),
    const ProfileEditPage()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: list[_currentIndex],
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            SalomonBottomBarItem(
                icon: const Icon(Icons.home),
                title: const Text("Home"),
                selectedColor: Theme.of(context).primaryColor,
                unselectedColor: unselectedColor),
            SalomonBottomBarItem(
                icon: const Icon(Ionicons.location_sharp),
                title: const Text("Exployre"),
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
