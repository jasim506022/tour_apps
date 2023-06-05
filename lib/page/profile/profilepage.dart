import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tour_apps/page/mainpage.dart';
import '../../const/const.dart';
import '../../widget/textfieldwidget copy.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ImagePicker picker = ImagePicker();
  XFile? image;

  TextEditingController nameEC = TextEditingController();
  TextEditingController prefessionalEC = TextEditingController();
  TextEditingController dateofbirthEC = TextEditingController();
  TextEditingController descriptionEC = TextEditingController();

  takePhoto(ImageSource source) async {
    final pickIfile = await picker.pickImage(source: source);
    setState(() {
      image = pickIfile;
      Navigator.pop(context);
    });
  }

  bottomSheet() {
    return AlertDialog(
      title: const Text(
        "Choose Profile, Photo",
        style: TextStyle(fontSize: 20),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              icon: const Icon(Icons.camera),
              label: const Text("Camera")),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton.icon(
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              icon: const Icon(Icons.image),
              label: const Text("Gallery")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    image == null
                        ? const CircleAvatar(
                            radius: 72,
                            backgroundImage:
                                AssetImage("asset/image/ion_earth400.png"))
                        : CircleAvatar(
                            radius: 72,
                            backgroundImage: FileImage(File(image!.path)),
                          ),
                    Positioned(
                        bottom: 20,
                        right: 20,
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => bottomSheet(),
                            );
                          },
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 30,
                          ),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormFieldWidgetWithLable(
                controller: nameEC,
                hintText: 'Name',
                icon: Icons.person,
                validatorText: '',
                labelttext: prefs!.getString('name')!,
              ),
              TextFormFieldWidgetWithLable(
                controller: prefessionalEC,
                hintText: 'Profession',
                icon: Icons.person,
                validatorText: '',
                labelttext: prefs!.getString('profession')!,
              ),
              TextFormFieldWidgetWithLable(
                controller: dateofbirthEC,
                hintText: 'Date of Birth',
                labelttext: prefs!.getString('birth')!,
                icon: Icons.person,
                validatorText: '',
              ),
              // TextFormFieldWidgetWithLable(
              //   controller: nameEC,
              //   hintText: 'title',
              //   icon: Icons.person, validatorText: '', labelttext: '',
              // ),
              TextFormFieldWidgetWithLable(
                controller: descriptionEC,
                maxLines: 5,
                hintText: 'description',
                icon: Icons.abc,
                validatorText: '',
                labelttext: prefs!.getString('about')!,
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: size.width,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff008FA0),
                        padding: const EdgeInsets.symmetric(vertical: 10)),
                    onPressed: () async {
                      await prefs!.setString('name', nameEC.text.trim());
                      await prefs!
                          .setString('profession', prefessionalEC.text.trim());
                      await prefs!
                          .setString('birth', dateofbirthEC.text.trim());
                      await prefs!
                          .setString('about', descriptionEC.text.trim());

                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainPage(),
                          ));
                    },
                    child: Text(
                      "Save",
                      style: GoogleFonts.inter(
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                          color: Colors.white
                          //textStyle: TextStyle()
                          ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



//  

//  Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton.icon(
//                   onPressed: () {
//                     takePhoto(ImageSource.camera);
//                   },
//                   icon: const Icon(Icons.camera),
//                   label: const Text("Camera")),
//               ElevatedButton.icon(
//                   onPressed: () {
//                     takePhoto(ImageSource.gallery);
//                   },
//                   icon: const Icon(Icons.image),
//                   label: const Text("Gallery")),
//             ],
//           )
       