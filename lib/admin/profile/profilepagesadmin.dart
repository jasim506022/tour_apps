import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tour_apps/service/provider/themeprovider.dart';
import 'package:tour_apps/user/page/profile/historytour.dart';
import '../../../auth/loginpage.dart';
import '../../others/const.dart';
import '../../others/utilies.dart';
import '../upcoming/upcomingbookingpage.dart';
import 'editprofilepageadmin.dart';

class ProfilePageAdmin extends StatefulWidget {
  const ProfilePageAdmin({super.key});

  @override
  State<ProfilePageAdmin> createState() => _ProfilePageAdminState();
}

class _ProfilePageAdminState extends State<ProfilePageAdmin> {
  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: Scaffold(
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
                      border: Border.all(color: utils.getColor, width: 8)),
                  child: CircleAvatar(
                    backgroundImage:
                        NetworkImage(prefs!.getString("adminimage")!),
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
                        builder: (context) =>
                            EditProfilePageAdmin(isEditProfile: true),
                      ));
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child: Text("Edit Profile",
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        letterSpacing: 1.2,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w800,
                        color: utils.getColor,
                      )),
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
                    builder: (context) =>
                        EditProfilePageAdmin(isEditProfile: false),
                  ));
            },
          ),
          ListTileWidget(
            leadingIcon: Icons.save_outlined,
            text: 'Upcoming Tour',
            fucntion: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UpcomingBookingTourPage(),
                  ));
            },
          ),
          ListTileWidget(
            leadingIcon: Icons.history_outlined,
            text: 'History',
            fucntion: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HistoryTour(),
                  ));
            },
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
                    color: Theme.of(context).hintColor,
                  )),
            ),
          ),
          ListTileWidget(
            leadingIcon: Icons.language_outlined,
            text: 'Language',
            fucntion: () {},
          ),
          SwitchListTile(
              title: Text(
                themeProvider.getDarkTheme ? 'Dark' : 'Light',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  letterSpacing: 1.2,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).hintColor,
                ),
              ),
              secondary: Icon(
                themeProvider.getDarkTheme ? Icons.dark_mode : Icons.light_mode,
                color: Theme.of(context).hintColor,
                size: 30,
              ),
              value: themeProvider.getDarkTheme,
              onChanged: (bool value) {
                setState(() {
                  themeProvider.setDarkTheme = value;
                });
              }),
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
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ));
            },
          )
        ],
      )),
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
        color: Theme.of(context).hintColor,
        size: 30,
      ),
      title: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 16,
          letterSpacing: 1.2,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700,
          color: Theme.of(context).hintColor,
        ),
      ),
      trailing: IconButton(
          onPressed: fucntion,
          icon: Icon(
            Icons.arrow_forward_ios,
            color: Theme.of(context).hintColor,
          )),
    );
  }
}
