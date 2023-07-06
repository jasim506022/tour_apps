import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tour_apps/const/const.dart';
import 'package:tour_apps/page/auth/loginpage.dart';
import '../../model/personmodel.dart';
import '../../widget/singlechatwidget.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({super.key});

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  double pi = 3.1415926535897932;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: const Text(
          "Chat Room",
        ),
        centerTitle: true,
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(Icons.edit_calendar),
          ),
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ));
                Fluttertoast.showToast(msg: "Sig nout");
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: TextFormField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Search",
                  prefixIcon: const Icon(Icons.search),
                  contentPadding: const EdgeInsets.only(left: 20),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xffE9E9E9)),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Color(0xffE9E9E9)),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: personList.length,
                  itemBuilder: (context, index) {
                    return SingleChatWidget(
                      pi: pi,
                      personModel: personList[index],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
