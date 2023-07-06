import 'package:cloud_firestore/cloud_firestore.dart';

class ApiService {
  Stream<QuerySnapshot<Map<String, dynamic>>>? firebaseSnapsh(
      {required String collectionName,
      required String searchItem,
      required String categories}) {
    // if (categories == "All") {
    //   if (searchItem == "" || searchItem.isEmpty == true || searchItem == ' ') {
    //     return FirebaseFirestore.instance
    //         .collection(collectionName)
    //         .orderBy("publishdate", descending: true)
    //         .snapshots();
    //   } else {
    //     return FirebaseFirestore.instance
    //         .collection(collectionName)
    //         .where("tourname", isEqualTo: searchItem)
    //         .orderBy("publishdate", descending: true)
    //         .snapshots();
    //   }
      
    // }
    if(searchItem != "" || searchItem.isEmpty == false){
 return FirebaseFirestore.instance
            .collection(collectionName)
            .where("tourname", isEqualTo: searchItem)
            .orderBy("publishdate", descending: true)
            .snapshots();
          
    }
     if(categories=="Sea"){
      if (searchItem == "" || searchItem.isEmpty == true || searchItem == ' ') {
        return FirebaseFirestore.instance
            .collection(collectionName)
            .orderBy("publishdate", descending: true)
            .snapshots();
      } else {
       
      }
    }

    return FirebaseFirestore.instance
        .collection(collectionName)
        .where("tourname", isEqualTo: searchItem)
        .orderBy("publishdate", descending: true)
        .snapshots();
  }

 Stream<QuerySnapshot<Map<String, dynamic>>>? categoriesfirebaseSnapsh(
      {
      required String categories}) {

        if(categories=="All"){
           return FirebaseFirestore.instance
            .collection("trip")
            .orderBy("publishdate", descending: true)
            .snapshots();
        }
        else if(categories=="Sea"){
          return FirebaseFirestore.instance
            .collection("trip")
            .where("tourname", isEqualTo: categories)
            .orderBy("publishdate", descending: true)
            .snapshots();
        }
        else if(categories=="Sea"){
          return FirebaseFirestore.instance
            .collection("trip")
            .where("tourname", isEqualTo: categories)
            .orderBy("publishdate", descending: true)
            .snapshots();
        }
        else if(categories=="Forest"){
          return FirebaseFirestore.instance
            .collection("trip")
            .where("tourname", isEqualTo: categories)
            .orderBy("publishdate", descending: true)
            .snapshots();
        }
        else if(categories=="Island"){
          return FirebaseFirestore.instance
            .collection("trip")
            .where("tourname", isEqualTo: categories)
            .orderBy("publishdate", descending: true)
            .snapshots();
        }
        else if(categories=="Mountain"){
          return FirebaseFirestore.instance
            .collection("trip")
            .where("tourname", isEqualTo: categories)
            .orderBy("publishdate", descending: true)
            .snapshots();
        }
        else if(categories=="River"){
          return FirebaseFirestore.instance
            .collection("trip")
            .where("tourname", isEqualTo: categories)
            .orderBy("publishdate", descending: true)
            .snapshots();
        }
        else if(categories=="Lake"){
          return FirebaseFirestore.instance
            .collection("trip")
            .where("tourname", isEqualTo: categories)
            .orderBy("publishdate", descending: true)
            .snapshots();
        }
    
    
  }


}
