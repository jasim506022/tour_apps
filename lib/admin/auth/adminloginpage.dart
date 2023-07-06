import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tour_apps/admin/adminmainpage.dart';
import 'package:tour_apps/page/auth/forgetpasswordpage.dart';
import 'package:tour_apps/page/auth/loginpage.dart';
import 'package:tour_apps/widget/loadingdialogwidget.dart';
import '../../const/const.dart';
import '../../widget/textfieldwidget.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  TextEditingController emailEC = TextEditingController();
  TextEditingController passwordEC = TextEditingController();
  var key = GlobalKey<FormState>();

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
                            "For Admin",
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
                                Text(
                                  "User Don't try this",
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.red),
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
                                      TextFormFieldWidget(
                                        controller: passwordEC,
                                        hintText: 'Enter Your Password',
                                        obscureText: true,
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
                          Center(
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: 'If you are user.  ',
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1,
                                    color: Colors.white
                                    //textStyle: TextStyle()
                                    ),
                              ),
                              TextSpan(
                                text: 'User Login',
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

      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdminMainPage(),
          ));
    }
  }
}
