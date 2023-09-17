import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_apps/model/grouptipmodel.dart';
import 'package:tour_apps/widget/search_widget.dart';
import '../../service/database/firebaseservice.dart';
import '../../widget/empty_widget.dart';
import '../../widget/loading_group_widget.dart';
import '../search/searchadminpage.dart';
import 'group_tour_admin_widget.dart';
import 'uploadgrouppage.dart';

class GroupTourAdminPage extends StatefulWidget {
  const GroupTourAdminPage({super.key});

  @override
  State<GroupTourAdminPage> createState() => _GroupTourAdminPageState();
}

class _GroupTourAdminPageState extends State<GroupTourAdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        automaticallyImplyLeading: false,
        title: const Text(
          "Group Tour",
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UploadGroupPage(isUpdate: false),
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
                      builder: (context) => SearchAdminPage(
                        isSingleTour: false,
                      ),
                    ));
              },
            ),
            const SizedBox(
              height: 14,
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseServices.groupFirebaseSnapshot(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingGroupdWidget();
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
                        GroupTourModel model = GroupTourModel.fromMap(
                            snapshot.data!.docs[index].data());
                        return ChangeNotifierProvider.value(
                          value: model,
                          child: const GroupTourAdminWidget(),
                        );
                      },
                    );
                  }

                  return const LoadingGroupdWidget();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
