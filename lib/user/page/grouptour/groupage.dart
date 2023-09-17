import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_apps/model/grouptipmodel.dart';
import 'package:tour_apps/widget/search_widget.dart';
import '../../../others/textstyle.dart';
import '../../../service/database/firebaseservice.dart';
import '../../../widget/empty_widget.dart';
import '../search/searchuserpage.dart';
import 'group_tour_user_widget.dart';
import '../../../widget/loading_group_widget.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Group Tour",
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
                          isSingleTour: false, backButtonShow: true),
                    ));
              },
            ),
            const SizedBox(
              height: 2,
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseServices.groupFirebaseSnapshot(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingGroupdWidget();
                  } else if (snapshot.hasError) {
                    return const EmptyWidget(
                      image: "asset/image/empty.png",
                      text: 'Something is Problem',
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
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
            ),
          ],
        ),
      ),
    );
  }
}
