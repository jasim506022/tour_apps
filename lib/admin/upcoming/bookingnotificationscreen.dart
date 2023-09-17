import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../service/other/pushnotificationmessage.dart';

// ignore: must_be_immutable
class BookingNotificationScreen extends StatefulWidget {
  BookingNotificationScreen({super.key, this.userId});
  String? userId;

  @override
  State<BookingNotificationScreen> createState() =>
      _BookingNotificationScreenState();
}

class _BookingNotificationScreenState extends State<BookingNotificationScreen> {
  @override
  void initState() {
    super.initState();
  }

  PushNotificationMessage pushNotificationMessage = PushNotificationMessage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Booking Tour'),
        ),
        body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("users")
              .where('uid', isEqualTo: widget.userId)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Card(
                color: Colors.grey.shade200,
                elevation: 1.5,
                child: Container(
                  height: 120,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green, width: 2)),
                        child: Image.network(
                          snapshot.data!.docs[0]['image'],
                          height: 100,
                          width: 120,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                snapshot.data!.docs[0]['phone'],
                                style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600,
                                    color: const Color.fromRGBO(30, 30, 30, 1)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              if (kDebugMode) {
                                print(snapshot.data!.docs[0]['name']);
                              }
                            },
                            child: Text(
                              snapshot.data!.docs[0]['name'],
                              style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w600,
                                  color: const Color.fromRGBO(30, 30, 30, 1)),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              pushNotificationMessage.sendNotificationAdmin(
                                snapshot.data!.docs[0]['userDiveceToken'],
                                "Tour Apps",
                                "Thanks ${snapshot.data!.docs[0]['name']} for Booking Tour",
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration:
                                  const BoxDecoration(color: Colors.black),
                              child: Text(
                                "Send Sms",
                                style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
