import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 70,
            backgroundColor: Colors.black,
          ),
          Text("Name"),
          Text("Name"),
          Divider(
            height: 1.5,
            color: Colors.black,
          ),
          Text("Name"),
          Text("Name"),
          Text("Name"),
          Text("Name"),
          Text("Name"),
          Text("Name"),
          Text("Name"),
          Text("Name"),
          Text("Name"),
          Text("Name"),
        ],
      ),
    );
  }
}
