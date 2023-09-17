import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tour_apps/auth/registrationpage.dart';
import 'package:tour_apps/widget/loading_dialog_widget.dart';
import '../others/const.dart';
import '../service/provider/themeprovider.dart';
import '../widget/textfieldwidget.dart';
import '../user/mainpage.dart';
import 'adminloginpage.dart';
import 'forgetpasswordpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailEC = TextEditingController();
  TextEditingController passwordEC = TextEditingController();

  var key = GlobalKey<FormState>();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      var categoriesprovider =
          Provider.of<ThemeProvider>(context, listen: false);
      categoriesprovider.setDarkTheme = false;
    });
    super.initState();
  }

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
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
        SystemNavigator.pop();
        return false;
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
                            "Welcome Back!",
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
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        icon: Icons.email,
                                        validatorText: 'Email address Empty',
                                        hintText: 'Enter Your Email Address',
                                      ),
                                      TextFormFieldWidget(
                                        controller: passwordEC,
                                        obscureText: true,
                                        hintText: "Enter Your Password",
                                        icon: Icons.lock,
                                        validatorText: 'Pasword is Empty',
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.square_outlined,
                                            size: 20, color: Color(0xff008FA0)),
                                        Text(
                                          "Remember me",
                                          style: GoogleFonts.inter(
                                              fontSize: 12,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w700,
                                              color: const Color.fromRGBO(
                                                  99, 99, 99, 1)
                                              //textStyle: TextStyle()
                                              ),
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const ForgetPasswwordPage(),
                                            ));
                                      },
                                      child: Text(
                                        "Forget Password",
                                        style: GoogleFonts.inter(
                                            fontSize: 12,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w700,
                                            color: const Color.fromRGBO(
                                                99, 99, 99, 1)
                                            //textStyle: TextStyle()
                                            ),
                                      ),
                                    )
                                  ],
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
                                        loginForm();
                                      },
                                      child: Text(
                                        "Sign in",
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
                                text: 'for Admin',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AdminLoginPage(),
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

  void loginForm() async {
    if (key.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) {
          return const LoadingDialogWidget(
            message: 'Checking credential',
          );
        },
      );
      User? currentUser;
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailEC.text.trim(), password: passwordEC.text.trim())
          .then((value) {
        currentUser = value.user;
      }).catchError((error) {
        Navigator.pop(context);
        showToast(context: context, text: 'Error occured: \n $error');
      });

      if (currentUser != null) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(currentUser!.uid)
            .get()
            .then((value) async {
          if (value.exists) {
            //status is approved
            if (value.data()!["status"] == "approved") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainPage(),
                  ));
            } else {
              FirebaseAuth.instance.signOut();
              Navigator.pop(context);
              showToast(
                  context: context,
                  text:
                      "you have BLOCKED by admin.\ncontact Admin: admin@ishop.com");
            }
          } else {
            FirebaseAuth.instance.signOut();
            Navigator.pop(context);
            Fluttertoast.showToast(msg: "This User's record do not exists.");
          }
        });
      }
    }
  }
}
