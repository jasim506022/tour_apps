import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tour_apps/user/profile/editprofilepage.dart';

import '../../auth/loginpage.dart';
import '../../const/const.dart';

class ProfilePages extends StatefulWidget {
  const ProfilePages({super.key});

  @override
  State<ProfilePages> createState() => _ProfilePagesState();
}

class _ProfilePagesState extends State<ProfilePages> {
  String name = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // backgroundColor: Colors.white,
          // appBar: AppBar(
          //   backgroundColor: Theme.of(context).primaryColor,
          //   iconTheme: const IconThemeData(color: Colors.white),
          //   title: Text("Profile",
          //       style: appbarTextStyle.copyWith(color: Colors.white)),
          // ),
          body: ListView(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).primaryColor,
              ),
              Positioned(
                top: 100,
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 8)),
                  child: CircleAvatar(
                    backgroundImage:
                        NetworkImage(prefs!.getString("userimage")!),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 110,
          ),
          Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfilePage(),
                      ));
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: black,
                  ),
                  child: Text("Edit Profile",
                      style: GoogleFonts.inter(
                          fontSize: 13,
                          letterSpacing: 1.2,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w800,
                          color: Colors.white)),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ListTileWidget(
            leadingIcon: Icons.person_outline,
            text: 'Profile',
            fucntion: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfilePage(),
                  ));
            },
          ),
          ListTileWidget(
            leadingIcon: Icons.save_outlined,
            text: 'Booking Tour',
            fucntion: () {},
          ),
          ListTileWidget(
            leadingIcon: Icons.tour_outlined,
            text: 'Next Tour',
            fucntion: () {},
          ),
          ListTileWidget(
            leadingIcon: Icons.history_outlined,
            text: 'History',
            fucntion: () {},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Preference",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    letterSpacing: 1.2,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  )),
            ),
          ),
          ListTileWidget(
            leadingIcon: Icons.language_outlined,
            text: 'Language',
            fucntion: () {},
          ),
          ListTileWidget(
            leadingIcon: Icons.dark_mode_outlined,
            text: 'DarkMode',
            fucntion: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
              size: 30,
            ),
            title: Text(
              "Logout",
              style: GoogleFonts.inter(
                  fontSize: 16,
                  letterSpacing: 1.2,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w800,
                  color: Colors.red),
            ),
          )
        ],
      )

          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          //   child: SingleChildScrollView(
          //     child: StreamBuilder(
          //       stream: FirebaseFirestore.instance
          //           .collection("admin")
          //           .doc("admin")
          //           .snapshots(),
          //       builder: (context, snapshot) {
          //         return Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             IconButton(
          //                 onPressed: () {
          //                   Navigator.push(
          //                       context,
          //                       MaterialPageRoute(
          //                         builder: (context) => ProfilePage(),
          //                       ));
          //                 },
          //                 icon: const Icon(Icons.edit)),
          //             Center(
          //                 child: Container(
          //               decoration: BoxDecoration(
          //                   color: Colors.white,
          //                   shape: BoxShape.circle,
          //                   border: Border.all(color: Colors.black, width: 1)),
          //               child: snapshot.data!["image"] == ""
          //                   ? Icon(
          //                       Icons.person,
          //                       size: 144,
          //                     )
          //                   : CircleAvatar(
          //                       radius: 72,
          //                       backgroundImage:
          //                           NetworkImage(snapshot.data!["image"])),
          //             )),
          //             const SizedBox(
          //               height: 15,
          //             ),
          //             Text(snapshot.data!["name"],
          //                 style: textStyle.copyWith(
          //                     color: Colors.black,
          //                     fontWeight: FontWeight.w600,
          //                     fontSize: 16)),
          //             const SizedBox(
          //               height: 10,
          //             ),
          //             Text("Hello",
          //                 style: textStyle.copyWith(
          //                     color: unselectedColor,
          //                     fontWeight: FontWeight.w600,
          //                     fontSize: 15)),
          //             const SizedBox(
          //               height: 10,
          //             ),
          //             Divider(
          //               height: 4,
          //               color: unselectedColor,
          //             ),
          //             const SizedBox(
          //               height: 10,
          //             ),
          //             Text("About: ",
          //                 style: textStyle.copyWith(
          //                     color: Colors.black,
          //                     fontWeight: FontWeight.w800,
          //                     fontSize: 18)),
          //             const SizedBox(
          //               height: 2,
          //             ),
          //             Text(prefs!.getString('about') ?? "",
          //                 style: textStyle.copyWith(
          //                     color: unselectedColor,
          //                     fontWeight: FontWeight.w600,
          //                     fontSize: 15)),
          //             const SizedBox(
          //               height: 10,
          //             ),
          //             Text("Name: ",
          //                 style: textStyle.copyWith(
          //                     color: Colors.black,
          //                     fontWeight: FontWeight.w800,
          //                     fontSize: 18)),
          //             const SizedBox(
          //               height: 2,
          //             ),
          //             Text(prefs!.getString('name') ?? "",
          //                 style: textStyle.copyWith(
          //                     color: unselectedColor,
          //                     fontWeight: FontWeight.w600,
          //                     fontSize: 15)),
          //             const SizedBox(
          //               height: 10,
          //             ),
          //             Text("Profession: ",
          //                 style: textStyle.copyWith(
          //                     color: Colors.black,
          //                     fontWeight: FontWeight.w800,
          //                     fontSize: 18)),
          //             const SizedBox(
          //               height: 2,
          //             ),
          //             Text(prefs!.getString('profession') ?? "",
          //                 style: textStyle.copyWith(
          //                     color: unselectedColor,
          //                     fontWeight: FontWeight.w600,
          //                     fontSize: 15)),
          //             const SizedBox(
          //               height: 10,
          //             ),
          //             Text("Date of Birth: ",
          //                 style: textStyle.copyWith(
          //                     color: Colors.black,
          //                     fontWeight: FontWeight.w800,
          //                     fontSize: 18)),
          //             const SizedBox(
          //               height: 2,
          //             ),
          //             Text(prefs!.getString('birth') ?? "",
          //                 style: textStyle.copyWith(
          //                     color: unselectedColor,
          //                     fontWeight: FontWeight.w600,
          //                     fontSize: 15)),
          //             const SizedBox(
          //               height: 10,
          //             ),
          //             Divider(
          //               height: 4,
          //               color: unselectedColor,
          //             ),
          //             const SizedBox(
          //               height: 10,
          //             ),
          //             ListTile(
          //               onTap: () {
          //                 FirebaseAuth.instance.signOut();
          //                 Navigator.push(
          //                     context,
          //                     MaterialPageRoute(
          //                       builder: (context) => const LoginPage(),
          //                     ));
          //               },
          //               title: Text("Logout",
          //                   style: textStyle.copyWith(
          //                       color: unselectedColor,
          //                       fontWeight: FontWeight.w600,
          //                       fontSize: 15)),
          //               leading: const Icon(
          //                 Icons.logout,
          //                 color: Colors.black,
          //               ),
          //             )
          //           ],
          //         );
          //       },
          //     ),
          //   ),
          // ),

          ),
    );
  }
}

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    super.key,
    required this.leadingIcon,
    required this.text,
    required this.fucntion,
  });
  final IconData leadingIcon;
  final String text;
  final VoidCallback fucntion;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        leadingIcon,
        color: Colors.black87,
        size: 30,
      ),
      title: Text(
        text,
        style: GoogleFonts.inter(
            fontSize: 16,
            letterSpacing: 1.2,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
            color: Colors.black87),
      ),
      trailing: IconButton(
          onPressed: fucntion,
          icon: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.black87,
          )),
    );
  }
}
