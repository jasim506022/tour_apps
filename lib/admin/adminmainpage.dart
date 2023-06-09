import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:tour_apps/const/const.dart';
import 'package:tour_apps/page/chatroom/chatroompage.dart';
import 'package:tour_apps/page/profile/profileedit.dart';
import 'package:tour_apps/page/save/savetipspage.dart';
import '../page/exployeer/group/grouptripspage.dart';
import 'home/homepageadmin.dart';

// ignore: must_be_immutable
class AdminMainPage extends StatefulWidget {
  AdminMainPage({super.key, this.index});

  int? index;

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  @override
  void initState() {
    super.initState();
  }

  var _selectedIndex = 0;
  final _widgetOptions = [
    const HomePageAdmin(),
    const GroupTripsPage(),
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
        body: widget.index == null
            ? _widgetOptions[_selectedIndex]
            : _widgetOptions[widget.index!],
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: widget.index == null ? _selectedIndex : widget.index!,
          onTap: (i) {
            setState(() {
              _selectedIndex = i;
              widget.index = null;
            });
          },
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
