import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:tour_apps/others/const.dart';

class FirebaseServices {
  static final firebasedb = FirebaseFirestore.instance;

  static Future<void> getFcmToken(
      {required String collection,
      required String doc,
      required String deviceToken}) async {
    try {
      String? tokens = await FirebaseMessaging.instance.getToken();
      if (tokens != null) {
        FirebaseFirestore.instance
            .collection(collection)
            .doc(doc)
            .update({deviceToken: tokens});
      } else {
        if (kDebugMode) {
          print("Failed to retrieve FCM token.");
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error updating FCM token: $error");
      }
    }
  }

//Admin Database

//Add Tour
  static Future<void> addTour(
      {required String id,
      required String collection,
      required Map<String, dynamic> map}) {
    return firebasedb.collection(collection).doc(id).set(map);
  }

// Delete Tour
  static Future<void> deleteTour({
    required String id,
    required String collection,
  }) {
    return firebasedb.collection(collection).doc(id).delete();
  }
// Get All Data

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllDataSnapshots({
    required String collection,
  }) {
    return firebasedb.collection(collection).snapshots();
  }

//update Data
  static Future<void> updateData(
      {required String id,
      required String collection,
      required Map<String, dynamic> map}) {
    return firebasedb.collection(collection).doc(id).update(map);
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> categoriesFirebaseSnapshot(
      {required String categories}) {
    if (categories == "All") {
      return firebasedb
          .collection("trip")
          .orderBy("publishdate", descending: true)
          .snapshots();
    }

    return firebasedb
        .collection("trip")
        .where("categoris", isEqualTo: categories)
        .orderBy("publishdate", descending: true)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> groupFirebaseSnapshot() {
    return firebasedb
        .collection("grouptrips")
        .orderBy("publishdate", descending: true)
        .snapshots();
  }

  static searchinQuerySnapshot(
      {required String text, required bool isSingleTour}) {
    return isSingleTour
        ? firebasedb
            .collection("trip")
            .where("tourname", isGreaterThanOrEqualTo: text)
            .get()
        : firebasedb
            .collection("grouptrips")
            .where("tourname", isGreaterThanOrEqualTo: text)
            .get();
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>>
      getUserSnapshot() async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(prefs!.getString("uid"))
        .get();
  }

  static Future<void> addBookingTour(
      {required String id,
      required String collection,
      required String subCollect,
      required String subId,
      required Map<String, dynamic> map}) {
    return firebasedb
        .collection(collection)
        .doc(id)
        .collection(subCollect)
        .doc(subId)
        .set(map);
  }

  static Future<DocumentSnapshot<Map<String, dynamic>>> bookingSnaphsot(
      {required String collection, required String id}) async {
    return await FirebaseFirestore.instance
        .collection(collection)
        .doc(id)
        .get();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllDataWithWhere(
      {required String collection, required List<String> list}) {
    return firebasedb
        .collection(collection)
        .where("id", whereIn: list)
        .snapshots();
  }

  //SharePrefernceDataSet
  static adminSharePrefernceDataSet() async {
    try {
      var documentSnapshot =
          await firebasedb.collection("admin").doc("admin").get();
      await prefs!.setString("adminimage", documentSnapshot["image"]);
      await prefs!.setString("adminname", documentSnapshot["name"]);
      await prefs!.setString("adminbirth", documentSnapshot["birth"]);
      await prefs!.setString("adminprofession", documentSnapshot["profession"]);
      await prefs!.setString("adminemail", documentSnapshot["email"]);
      await prefs!.setString("adminabout", documentSnapshot["about"]);
      await prefs!.setString("adminphone", documentSnapshot["phone"]);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching document data: $e');
      }
    }
  }

  static userSharePrefenceDataSet() async {
    try {
      var documentSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (documentSnapshot.exists) {
        await prefs!.setString("uid", documentSnapshot["uid"]);
        await prefs!.setString("username", documentSnapshot["name"]);
        await prefs!
            .setString("userprofession", documentSnapshot["profession"]);
        await prefs!.setString("useremail", documentSnapshot["email"]);
        await prefs!.setString("userimage", documentSnapshot["image"]);
        await prefs!.setString("userabout", documentSnapshot["about"]);
        await prefs!.setString("userphone", documentSnapshot["phone"]);
        await prefs!.setString("userbirth", documentSnapshot["birth"]);
        await prefs!.setStringList(
            "savetour", List.from(documentSnapshot.data()!['savetour']));
        print(prefs!.getStringList("savetour"));

        await prefs!.setStringList("bookingtour",
            List.from(documentSnapshot.data()!['bookingtour']));

        await prefs!.setStringList("historytour",
            List.from(documentSnapshot.data()!['historytour']));

        await prefs!.setStringList("historygrouptour",
            List.from(documentSnapshot.data()!['historygrouptour']));

        await prefs!.setStringList("bookinggroup",
            List.from(documentSnapshot.data()!['bookinggroup']));

        await prefs!.setStringList("savegrouptour",
            List.from(documentSnapshot.data()!['savegrouptour']));
             print(prefs!.getStringList("savegrouptour"));
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching document data: $e');
      }
    }
  }
}
