import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tour_apps/auth/loginpage.dart';
import '../auth/adminloginpage.dart';
import '../model/onboardingmodel.dart';
import '../others/const.dart';

class OnBoardPage extends StatefulWidget {
   OnBoardPage({super.key, this.isAdmin =true});
 bool isAdmin = true;
  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  tourOnboardInfo() async {
    int isViewed = 0;

    await prefs!.setInt('onBoard', isViewed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentIndex % 2 == 0
          ? Colors.white
          : const Color.fromARGB(255, 102, 117, 255),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: currentIndex % 2 == 0
            ? Colors.white
            : const Color.fromARGB(255, 102, 117, 255),
        elevation: 0.0,
        actions: [
          TextButton(
              onPressed: () {
                tourOnboardInfo();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => widget.isAdmin==true? const AdminLoginPage(): const LoginPage(),
                    ));
              },
              child: Text("Skip",
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      color: currentIndex % 2 == 0
                          ? Theme.of(context).primaryColor
                          : Colors.white)))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: PageView.builder(
          controller: pageController,
          itemCount: onboardModeList.length,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  onboardModeList[index].img,
                  height: 350,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: 10.0,
                  child: ListView.builder(
                    itemCount: onboardModeList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 8,
                            width: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            decoration: BoxDecoration(
                                color: currentIndex == index
                                    ? Colors.red
                                    : Colors.brown,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Text(
                  onboardModeList[index].text,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: currentIndex % 2 == 0
                          ? Theme.of(context).primaryColor
                          : Colors.white),
                ),
                Text(onboardModeList[index].desc,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        color: currentIndex % 2 == 0
                            ? Theme.of(context).primaryColor
                            : Colors.white)),
                InkWell(
                  onTap: () async {
                    if (index == onboardModeList.length - 1) {
                      await tourOnboardInfo();
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => widget.isAdmin==true? const AdminLoginPage(): const LoginPage(),
                          ));
                    }
                    pageController.nextPage(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.bounceIn);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    decoration: BoxDecoration(
                        color: currentIndex % 2 == 0
                            ? const Color.fromARGB(255, 0, 0, 215)
                            : Colors.black,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Next",
                          style: GoogleFonts.inter(
                              fontSize: 20,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Icon(
                          Icons.arrow_forward_sharp,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
