import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../widget/loading_tour_widget.dart';
import '../../../others/const.dart';
import '../../../others/textstyle.dart';
import '../../../model/grouptipmodel.dart';
import '../../../model/tourmodel.dart';
import '../grouptour/group_tour_user_widget.dart';
import '../../../widget/loading_group_widget.dart';
import '../tourpage/single_tour_user_widget.dart';
import '../../../widget/empty_widget.dart';

class HistoryTour extends StatefulWidget {
  const HistoryTour({super.key});
  @override
  State<HistoryTour> createState() => _HistoryTourState();
}

class _HistoryTourState extends State<HistoryTour> {
  List<String> historysingletour = [];
  List<String> historyGroupTour = [];
  bool isLoading = true;
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
      var savetour = value["historytour"];
      if (savetour != null && savetour is List && savetour.isNotEmpty) {
        setState(() {
          isLoading = true;
          historysingletour = List<String>.from(savetour);
        });
      } else {
        historysingletour = [];
      }
    });
  }

  groupTourList() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(prefs!.getString("uid"))
        .get()
        .then((value) {
      var savetour = value["historygrouptour"];
      if (savetour != null && savetour is List && savetour.isNotEmpty) {
        setState(() {
          historyGroupTour = List<String>.from(savetour);
        });
      } else {
        historyGroupTour = [];
      }
      if (kDebugMode) {
        print(historyGroupTour);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //someisworn
        title: const Text(
          "History Tour",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            Text(
              "Single Tour",
              style: appbarTextStyle.copyWith(
                  color: Theme.of(context).colorScheme.secondary),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * .45,
                child: historysingletour.isEmpty
                    // Check if the list is empty
                    ? const EmptyWidget(
                        image: "asset/image/empty.png",
                        text: 'No Single Tour Save',
                      )
                    : FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection("trip")
                            .where("id", whereIn: historysingletour)
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
                                  showDialogFunction(
                                      context, tourModel.id!, "historytour");
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
                        style: appbarTextStyle.copyWith(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                    historyGroupTour.isEmpty // Check if the list is empty
                        ? const EmptyWidget(
                            image: "asset/image/empty.png",
                            text: 'No Group Tour Save',
                          )
                        : FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection("grouptrips")
                                .where("id", whereIn: historyGroupTour)
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const LoadingGroupdWidget();
                                // ignore: unnecessary_null_comparison
                              } else if (snapshot.hasData == null) {
                                return const CircularProgressIndicator();
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
                                  GroupTourModel groupTourModel =
                                      GroupTourModel.fromMap(snapshot
                                          .data!.docs[index]
                                          .data()); //Map<String, dynamic>

                                  return InkWell(
                                    onLongPress: () {
                                      showDialogFunction(
                                          context,
                                          groupTourModel.id!,
                                          "historygrouptour");
                                    },
                                    child: ChangeNotifierProvider.value(
                                      value: groupTourModel,
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

  Future<dynamic> showDialogFunction(
      BuildContext context, String id, String tourType) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        title: Text(
          "Are you want to Delete!",
          style: GoogleFonts.yesevaOne(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).hintColor),
        ),
        content: Text("Do you want delete this tour Permanently",
            style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).hintColor)),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cencel")),
          TextButton(
              onPressed: () async {
                DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
                    .collection("users")
                    .doc(prefs!.getString("uid"))
                    .get();

                List<dynamic> savetour = userSnapshot.get(tourType);
                savetour.remove(id);

                await FirebaseFirestore.instance
                    .collection("users")
                    .doc(prefs!.getString("uid"))
                    .update({tourType: savetour});
                List<String> stringList = savetour
                    .map((dynamic element) => element.toString())
                    .toList();
                await prefs!.setStringList(tourType, stringList);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
                setState(() {
                  // Cast savetour to List<String> when using it in the query
                  tourType == "historytour"
                      ? historysingletour = List<String>.from(savetour)
                      : historyGroupTour = List<String>.from(savetour);
                });
              },
              child: const Text(
                "Yes",
                style: TextStyle(color: Colors.red),
              )),
        ],
      ),
    );
  }
}
