import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tour_apps/service/database/firebaseservice.dart';
import '../../../widget/loading_tour_widget.dart';
import '../../../others/const.dart';
import '../../../model/grouptipmodel.dart';
import '../../../model/tourmodel.dart';
import '../grouptour/group_tour_user_widget.dart';
import '../../../widget/loading_group_widget.dart';
import '../../../widget/row_widget.dart';
import '../tourpage/single_tour_user_widget.dart';
import '../../../widget/empty_widget.dart';

class SaveTipsPage extends StatefulWidget {
  const SaveTipsPage({super.key});
  @override
  State<SaveTipsPage> createState() => _SaveTipsPageState();
}

class _SaveTipsPageState extends State<SaveTipsPage> {
  List<String> groupList = prefs!.getStringList("savegrouptour")!;
  List<String> singleTourList = prefs!.getStringList("savetour")!;

  @override
  void initState() {
    super.initState();
    singleSaveTour();
    groupTourList();
  }

  singleSaveTour() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(prefs!.getString("uid"))
        .get()
        .then((value) {
      var savetour = value["savetour"];
      if (savetour != null && savetour is List && savetour.isNotEmpty) {
        setState(() {
          singleTourList = List<String>.from(savetour);
        });
      } else {
        singleTourList = [];
      }
      if (kDebugMode) {
        print(singleTourList);
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
          groupList = List<String>.from(savetour);
        });
      } else {
        groupList = [];
      }
      if (kDebugMode) {
        print(groupList);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Save Tour",
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
            RowWidget(
              text: 'Single Tour',
              funtion: () {},
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .45,
              child: singleTourList.first == "tourapp" &&
                      singleTourList.length == 1
                  // Check if the list is empty
                  ? const EmptyWidget(
                      image: "asset/image/empty.png",
                      text: 'No Single Tour Save',
                    )
                  : StreamBuilder(
                      stream: FirebaseServices.getAllDataWithWhere(
                          collection: "trip", list: singleTourList),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return EmptyWidget(
                            image: "asset/image/empty.png",
                            text: 'Error: ${snapshot.error}',
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const LoadingTourWidget();
                        } else if (!snapshot.hasData) {
                          return const EmptyWidget(
                            image: "asset/image/empty.png",
                            text: 'No Single Tour Save',
                          );
                        }

                        List<String> singleTourids = [];
                        for (var doc in snapshot.data!.docs) {
                          singleTourids.add(doc.id);
                        }

                        return ListView.builder(
                          itemCount: singleTourids.length,
                          itemBuilder: (context, index) {
                            TourModel tourModel = TourModel.fromMap(snapshot
                                .data!.docs[index]
                                .data()); //Map<String, dynamic>
                            return InkWell(
                              onLongPress: () {
                                showDialogFunction(
                                    context, tourModel.id!, "savetour");
                              },
                              child: ChangeNotifierProvider.value(
                                value: tourModel,
                                child: SingleTourUserWidget(),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RowWidget(
                      text: 'Group Tour',
                      funtion: () {},
                    ),
                    groupList.first == "tourapp" && groupList.length == 1
                        ? const EmptyWidget(
                            image: "asset/image/empty.png",
                            text: 'No Group Tour Save',
                          )
                        : StreamBuilder(
                            stream: FirebaseServices.getAllDataWithWhere(
                                collection: "grouptrips", list: groupList),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return EmptyWidget(
                                  image: "asset/image/empty.png",
                                  text: 'Error: ${snapshot.error}',
                                );
                              } else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const LoadingGroupdWidget();
                                // ignore: unnecessary_null_comparison
                              } else if (!snapshot.hasData) {
                                return const EmptyWidget(
                                  image: "asset/image/empty.png",
                                  text: 'No Single Tour Save',
                                );
                              }

                              List<String> groupTourids = [];
                              for (var doc in snapshot.data!.docs) {
                                groupTourids.add(doc.id);
                              }

                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: groupTourids.length,
                                itemBuilder: (context, index) {
                                  GroupTourModel groupTourModel =
                                      GroupTourModel.fromMap(snapshot
                                          .data!.docs[index]
                                          .data()); //Map<String, dynamic>

                                  return InkWell(
                                    onLongPress: () {
                                      showDialogFunction(context,
                                          groupTourModel.id!, "savegrouptour");
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
                  tourType == "savetour"
                      ? singleTourList = List<String>.from(savetour)
                      : groupList = List<String>.from(savetour);
                });
              },
              child: Text("Yes",
                  style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.red))),
        ],
      ),
    );
  }
}
