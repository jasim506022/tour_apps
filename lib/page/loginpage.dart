import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/textfieldwidget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailEC = TextEditingController();
  TextEditingController passwordEC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
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
                                child:
                                    Image.asset("asset/image/ion_earth400.png"),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Column(
                                children: [
                                  TextFormFieldWidget(
                                    controller: emailEC,
                                    hintText: 'Enter Your Email Address',
                                    keyboardType: TextInputType.emailAddress,
                                    icon: Icons.email,
                                  ),
                                  TextFormFieldWidget(
                                    controller: emailEC,
                                    hintText: 'Enter Your Password',
                                    obscureText: true,
                                    icon: Icons.lock,
                                  ),
                                ],
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                  Text(
                                    "Forget Password",
                                    style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w700,
                                        color:
                                            const Color.fromRGBO(99, 99, 99, 1)
                                        //textStyle: TextStyle()
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
                                    onPressed: () {},
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
                                            color: Color(0xff008FA0), width: 2),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10)),
                                    onPressed: () {},
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
                                  color: Colors.white, shape: BoxShape.circle),
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
                                  color: Colors.white, shape: BoxShape.circle),
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
                                  color: Colors.white, shape: BoxShape.circle),
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
                                  fontSize: 10,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1,
                                  color: Colors.white
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
            ],
          ),
        ),
      ),
    );
  }
}
