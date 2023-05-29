import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/textfieldwidget.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController emailEC = TextEditingController();
  TextEditingController passwordEC = TextEditingController();
  TextEditingController nameEC = TextEditingController();
  TextEditingController confirmpasswordEC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Container(
                height: size.height,
                width: size.width,
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 23, vertical: 20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Let’s start your\nJourney together!",
                        style: GoogleFonts.inter(
                            fontSize: 25,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                            color: const Color.fromRGBO(30, 30, 30, 1)
                            //textStyle: TextStyle()
                            ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Image.asset("asset/image/ion_earth400.png"),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormFieldWidget(
                        controller: nameEC,
                        hintText: 'Enter Your name',
                        icon: Icons.person,
                      ),
                      TextFormFieldWidget(
                        controller: emailEC,
                        hintText: 'Enter Your Email Address',
                        keyboardType: TextInputType.emailAddress,
                        icon: Icons.email,
                      ),
                      TextFormFieldWidget(
                        controller: passwordEC,
                        hintText: 'Enter Your Password',
                        obscureText: true,
                        icon: Icons.lock,
                      ),
                      TextFormFieldWidget(
                        controller: confirmpasswordEC,
                        hintText: 'Enter Your Confirm  Password',
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        icon: Icons.lock,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: size.width,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff008FA0),
                                padding: const EdgeInsets.symmetric(vertical: 10)),
                            onPressed: () {},
                            child: Text(
                              "Sign Up",
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
                      Center(
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: 'Already have an Account? ',
                            style: GoogleFonts.inter(
                                fontSize: 10,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1,
                                color: const Color.fromARGB(255, 36, 36, 36)
                                //textStyle: TextStyle()
                                ),
                          ),
                          TextSpan(
                            text: 'Sign in',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                              decoration: TextDecoration.underline,
                              color: const Color.fromARGB(255, 36, 36, 36),
                            ),
                          )
                        ])),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  right: -100,
                  child: Image.asset(
                    "asset/image/ion_earth400.png",
                    color: Colors.blue.withOpacity(.07),
                    height: size.height * .45,
                    width: size.width,
                    fit: BoxFit.cover,
                  )),
              Positioned(
                  left: -100,
                  bottom: -50,
                  child: Image.asset(
                    "asset/image/ion_earth400.png",
                    color: Colors.blue.withOpacity(.07),
                    height: size.height * .45,
                    width: size.width,
                    fit: BoxFit.cover,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
