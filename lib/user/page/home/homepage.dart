import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:tour_apps/others/globalcolor.dart';
import 'package:tour_apps/service/database/firebaseservice.dart';
import 'package:tour_apps/service/provider/categoriesprovider.dart';
import 'package:tour_apps/widget/search_widget.dart';
import '../../../others/textstyle.dart';
import '../../../model/categoriesmodel.dart';
import '../../../model/grouptipmodel.dart';
import '../../../model/tourmodel.dart';
import '../../../widget/empty_widget.dart';
import '../grouptour/group_tour_user_widget.dart';
import '../../../widget/loading_group_widget.dart';
import '../../widget/loading_top_tour_widget.dart';
import '../../../widget/row_widget.dart';
import 'top_tour_widget.dart';
import '../grouptour/groupage.dart';
import '../search/searchuserpage.dart';
import '../tourpage/tourpage.dart';
import 'location_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                    color: Theme.of(context).iconTheme.color,
                  ),
                  const LocationWidget(),
                  Icon(
                    IconlyLight.arrowDown2,
                    size: 25,
                    color: yelloColor,
                  ),
                  const Spacer(),
                  Icon(
                    Icons.notifications,
                    color: Theme.of(context).iconTheme.color,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SearchWidget(
                function: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchUserPage(
                            isSingleTour: true, backButtonShow: true),
                      ));
                },
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
                      builder: (context, cateogryProvider, child) {
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
                                        .setCategory(
                                            cateory: categories[index].name);
                                  },
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
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
                                            color: cateogryProvider.getIndex ==
                                                    index
                                                ? Theme.of(context).primaryColor
                                                : Theme.of(context).cardColor,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Image.asset(
                                              categories[index].imagename,
                                              height: 24,
                                              width: 24,
                                              color: cateogryProvider
                                                          .getIndex ==
                                                      index
                                                  ? Theme.of(context).cardColor
                                                  : Theme.of(context)
                                                      .primaryColor),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            categories[index].name,
                                            style: smallTextStyle.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary),
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
                      builder: (context, cateogryProvider, child) {
                        return SizedBox(
                            height: 220,
                            width: double.infinity,
                            child: StreamBuilder(
                              stream:
                                  FirebaseServices.categoriesFirebaseSnapshot(
                                      categories: cateogryProvider.getCategory),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const LoadingTopTourWidget();
                                } else if (snapshot.hasError) {
                                  return const EmptyWidget(
                                    image: "asset/image/empty.png",
                                    text: 'Something is Problem',
                                  );
                                } else if (snapshot.hasData) {
                                  return ListView.builder(
                                    itemCount: snapshot.data!.docs.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      TourModel tourModel = TourModel.fromMap(
                                          snapshot.data!.docs[index].data());
                                      return TopTourWidget(
                                        tourModel: tourModel,
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
                      height: 10,
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
                      height: 15,
                    ),
                    StreamBuilder(
                      stream: FirebaseServices.groupFirebaseSnapshot(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const LoadingGroupdWidget();
                        } else if (snapshot.hasError) {
                          return const EmptyWidget(
                            image: "asset/image/empty.png",
                            text: 'Something is Problem',
                          );
                        } else if (snapshot.hasData) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              if (index > 3) {
                                return Container();
                              }
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
