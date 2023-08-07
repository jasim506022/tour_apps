import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import '../../const/const.dart';
import '../../model/categoriesmodel.dart';
import '../../model/grouptipmodel.dart';
import '../../model/tourmodel.dart';
import '../widget/group_tour_user_widget.dart';
import '../widget/loading_group_widget.dart';
import '../widget/loading_top_tour_widget.dart';
import '../widget/row_widget.dart';
import '../widget/top_tour_widget.dart';
import '../grouptour/groupage.dart';
import '../search/searchuserpage.dart';
import '../service/provider/categoriesprovider.dart';
import '../tourpage/tourpage.dart';
import '../widget/location_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Ionicons.location_sharp,
                    size: 25,
                    color: iconColor,
                  ),
                  const LocationWidget(),
                  Icon(
                    IconlyLight.arrowDown2,
                    size: 25,
                    color: yello,
                  ),
                  const Spacer(),
                  Icon(
                    Icons.notifications,
                    color: iconColor,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SearchUserPage(isSingleTour: true),
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
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    RowWidget(
                      text: 'Category',
                      funtion: () {},
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Consumer<CategoriesProvider>(
                      builder: (context, value, child) {
                        return SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: InkWell(
                                  onTap: () {
                                    Provider.of<CategoriesProvider>(context,
                                            listen: false)
                                        .setIndex(index: index);

                                    Provider.of<CategoriesProvider>(context,
                                            listen: false)
                                        .categorySet(
                                            cateory: categories[index].name);
                                  },
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: Theme.of(context).primaryColor,
                                          width: 1),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 40,
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: value.selectIndex == index
                                                ? Theme.of(context).primaryColor
                                                : white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Image.asset(
                                              categories[index].imagename,
                                              height: 24,
                                              width: 24,
                                              color: value.selectIndex == index
                                                  ? white
                                                  : Theme.of(context)
                                                      .primaryColor),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            categories[index].name,
                                            style: categoryTitle,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    RowWidget(
                      text: 'All Tours',
                      funtion: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TourPage(),
                            ));
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer<CategoriesProvider>(
                      builder: (context, value, child) {
                        return SizedBox(
                            height: 220,
                            width: double.infinity,
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("trip")
                                  .orderBy("publishdate", descending: true)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const LoadingTopTourWidget();
                                }
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    itemCount: snapshot.data!.docs.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      TourModel tourModel = TourModel.fromMap(
                                          snapshot.data!.docs[index].data());
                                      return TopTourWidget(
                                        tourModel: tourModel,
                                        selectedCategories: value.categoryName,
                                      );
                                    },
                                  );
                                }
                                return const LoadingTopTourWidget();
                              },
                            ));
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RowWidget(
                      text: 'Group Tour',
                      funtion: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GroupPage(),
                            ));
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("grouptrips")
                          .orderBy("publishdate", descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const LoadingGroupdWidget();
                        }
                        if (snapshot.hasData) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              GroupTourModel model = GroupTourModel.fromMap(
                                  snapshot.data!.docs[index].data());

                              return ChangeNotifierProvider.value(
                                value: model,
                                child: GroupTourUserWidget(),
                              );
                            },
                          );
                        }

                        return const LoadingGroupdWidget();
                      },
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
