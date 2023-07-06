import 'package:flutter/material.dart';

import '../../const/const.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchFilter = TextEditingController();
  String searchText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text("Search", style: appbarTextStyle),
      ),
      body: TextField(
        controller: searchFilter,
        onChanged: (value) {},
        onSubmitted: (value) {
          searchText = value;
          setState(() {
            print(searchText);
            print(searchText!.isEmpty);
          });
        },
        decoration: const InputDecoration(hintText: "Search Here"),
      ),
    );
  }
}
