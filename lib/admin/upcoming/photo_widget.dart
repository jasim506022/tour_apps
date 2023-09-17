import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../others/utilies.dart';
import '../../model/profiledatamodel.dart';
import '../../service/other/pushnotificationmessage.dart';

class PhotoWidget extends StatelessWidget {
  const PhotoWidget({
    super.key,
    required this.profileMode,
  });

  final ProfileDataModel profileMode;

  @override
  Widget build(BuildContext context) {
    PushNotificationMessage pushNotificationMessage = PushNotificationMessage();
    Utils utils = Utils(context);
    Color color = utils.getColor;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Card(
        color: Theme.of(context).cardColor,
        elevation: 1.5,
        child: Container(
          height: 120,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 2)),
                child: Image.network(
                  profileMode.image!,
                  height: 100,
                  width: 120,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        profileMode.name!,
                        style: GoogleFonts.inter(
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                  Text(
                    profileMode.phone!,
                    style: GoogleFonts.inter(
                        fontSize: 13,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  InkWell(
                    onTap: () {
                      pushNotificationMessage.sendNotificationAdmin(
                          profileMode.userDiveceToken!,
                          "Tour Apps",
                          "${profileMode.name!} will be present at Bus Stand in Tour Time");
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary),
                      child: Text(
                        "Sent Sms",
                        style: GoogleFonts.inter(
                            fontSize: 13,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            color: color),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
