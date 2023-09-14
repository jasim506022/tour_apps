import 'package:flutter/material.dart';
import 'package:tour_apps/admin/alluser/user_row_widget.dart';
import 'package:tour_apps/service/database/firebaseservice.dart';
import '../../model/profiledatamodel.dart';
import '../../widget/empty_widget.dart';
import '../../widget/loading_tour_widget.dart';

class AllUserPage extends StatefulWidget {
  const AllUserPage({super.key});

  @override
  State<AllUserPage> createState() => _AllUserPageState();
}

class _AllUserPageState extends State<AllUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('All User List'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: StreamBuilder(
            stream: FirebaseServices.getAllDataSnapshots(collection: "users"),
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
                  text: 'No User Found Found',
                );
              } else if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    ProfileDataModel profileModel = ProfileDataModel.fromMap(
                        snapshot.data!.docs[index].data());
                    return UserRowWidget(
                      profileDataModel: profileModel,
                    );
                  },
                );
              }
              return const LoadingTourWidget();
            },
          ),
        ));
  }
}
