import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tour_apps/const/const.dart';
import 'package:tour_apps/model/tourmodel.dart';
import '../../admin/widget/loadingtourwidget.dart';
import '../../model/categoriesmodel.dart';
import '../../service/provider/admin/dropcategoryall.dart';
import '../widget/single_tour_user_widget.dart';
import '../search/searchuserpage.dart';

class TourPage extends StatefulWidget {
  const TourPage({super.key});
  @override
  State<TourPage> createState() => _TourPageState();
}

class _TourPageState extends State<TourPage> {
  TextEditingController searchFilter = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "All Single Tours",
          style: appbarTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchUserPage(isSingleTour: true),
                    ));
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 1)),
                child: Text("Search Here",
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600)),
              ),
            ),
           
           
           
            const SizedBox(
              height: 10,
            ),
            Consumer<DropCategoyAll>(
              builder: (context, values, child) {
                return Container(
                  alignment: Alignment.centerLeft,
                  height: 55,
                  color: Colors.white,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 1)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 1))),
                    style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: blueColor),
                    value: values.categoryName,
                    isExpanded: true,
                    items: categoryAllString.map<DropdownMenuItem<String>>((e) {
                      return DropdownMenuItem(value: e, child: Text(e));
                    }).toList(),
                    onChanged: (value) {
                      Provider.of<DropCategoyAll>(context, listen: false)
                          .categorySet(cateory: value!);
                    },
                  ),
                );
              },
            ),
            Expanded(
              child: Consumer<DropCategoyAll>(
                builder: (context, value, child) {
                  return StreamBuilder(
                    stream: value.categoryName == "All"
                        ? FirebaseFirestore.instance
                            .collection("trip")
                            .orderBy("publishdate", descending: true)
                            .snapshots()
                        : FirebaseFirestore.instance
                            .collection("trip")
                            .where("categoris", isEqualTo: value.categoryName)
                            .orderBy("publishdate", descending: true)
                            .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const LoadingTourWidget();
                      }
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            TourModel tourModel = TourModel.fromMap(snapshot
                                .data!.docs[index]
                                .data()); //Map<String, dynamic>
                            return ChangeNotifierProvider.value(
                              value: tourModel,
                              child: SingleTourUserWidget(),
                            );
                          },
                        );
                      }
                      return const LoadingTourWidget();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
