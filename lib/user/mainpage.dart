import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:tour_apps/service/provider/categoriesprovider.dart';
import 'package:tour_apps/user/page/save/savetourpage.dart';
import 'package:tour_apps/user/page/search/searchuserpage.dart';

import 'package:tour_apps/service/other/local_service.dart';
import 'package:tour_apps/service/other/pushnotificationmessage.dart';
import '../others/textstyle.dart';
import '../model/categoriesmodel.dart';
import '../service/database/firebaseservice.dart';
import 'page/home/homepage.dart';
import 'page/profile/profilepagesuser.dart';

// ignore: must_be_immutable
class MainPage extends StatefulWidget {
  MainPage({super.key, this.index});
  int? index;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _currentIndex = 0;
  String? tokens;

  @override
  void initState() {
    LocalServiceNotfication.initializeuser(context);
    PushNotificationMessage message = PushNotificationMessage();
    message.requestNotificationPermission();
    message.initMessageInforUser(context);
    FirebaseServices.userSharePrefenceDataSet();
    FirebaseServices.getFcmToken(
      collection: "users",
      doc: FirebaseAuth.instance.currentUser!.uid,
      deviceToken: 'userDiveceToken',
    );

     Future.delayed(Duration.zero, () {
      var categoriesprovider =
          Provider.of<CategoriesProvider>(context, listen: false);
      categoriesprovider.setCategory(cateory: categories[0].name);
      categoriesprovider.setIndex(index: 0);
    });
    super.initState();
  }

  var menuList = [
    const HomePage(),
    SearchUserPage(),
    const SaveTipsPage(),
    const ProfilePageUser(),
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
            ? menuList[_currentIndex]
            : menuList[widget.index!],
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: widget.index == null ? _currentIndex : widget.index!,
          onTap: (i) => setState(() {
            _currentIndex = i;
            widget.index = null;
          }),
          items: [
            SalomonBottomBarItem(
                icon: const Icon(Icons.home),
                title: Text("Home", style: bottomBarItemTextStyle),
                selectedColor: Theme.of(context).primaryColor,
                unselectedColor: Theme.of(context).hintColor),
            SalomonBottomBarItem(
                icon: const Icon(Ionicons.search),
                title: Text("Search", style: bottomBarItemTextStyle),
                selectedColor: Theme.of(context).primaryColor,
                unselectedColor: Theme.of(context).hintColor),
            SalomonBottomBarItem(
                icon: const Icon(Ionicons.heart),
                title: Text("Save", style: bottomBarItemTextStyle),
                selectedColor: Theme.of(context).primaryColor,
                unselectedColor: Theme.of(context).hintColor),
            SalomonBottomBarItem(
                icon: const Icon(Ionicons.person),
                title: Text("Profile", style: bottomBarItemTextStyle),
                selectedColor: Theme.of(context).primaryColor,
                unselectedColor: Theme.of(context).hintColor),
          ],
        ),
      ),
    );
  }
}
