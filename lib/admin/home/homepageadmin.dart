import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tour_apps/admin/home/searchpage.dart';
import 'package:tour_apps/admin/home/uploadscreen.dart';
import 'package:tour_apps/const/const.dart';
import 'package:tour_apps/model/tourmodel.dart';
import '../../model/categoriesmodel.dart';
import '../services/provider/dropcategoryall.dart';
import '../widget/loadingtourwidget.dart';
import '../widget/singletourwidget.dart';

class HomePageAdmin extends StatefulWidget {
  const HomePageAdmin({super.key});
  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  TextEditingController searchFilter = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        automaticallyImplyLeading: false,
        title: Text(
          "All Trips",
          style: appbarTextStyle,
        ),
        actions: [
          IconButton(
              tooltip: "Add Tour",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UploadScreen(
                        isUPdate: false,
                      ),
                    ));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchPage(),
                  ));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1)),
              child: Text("Search Here",
                  style: GoogleFonts.inter(
                      fontSize: 12,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                      color: black)),
            ),
          ),
          Consumer<DropCategoyAll>(
            builder: (context, values, child) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: DropdownButton<String>(
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
                            child: const SingleTourWidget(),
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
    );
  }
}
