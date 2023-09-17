import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tour_apps/admin/home/single_tour_admin_widget.dart';
import 'package:tour_apps/service/database/firebaseservice.dart';
import 'package:tour_apps/service/provider/search_provider.dart';
import '../../model/grouptipmodel.dart';
import '../../model/tourmodel.dart';
import '../group/group_tour_admin_widget.dart';
import '../../widget/loading_tour_widget.dart';

// ignore: must_be_immutable
class SearchAdminPage extends StatefulWidget {
  SearchAdminPage({super.key, this.isSingleTour = true});
  bool? isSingleTour;
  @override
  State<SearchAdminPage> createState() => _SearchAdminPageState();
}

class _SearchAdminPageState extends State<SearchAdminPage> {
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
          title: const Text("Search"),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
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
                        color: Theme.of(context).colorScheme.secondary),
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
                            child: const SingleTourAdminWidget(),
                          );
                        } else {
                          GroupTourModel grouptour = GroupTourModel.fromMap(
                              snapshot.data.docs[index]
                                  .data()); //Map<String, dynamic>
                          return ChangeNotifierProvider.value(
                            value: grouptour,
                            child: const GroupTourAdminWidget(),
                          );
                        }
                      },
                    );
                  }

                  return const LoadingTourWidget();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
