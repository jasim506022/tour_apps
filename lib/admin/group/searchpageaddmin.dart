import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tour_apps/model/grouptipmodel.dart';
import 'package:tour_apps/user/widget/grouptips.dart';
import '../../const/const.dart';
import '../../service/provider/admin/searchprovider.dart';
import '../widget/loadingtourwidget.dart';

class GroupSearchScreen extends StatefulWidget {
  const GroupSearchScreen({super.key});

  @override
  State<GroupSearchScreen> createState() => _GroupSearchScreenState();
}

class _GroupSearchScreenState extends State<GroupSearchScreen> {
  Future<QuerySnapshot>? querySnapshot;

  @override
  void dispose() {
    searchFN.dispose();
    super.dispose();
  }

  FocusNode searchFN = FocusNode();

  inistialQuerySnapshot(String text) {
    querySnapshot = FirebaseFirestore.instance
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
                          .setSearchGroupText(searchValue: value);

                      setState(() {
                        inistialQuerySnapshot(valueText.searchGroupText);
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
                        GroupTourModel tourModel = GroupTourModel.fromMap(
                            snapshot.data.docs[index]
                                .data()); //Map<String, dynamic>
                        return ChangeNotifierProvider.value(
                          value: tourModel,
                          child: const GroupTourWidget(),
                        );
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