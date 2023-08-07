import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tour_apps/model/grouptipmodel.dart';
import '../../admin/widget/loadingtourwidget.dart';
import '../../admin/widget/singletourwidget.dart';
import '../../const/const.dart';
import '../../model/tourmodel.dart';
import '../../service/provider/admin/searchprovider.dart';
import '../widget/grouptips.dart';
import '../widget/single_tour_user_widget.dart';

// ignore: must_be_immutable
class SearchUserPage extends StatefulWidget {
  SearchUserPage({super.key, this.isSingleTour = true});

  bool? isSingleTour;

  @override
  State<SearchUserPage> createState() => _SearchUserPageState();
}

class _SearchUserPageState extends State<SearchUserPage> {
  Future<QuerySnapshot>? querySnapshot;

  @override
  void dispose() {
    searchFN.dispose();
    super.dispose();
  }

  FocusNode searchFN = FocusNode();

  inistialQuerySnapshot(String text) {
    querySnapshot = widget.isSingleTour == true
        ? FirebaseFirestore.instance
            .collection("trip")
            .where("tourname", isGreaterThanOrEqualTo: text)
            .get()
        : FirebaseFirestore.instance
            .collection("grouptrips")
            .where("tourname", isGreaterThanOrEqualTo: text)
            .get();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          title: Text("Search", style: appbarTextStyle),
        ),
        body: Column(
          children: [
            Consumer<SearchProvider>(
              builder: (context, valueText, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    autofocus: true,
                    focusNode: searchFN,
                    onChanged: (value) {
                      Provider.of<SearchProvider>(context, listen: false)
                          .setSearchText(searchValue: value);
                      setState(() {
                        inistialQuerySnapshot(valueText.searchText);
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Search Here",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 1.5),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          inistialQuerySnapshot(valueText.searchText);
                        },
                        icon: const Icon(Icons.search),
                        color: Colors.grey,
                      ),
                    ),
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                        color: black),
                  ),
                );
              },
            ),
            Expanded(
              child: FutureBuilder(
                future: querySnapshot,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        if (widget.isSingleTour!) {
                          TourModel tourModel = TourModel.fromMap(snapshot
                              .data.docs[index]
                              .data()); //Map<String, dynamic>
                          return ChangeNotifierProvider.value(
                            value: tourModel,
                            child: SingleTourUserWidget(),
                          );
                        } else {
                          GroupTourModel tourModel = GroupTourModel.fromMap(
                              snapshot.data.docs[index]
                                  .data()); //Map<String, dynamic>
                          return ChangeNotifierProvider.value(
                            value: tourModel,
                            child: const GroupTourWidget(),
                          );
                        }
                      },
                    );
                  }

                  return const LoadingTourWidget();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
