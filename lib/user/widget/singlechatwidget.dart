import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/personmodel.dart';
import '../chatroom/chatdetails.dart';

class SingleChatWidget extends StatelessWidget {
  const SingleChatWidget({
    super.key,
    required this.pi,
    required this.personModel,
  });
  final PersonModel personModel;
  final double pi;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatDetailsApp(personModel: personModel),
              ));
        },
        child: Container(
          height: 80,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 1)
              ]),
          child: Row(
            children: [
              Flexible(
                  flex: 2,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(personModel.image),
                    radius: 30,
                  )),
              Flexible(
                  flex: 7,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Text(
                              personModel.name,
                              style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.5,
                                  color: const Color.fromRGBO(30, 30, 30, 1)),
                            ),
                            const Spacer(),
                            Text(
                              personModel.time,
                              style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5,
                                  color:
                                      const Color.fromRGBO(175, 175, 175, 1)),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Transform.rotate(
                              angle: personModel.isSend == true
                                  ? pi / 2.0
                                  : pi / 6.0,
                              child: const Icon(
                                IconlyLight.send,
                                size: 20,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              personModel.text,
                              style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: personModel.isSeen == true
                                      ? FontWeight.w500
                                      : FontWeight.w700,
                                  letterSpacing: 1,
                                  color: personModel.isSeen == true
                                      ? const Color.fromRGBO(88, 88, 88, 1)
                                      : const Color.fromRGBO(0, 143, 160, 1)),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
