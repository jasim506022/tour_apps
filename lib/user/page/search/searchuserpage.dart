import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tour_apps/model/grouptipmodel.dart';
import 'package:tour_apps/service/database/firebaseservice.dart';
import 'package:tour_apps/service/provider/search_provider.dart';
import '../../../widget/loading_tour_widget.dart';
import '../../../others/textstyle.dart';
import '../../../model/tourmodel.dart';
import '../grouptour/group_tour_user_widget.dart';
import '../tourpage/single_tour_user_widget.dart';

// ignore: must_be_immutable
class SearchUserPage extends StatefulWidget {
  SearchUserPage(
      {super.key, this.isSingleTour = true, this.backButtonShow = false});

  bool? isSingleTour;
  bool? backButtonShow;

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
    querySnapshot = FirebaseServices.searchinQuerySnapshot(
        text: text, isSingleTour: widget.isSingleTour!);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: widget.backButtonShow! ? true : false,
          elevation: 1,
          title: Text(
            "Search",
            style: appbarTextStyle,
          ),
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
                        hintStyle: hintTextStyle,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 1.5),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            inistialQuerySnapshot(valueText.searchText);
                          },
                          icon: const Icon(Icons.search),
                          color: Colors.grey,
                        ),
                      ),
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.secondary)),
                );
              },
            ),
            const SizedBox(
              height: 15,
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
                            child:  GroupTourUserWidget(),
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
