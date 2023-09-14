import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tour_apps/auth/registrationpage.dart';


import '../others/const.dart';
import '../widget/textfieldwidget.dart';
import 'loginpage.dart';

class ForgetPasswwordPage extends StatefulWidget {
  const ForgetPasswwordPage({super.key});

  @override
  State<ForgetPasswwordPage> createState() => _ForgetPasswwordPageState();
}

class _ForgetPasswwordPageState extends State<ForgetPasswwordPage> {
  TextEditingController emailEC = TextEditingController();

  var key = GlobalKey<FormState>();

  @override
  void dispose() {

    emailEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: Container(
            color: Theme.of(context).primaryColor,
            height: size.height,
            width: size.width,
            child: Stack(
              children: [
                Positioned(
                    right: -200,
                    top: -150,
                    child: Image.asset(
                      "asset/image/ion_earth400.png",
                      color: Colors.white.withOpacity(.07),
                      height: size.height * .45,
                      width: size.width,
                      fit: BoxFit.cover,
                    )),
                Positioned(
                    left: -100,
                    bottom: -50,
                    child: Image.asset(
                      "asset/image/ion_earth400.png",
                      color: Colors.white.withOpacity(.07),
                      height: size.height * .45,
                      width: size.width,
                      fit: BoxFit.cover,
                    )),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 23, vertical: 30),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Forget Password",
                            style: GoogleFonts.inter(
                                fontSize: 25,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                                color: Colors.white
                                //textStyle: TextStyle()
                                ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30)),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                Center(
                                  child: Image.asset(
                                      "asset/image/ion_earth400.png"),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Form(
                                  key: key,
                                  child: Column(
                                    children: [
                                      TextFormFieldWidget(
                                        controller: emailEC,
                                        hintText: 'Enter Your Email Address',
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        icon: Icons.email,
                                        validatorText: 'Email address Empty',
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                SizedBox(
                                  width: size.width,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xff008FA0),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10)),
                                      onPressed: () async {
                                        passwordForm();
                                      },
                                      child: Text(
                                        "Send",
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
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: size.width,
                                  child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          side: const BorderSide(
                                              color: Color(0xff008FA0),
                                              width: 2),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10)),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const RegistrationPage(),
                                            ));
                                      },
                                      child: Text(
                                        "Create Account".toUpperCase(),
                                        style: GoogleFonts.inter(
                                            fontSize: 15,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 1,
                                            color: const Color(0xff008FA0)
                                            //textStyle: TextStyle()
                                            ),
                                      )),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: Image.asset(
                                  "asset/image/facebook.png",
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: Image.asset(
                                  "asset/image/google.png",
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: Image.asset(
                                  "asset/image/apple.png",
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: 'Already have an Account? ',
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1,
                                    color: Colors.white
                                    //textStyle: TextStyle()
                                    ),
                              ),
                              TextSpan(
                                text: 'Sign in',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage(),
                                        ));
                                  },
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1,
                                  decoration: TextDecoration.underline,
                                  color: Colors.white,
                                ),
                              )
                            ])),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void passwordForm() async {
    if (key.currentState!.validate()) {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(
            email: emailEC.text.trim(),
          )
          .then((value) {})
          .catchError((error) {
        showToast(context: context, text: 'Error occured: \n $error');
      });
    }
  }
}
