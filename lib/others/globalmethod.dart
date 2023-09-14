import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tour_apps/onboarding/onbaordpage.dart';
import 'package:tour_apps/others/textstyle.dart';
import 'package:tour_apps/service/provider/image_upload_provider.dart';
import 'package:tour_apps/service/provider/upload_provider.dart';
import '../admin/adminmainpage.dart';
import '../auth/loginpage.dart';
import '../user/mainpage.dart';
import 'const.dart';

class GlobalMethod {
  final ImagePicker imagePicker = ImagePicker();

// All Admin Method
  Scaffold defaultScreen(
    BuildContext context,
    String appBarTitle,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.add_photo_alternate_outlined,
              color: Theme.of(context).colorScheme.secondary,
              size: 200,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                onPressed: () {
                  obtainImageDialogBox(context);
                },
                child: Text(
                  appBarTitle,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }

  bottomSheet(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      title: Text(
        "Choose Profile, Photo",
        style: appbarTextStyle.copyWith(
            color: Theme.of(context).colorScheme.secondary),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
              onPressed: () {
                takePhoto(context, ImageSource.camera);
              },
              icon: const Icon(Icons.camera),
              label: const Text("Camera")),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton.icon(
              onPressed: () {
                takePhoto(context, ImageSource.gallery);
              },
              icon: const Icon(Icons.image),
              label: const Text("Gallery")),
        ],
      ),
    );
  }

  takePhoto(BuildContext context, ImageSource source) async {
    ImageUploadProvider imageUploadProvider =
        Provider.of<ImageUploadProvider>(context, listen: false);
    Navigator.pop(context);
    XFile? pickIfile = await imagePicker.pickImage(source: source);
    imageUploadProvider.setImage(pickIfile!);
  }

  obtainImageDialogBox(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          backgroundColor: Theme.of(context).cardColor,
          title: Text(
            " Select Tour Image",
            style: GoogleFonts.yesevaOne(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).hintColor),
          ),
          children: [
            SimpleDialogOption(
              onPressed: () {
                captureImageWithPhoneCamera(context);
              },
              child: Text(
                "Capture image with Camera",
                style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                captureImageFromGaller(context);
              },
              child: Text("Select image from Gallery",
                  style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor)),
            ),
            SimpleDialogOption(
              onPressed: () {},
              child: Text("Cancel",
                  style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  captureImageWithPhoneCamera(BuildContext context) async {
    UploadProvider uploadSingleTourProvider =
        Provider.of<UploadProvider>(context, listen: false);
    Navigator.pop(context);
    List<XFile> imagesListXfile = await imagePicker.pickMultiImage();
    uploadSingleTourProvider.setImage(photo: imagesListXfile);
  }

  captureImageFromGaller(BuildContext context) async {
    UploadProvider uploadSingleTourProvider =
        Provider.of<UploadProvider>(context, listen: false);
    Navigator.pop(context);
    List<XFile> imagesListXfile = await imagePicker.pickMultiImage();
    uploadSingleTourProvider.setImage(photo: imagesListXfile);
  }

  void isMainPage(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      if (user.uid == "Uq4kPlNYbTUqqqQNUMWTOm7ifzD3") {
        Timer(
          const Duration(seconds: 3),
          () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdminMainPage(),
              )),
        );
      } else {
        Timer(
          const Duration(seconds: 3),
          () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainPage(),
              )),
        );
      }
    } else {
      Timer(
        const Duration(seconds: 3),
        () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  isviewed != 0 ?  OnBoardPage(isAdmin: false,) : const LoginPage(),
            )),
      );
    }
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
        backgroundColor: Theme.of(context).cardColor,
      ));
  }
  /*      
  Future<void> paymentCheckout(BuildContext context, 
  String modelId,
  List<String> itembookinglist,  
  List<String> saveItemList,  
  double amount, 
  String docId, 
  String token,
  String title, 
  String body, 
  String userid) async {
    // isLoading = true;
    // setState(() {});
    final flutterBkash = FlutterBkash();

    final result = await flutterBkash.createAgreement(
      payerReference: "00",
      context: context,
    );

    List<String> bookinglist = prefs!.getStringList("bookingtour")!;
    bookinglist.add(modelId);

    FirebaseServices.updateData(
            collection: "users",
            id: prefs!.getString("uid")!,
            map: ({
              "bookingtour": bookinglist,
            }))
        .then((value) async {
      await prefs!.setStringList("bookingtour", bookinglist);

      itembookinglist = prefs!.getStringList("bookingtour")!;
      if (saveItemList.contains(modelId)) {
        DocumentSnapshot<Map<String, dynamic>> userSnapshot =
            await FirebaseServices.getUserSnapshot();
        Fluttertoast.showToast(msg: "Item remove successfully.");

        List<dynamic> savetour = userSnapshot["savetour"];
        savetour.remove(modelId);

        await FirebaseServices.updateData(
            id: prefs!.getString("uid")!,
            collection: "users",
            map: ({"savetour": savetour}));
        List<String> savetorFromfirebase =
            savetour.map((dynamic element) => element.toString()).toList();

        await prefs!.setStringList("savetour", savetorFromfirebase);
        saveItemList = prefs!.getStringList("savetour")!;
        setState(() {});
      }
      pushNotificationMessage.sendNotificationUser(token, title, body, userid);
      Fluttertoast.showToast(msg: "Booking successfully.");
    }).then((value) {
      FirebaseServices.addBookingTour(
              id: prefs!.getString("uid")!,
              collection: "users",
              subCollect: "boookings",
              subId: docId,
              map: ({
                "id": docId,
                "uid": prefs!.getString("uid"),
                "bookingtime": DateTime.now()
              }))

          .then((value) async {
        var uploadingData = await FirebaseServices.bookingSnaphsot(
            collection: 'boookings', id: docId);

        await FirebaseFirestore.instance.collection("boookings").doc(docId).get();
        if (uploadingData.exists) {
          itemList = uploadingData['ui'];
          itemList.add(prefs!.getString("uid")!);
          if (kDebugMode) {
            print(itemList);
          }
          await uploadingData.reference.update({'ui': itemList});
        } else {
          await uploadingData.reference.set({"ui": prefs!.getString("uid")});
        }
      });
    });

    // ignore: use_build_context_synchronously
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(index: 0),
        ));

    // ignore: use_build_context_synchronously
    globalMethod.showSnackbar(
        context, "(Success) tranId: ${result.payerReference}");
  }

*/
}
