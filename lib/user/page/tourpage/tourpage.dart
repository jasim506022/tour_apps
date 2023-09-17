import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_apps/model/tourmodel.dart';
import 'package:tour_apps/service/database/firebaseservice.dart';
import 'package:tour_apps/service/provider/droop_category_provider.dart';
import 'package:tour_apps/widget/empty_widget.dart';
import 'package:tour_apps/widget/search_widget.dart';
import '../../../model/categoriesmodel.dart';
import '../../../widget/drop_cateogry_widget.dart';
import '../../../widget/loading_tour_widget.dart';
import '../../../others/textstyle.dart';
import 'single_tour_user_widget.dart';
import '../search/searchuserpage.dart';

class TourPage extends StatefulWidget {
  const TourPage({super.key});
  @override
  State<TourPage> createState() => _TourPageState();
}

class _TourPageState extends State<TourPage> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
      DropCateogryProvider detailsProvider =
          Provider.of<DropCateogryProvider>(context, listen: false);
      detailsProvider.setCategory(cateory: categoryAllString.first);
    });
    super.initState();
  }

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
            SearchWidget(
              function: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchUserPage(
                        isSingleTour: true,
                        backButtonShow: true,
                      ),
                    ));
              },
            ),
            const SizedBox(
              height: 14,
            ),
            const DropCategoryWidget(),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Consumer<DropCateogryProvider>(
                builder: (context, value, child) {
                  return StreamBuilder(
                    stream: FirebaseServices.categoriesFirebaseSnapshot(
                        categories: value.getCategory),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const LoadingTourWidget();
                      } else if (snapshot.hasError) {
                        return const EmptyWidget(
                          image: "asset/image/empty.png",
                          text: 'Something is Problem',
                        );
                      } else if (snapshot.hasData) {
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
