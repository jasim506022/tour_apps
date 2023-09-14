import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_apps/admin/search/searchadminpage.dart';
import 'package:tour_apps/admin/home/uploadtourpage.dart';
import 'package:tour_apps/model/tourmodel.dart';
import '../../model/categoriesmodel.dart';
import '../../service/database/firebaseservice.dart';
import '../../service/provider/droop_category_provider.dart';
import '../../widget/empty_widget.dart';
import '../../widget/search_widget.dart';
import '../../widget/drop_cateogry_widget.dart';
import '../../widget/loading_tour_widget.dart';
import 'single_tour_admin_widget.dart';

class HomeAdminPage extends StatefulWidget {
  const HomeAdminPage({super.key});
  @override
  State<HomeAdminPage> createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends State<HomeAdminPage> {
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
        automaticallyImplyLeading: false,
        title: const Text(
          "Single Tour",
        ),
        actions: [
          IconButton(
              tooltip: "Add Tour",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UploadTourPage(
                        isUpdate: false,
                      ),
                    ));
              },
              icon: const Icon(Icons.cloud_upload_rounded))
        ],
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
                      builder: (context) => SearchAdminPage(),
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
                builder: (context, cateogryProvider, child) {
                  return StreamBuilder(
                    stream: FirebaseServices.categoriesFirebaseSnapshot(
                        categories: cateogryProvider.getCategory),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const LoadingTourWidget();
                      } else if (snapshot.hasError) {
                        return EmptyWidget(
                          image: 'asset/image/empty.png',
                          text: 'An Error Occured ${snapshot.error}',
                        );
                      } else if (snapshot.data == null) {
                        return const EmptyWidget(
                          image: 'asset/image/empty.png',
                          text: 'No Tour Found',
                        );
                      } else if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            TourModel tourModel = TourModel.fromMap(
                                snapshot.data!.docs[index].data());
                            return ChangeNotifierProvider.value(
                              value: tourModel,
                              child: const SingleTourAdminWidget(),
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
