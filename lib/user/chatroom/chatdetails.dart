import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/personmodel.dart';


class ChatDetailsApp extends StatefulWidget {
  const ChatDetailsApp({super.key, required this.personModel});
  final PersonModel personModel;

  @override
  State<ChatDetailsApp> createState() => _ChatDetailsAppState();
}

class _ChatDetailsAppState extends State<ChatDetailsApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.personModel.image),
                radius: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.personModel.name,
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(30, 30, 30, 1)),
                  ),
                  Text(
                    "Online",
                    style: GoogleFonts.inter(
                        fontSize: 10,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(0, 143, 160, 1)),
                  ),
                ],
              ),
            ],
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Icon(
                    IconlyLight.video,
                    size: 25,
                    color: Color.fromRGBO(130, 130, 130, 1),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Icon(
                      IconlyLight.call,
                      size: 25,
                      color: Color.fromRGBO(130, 130, 130, 1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: messages.length,
          //     itemBuilder: (context, index) {
          //       if (messages[index]['isMe'] == true) {
          //         return Align(
          //           alignment: Alignment.centerRight,
          //           child: ConstrainedBox(
          //             constraints: BoxConstraints(
          //               maxWidth: MediaQuery.of(context).size.width - 45,
          //             ),
          //             child: Card(
          //               elevation: 1,
          //               shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(8)),
          //               color: const Color.fromRGBO(0, 69, 77, 1),
          //               margin: const EdgeInsets.symmetric(
          //                   horizontal: 15, vertical: 5),
          //               child: Stack(
          //                 children: [
          //                   Padding(
          //                     padding: const EdgeInsets.only(
          //                       left: 10,
          //                       right: 30,
          //                       top: 5,
          //                       bottom: 20,
          //                     ),
          //                     child: Text(
          //                       messages[index]['text'].toString(),
          //                       style: const TextStyle(
          //                           fontSize: 12, color: Colors.white),
          //                     ),
          //                   ),
          //                   Positioned(
          //                     bottom: 4,
          //                     right: 10,
          //                     child: Row(
          //                       children: [
          //                         Text(
          //                           messages[index]['time'].toString(),
          //                           style: const TextStyle(
          //                             fontSize: 9,
          //                             color: Colors.white60,
          //                           ),
          //                         ),
          //                         const SizedBox(
          //                           width: 5,
          //                         ),
          //                         const Icon(
          //                           Icons.done_all,
          //                           size: 16,
          //                           color: Colors.white60,
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         );
          //       }
          //       return Align(
          //         alignment: Alignment.centerLeft,
          //         child: ConstrainedBox(
          //           constraints: BoxConstraints(
          //             maxWidth: MediaQuery.of(context).size.width - 80,
          //           ),
          //           child: Padding(
          //             padding: const EdgeInsets.symmetric(
          //                 horizontal: 15, vertical: 5),
          //             child: Row(
          //               children: [
          //                 CircleAvatar(
          //                   backgroundImage:
          //                       NetworkImage(widget.personModel.image),
          //                   radius: 18,
          //                 ),
          //                 const SizedBox(
          //                   width: 10,
          //                 ),
          //                 Expanded(
          //                   child: Card(
          //                     elevation: 1,
          //                     shape: RoundedRectangleBorder(
          //                         borderRadius: BorderRadius.circular(8)),
          //                     color: Colors.white.withOpacity(.9),
          //                     child: Stack(
          //                       children: [
          //                         Padding(
          //                           padding: const EdgeInsets.only(
          //                             left: 10,
          //                             right: 30,
          //                             top: 5,
          //                             bottom: 20,
          //                           ),
          //                           child: Text(
          //                             messages[index]['text'].toString(),
          //                             style: const TextStyle(
          //                                 fontWeight: FontWeight.w600,
          //                                 fontSize: 12,
          //                                 color: Colors.black),
          //                           ),
          //                         ),
          //                         Positioned(
          //                           bottom: 4,
          //                           right: 10,
          //                           child: Row(
          //                             children: [
          //                               Text(
          //                                 messages[index]['time'].toString(),
          //                                 style: const TextStyle(
          //                                   fontSize: 9,
          //                                   color: Colors.black,
          //                                 ),
          //                               ),
          //                               const SizedBox(
          //                                 width: 5,
          //                               ),
          //                               const Icon(
          //                                 Icons.done_all,
          //                                 size: 16,
          //                                 color: Colors.black,
          //                               ),
          //                             ],
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
         
         
          TextField(
            decoration: InputDecoration(
              filled: true,
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black26)),
              fillColor: Colors.white,
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(
                  Icons.emoji_emotions,
                  color: Colors.grey,
                ),
              ),
              suffixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.camera_alt,
                      color: Colors.grey,
                    ),
                    Icon(
                      Icons.attach_file,
                      color: Colors.grey,
                    ),
                    Icon(
                      Icons.money,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              hintText: 'Type a message!',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              contentPadding: const EdgeInsets.all(10),
            ),
          ),
        ],
      ),
    );
  }
}
