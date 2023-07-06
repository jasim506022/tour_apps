import 'package:flutter/material.dart';
import 'package:tour_apps/admin/home/uploadscreen.dart';
import 'package:tour_apps/const/const.dart';
import 'package:tour_apps/model/tripsmodel.dart';
import 'package:tour_apps/splashscreen/services/apisservice.dart';
import '../../model/categoriesmodel.dart';
import '../widget/tourwidget.dart';

class HomePageAdmin extends StatefulWidget {
  const HomePageAdmin({super.key});
  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  String dropdownValue = categoryAllString.first;
  TextEditingController searchFilter = TextEditingController();
  String searchText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "All Trips",
          style: appbarTextStyle,
        ),
        actions: [
          IconButton(
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 1)),
            child: const Text("Search Here"),
          ),
          DropdownButton<String>(
            value: dropdownValue,
            isExpanded: true,
            items: categoryAllString.map<DropdownMenuItem<String>>((e) {
              return DropdownMenuItem(value: e, child: Text(e));
            }).toList(),
            onChanged: (value) {
              dropdownValue = value!;
              setState(() {});
            },
          ),
          //Kuakata Beach
          Expanded(
            child: StreamBuilder(
              stream: dropdownValue != null
                  ? ApiService()
                      .categoriesfirebaseSnapsh(categories: dropdownValue)
                  : ApiService().firebaseSnapsh(
                      collectionName: "trip",
                      searchItem: searchText,
                      categories: dropdownValue),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      TripsModels tripsModel = TripsModels.fromMap(snapshot
                          .data!.docs[index]
                          .data()); //Map<String, dynamic>
                      return TourWidget(
                        tripsModel: tripsModel,
                      );
                    },
                  );
                }

                return const Text("Something is worng");
              },
            ),
          ),
        ],
      ),
    );
  }
}
