import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../admin/widget/loadingtourwidget.dart';
import '../../admin/widget/singletourwidget.dart';
import '../../const/const.dart';
import '../../model/grouptipmodel.dart';

import '../../model/tourmodel.dart';

import '../widget/group_tour_user_widget.dart';
import '../widget/loading_group_widget.dart';
import '../widget/single_tour_user_widget.dart';

class SaveTipsPage extends StatefulWidget {
  const SaveTipsPage({super.key});
  @override
  State<SaveTipsPage> createState() => _SaveTipsPageState();
}

class _SaveTipsPageState extends State<SaveTipsPage> {
  List<String> userCartList = [];
  List<String> groupdCartLIst = [];
  @override
  void initState() {
    super.initState();
    saveTourList();
    groupTourList();
  }

  saveTourList() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(prefs!.getString("uid"))
        .get()
        .then((value) {
      var savetour = value["savetour"];
      if (savetour != null && savetour is List && savetour.isNotEmpty) {
        setState(() {
          userCartList = List<String>.from(savetour);
        });
      } else {
        userCartList = [];
      }
    });
  }

  groupTourList() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(prefs!.getString("uid"))
        .get()
        .then((value) {
      var savetour = value["savegrouptour"];
      if (savetour != null && savetour is List && savetour.isNotEmpty) {
        setState(() {
          groupdCartLIst = List<String>.from(savetour);
        });
      } else {
        groupdCartLIst = [];
      }
      if (kDebugMode) {
        print(groupdCartLIst);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
        title: Text("Save Tour", style: appbarTextStyle),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Single Tour",
              style: appbarTextStyle,
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * .45,
                child: userCartList.isEmpty // Check if the list is empty
                    ? const LoadingTourWidget()
                    : FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection("trip")
                            .where("id", whereIn: userCartList)
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const LoadingTourWidget();
                          }

                          List<String> tripIds = [];
                          for (var doc in snapshot.data!.docs) {
                            tripIds.add(doc.id);
                          }

                          return ListView.builder(
                            itemCount: tripIds.length,
                            itemBuilder: (context, index) {
                              TourModel tourModel = TourModel.fromMap(snapshot
                                  .data!.docs[index]
                                  .data()); //Map<String, dynamic>
                              return InkWell(
                                onLongPress: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title:
                                          const Text("Are you want to Delete!"),
                                      content: const Text(
                                          "Do you want delete this tour Permanently"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Cencel")),
                                        TextButton(
                                            onPressed: () async {
                                              DocumentSnapshot userSnapshot =
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection("users")
                                                      .doc(prefs!
                                                          .getString("uid"))
                                                      .get();

                                              List<dynamic> savetour =
                                                  userSnapshot.get("savetour");
                                              savetour.remove(tourModel.id);

                                              await FirebaseFirestore.instance
                                                  .collection("users")
                                                  .doc(prefs!.getString("uid"))
                                                  .update(
                                                      {"savetour": savetour});
                                              List<String> stringList = savetour
                                                  .map((dynamic element) =>
                                                      element.toString())
                                                  .toList();
                                              await prefs!.setStringList(
                                                  "savetour", stringList);
                                              // ignore: use_build_context_synchronously
                                              Navigator.pop(context);
                                              setState(() {
                                                // Cast savetour to List<String> when using it in the query
                                                userCartList =
                                                    List<String>.from(savetour);
                                              });
                                            },
                                            child: const Text(
                                              "Yes",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            )),
                                      ],
                                    ),
                                  );
                                },
                                child: ChangeNotifierProvider.value(
                                  value: tourModel,
                                  child: SingleTourUserWidget(),
                                ),
                              );
                            },
                          );
                        },
                      )),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        "Group Tour",
                        style: appbarTextStyle,
                      ),
                    ),
                    groupdCartLIst.isEmpty // Check if the list is empty
                        ? const LoadingGroupdWidget()
                        : FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection("grouptrips")
                                .where("id", whereIn: groupdCartLIst)
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const LoadingGroupdWidget();
                              }

                              // Data is ready
                              List<String> tripIds = [];
                              //List<DocumentSnapshot> tripDocs = snapshot.data!.docs;

                              for (var doc in snapshot.data!.docs) {
                                tripIds.add(doc.id);
                              }

                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: tripIds.length,
                                itemBuilder: (context, index) {
                                  GroupTourModel tourModel =
                                      GroupTourModel.fromMap(snapshot
                                          .data!.docs[index]
                                          .data()); //Map<String, dynamic>

                                  return InkWell(
                                    onLongPress: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text(
                                              "Are you want to Delete!"),
                                          content: const Text(
                                              "Do you want delete this tour Permanently"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Cencel")),
                                            TextButton(
                                                onPressed: () async {
                                                  DocumentSnapshot
                                                      userSnapshot =
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection("users")
                                                          .doc(prefs!
                                                              .getString("uid"))
                                                          .get();

                                                  List<dynamic> savetour =
                                                      userSnapshot
                                                          .get("savegrouptour");
                                                  savetour.remove(tourModel.id);

                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection("users")
                                                      .doc(prefs!
                                                          .getString("uid"))
                                                      .update({
                                                    "savegrouptour": savetour
                                                  });
                                                  List<String> stringList =
                                                      savetour
                                                          .map((dynamic
                                                                  element) =>
                                                              element
                                                                  .toString())
                                                          .toList();
                                                  await prefs!.setStringList(
                                                      "savegrouptour",
                                                      stringList);
                                                  // ignore: use_build_context_synchronously
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    // Cast savetour to List<String> when using it in the query
                                                    userCartList =
                                                        List<String>.from(
                                                            savetour);
                                                  });
                                                },
                                                child: const Text(
                                                  "Yes",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                )),
                                          ],
                                        ),
                                      );
                                    },
                                    child: ChangeNotifierProvider.value(
                                      value: tourModel,
                                      child: GroupTourUserWidget(),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class SaveTipsPage extends StatefulWidget {
//   SaveTipsPage({super.key});

//   @override
//   State<SaveTipsPage> createState() => _SaveTipsPageState();
// }

// class _SaveTipsPageState extends State<SaveTipsPage> {
//   List<String> userCartList = [];

//   @override
//   void initState() {
//     super.initState();
//     saveTourList();
//   }

//   saveTourList() async {
//     try {
//       DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
//           .collection("users")
//           .doc(prefs!.getString("uid"))
//           .get();

//       if (userSnapshot.exists) {
//         var savetour = userSnapshot.get("savetour");
//         if (savetour != null &&
//             savetour is List<String> &&
//             savetour.isNotEmpty) {
//           setState(() {
//             userCartList = List<String>.from(savetour);
//           });
//         } else {
//           setState(() {
//             userCartList = [];
//           });
//         }
//       }
//     } catch (e) {
//       print("Error fetching user data: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // ... (Your existing code)

//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // ... (Your existing code)

//               SizedBox(
//                 height: MediaQuery.of(context).size.height * .45,
//                 child: userCartList.isEmpty // Check if the list is empty
//                     ? Center(
//                         child: Text(
//                           "No saved trips.",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       )
//                     : FutureBuilder(
//                         future: FirebaseFirestore.instance
//                             .collection("trip")
//                             .where("id", whereIn: userCartList)
//                             .get(),
//                         builder: (context, snapshot) {
//                           // ... (The rest of your existing code)
//                           return Text("Bangladesh");
//                         },
//                       ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
