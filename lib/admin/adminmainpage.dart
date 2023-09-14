import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:tour_apps/service/database/firebaseservice.dart';
import '../service/other/local_service.dart';
import '../service/other/pushnotificationmessage.dart';
import 'alluser/alluserpage.dart';
import 'group/grouptouradminpage.dart';
import 'home/homeadminpage.dart';
import 'profile/profilepagesadmin.dart';

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
    LocalServiceNotfication.initializeAdmin(context);
    PushNotificationMessage notificationMessage = PushNotificationMessage();
    FirebaseServices.getFcmToken(
      collection: "admin",
      doc: 'admin',
      deviceToken: 'admindivecetoken',
      
    );
    notificationMessage.requestNotificationPermission();
    notificationMessage.initMessageInforAdmin(context);
    FirebaseServices.adminSharePrefernceDataSet();
  }

  var _selectedIndex = 0;
  final _widgetOptions = [
    const HomeAdminPage(),
    const GroupTourAdminPage(),
    const AllUserPage(),
    const ProfilePageAdmin()
  ];

  @override
  Widget build(BuildContext context) {
     SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).scaffoldBackgroundColor,
        statusBarIconBrightness: Theme.of(context).colorScheme.brightness,
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        systemNavigationBarIconBrightness:
            Theme.of(context).colorScheme.brightness,
      ),
    );
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
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
                unselectedColor: Theme.of(context).hintColor),
            SalomonBottomBarItem(
                icon: const Icon(Icons.featured_play_list),
                title: const Text("Group Tour"),
                selectedColor: Theme.of(context).primaryColor,
                unselectedColor: Theme.of(context).hintColor),
            SalomonBottomBarItem(
                icon: const Icon(Icons.people),
                title: const Text("All User"),
                selectedColor: Theme.of(context).primaryColor,
                unselectedColor: Theme.of(context).hintColor),
            SalomonBottomBarItem(
                icon: const Icon(Icons.account_circle),
                title: const Text("Profile"),
                selectedColor: Theme.of(context).primaryColor,
                unselectedColor: Theme.of(context).hintColor),
          ],
        ),
      ),
    );
  }
}
