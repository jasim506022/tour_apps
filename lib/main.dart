import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tour_apps/service/provider/categoriesprovider.dart';
import 'package:tour_apps/service/provider/details_provider.dart';
import 'package:tour_apps/service/provider/droop_category_provider.dart';
import 'package:tour_apps/service/provider/image_upload_provider.dart';
import 'package:tour_apps/service/provider/loading_provider.dart';
import 'package:tour_apps/service/provider/locationprovider.dart';
import 'package:tour_apps/service/provider/search_provider.dart';
import 'package:tour_apps/service/provider/themeprovider.dart';
import 'package:tour_apps/service/provider/upload_provider.dart';

import 'package:tour_apps/splashscreen/splashpage.dart';
import 'others/const.dart';
import 'others/globalcolor.dart';
import 'others/textstyle.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessingbackground);
  prefs = await SharedPreferences.getInstance();
  isviewed = prefs!.getInt('onBoard');
  runApp(const MyApp());
}

Future<void> _firebaseMessingbackground(RemoteMessage message) async {
  if (kDebugMode) {
    print("Handling a background message $message");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return CategoriesProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return DetailsProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return SearchProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return UploadProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return CategoriesProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return LocationProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return ThemeProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return LoadingProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return DropCateogryProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return ImageUploadProvider();
          },
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  appBarTheme: AppBarTheme(
                    iconTheme: IconThemeData(
                        color: value.getDarkTheme ? white : black),
                    backgroundColor:
                        value.getDarkTheme ? darkCardColor : lightCardColor,
                    titleTextStyle: appbarTextStyle.copyWith(
                        color: value.getDarkTheme ? white : black),
                    elevation: 0.0,
                    centerTitle: true,
                  ),
                  scaffoldBackgroundColor:
                      value.getDarkTheme ? darkBackgroundColor : white,
                  primaryColor:
                      value.getDarkTheme ? darkBlueColor : lightBlueColor,
                  hintColor: value.getDarkTheme ? Colors.grey : lightTextColor,
                  colorScheme: ThemeData().colorScheme.copyWith(
                        secondary: value.getDarkTheme ? white : black,
                      ),
                  dividerColor: value.getDarkTheme ? black : white,
                  iconTheme: IconThemeData(
                      color:
                          value.getDarkTheme ? darkIconColor : lightIconColor),
                  cardColor:
                      value.getDarkTheme ? darkCardColor : lightCardColor,
                  textTheme: TextTheme(
                    displayMedium: GoogleFonts.inter(
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        color: value.getDarkTheme ? white : black),
                  )),
              home: const SplashScreen());
        },
      ),
    );
  }
}
