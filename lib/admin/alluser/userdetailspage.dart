import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../others/utilies.dart';
import '../../model/profiledatamodel.dart';
import '../../widget/textfieldwidget.dart';
import 'block_unblock_widget.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key, required this.profileModel});

  final ProfileDataModel profileModel;

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  String? dateValue;

  TextEditingController nameEC = TextEditingController();
  TextEditingController emailEC = TextEditingController();
  TextEditingController prefessionEC = TextEditingController();
  TextEditingController phoneEC = TextEditingController();
  TextEditingController descriptionEC = TextEditingController();

  @override
  void initState() {
    nameEC.text = widget.profileModel.name!;
    emailEC.text = widget.profileModel.email!;
    prefessionEC.text = widget.profileModel.profession!;
    phoneEC.text = widget.profileModel.phone!;
    descriptionEC.text = widget.profileModel.about!;
    dateValue = widget.profileModel.birth!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    return Scaffold(
        body: ListView(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).primaryColor,
            ),
            Positioned(
              top: 50,
              child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 8)),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.profileModel.image!),
                  )),
            ),
          ],
        ),
        const SizedBox(
          height: 80,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              TextFormFieldWidget(
                controller: nameEC,
                hintText: 'Name',
                icon: Icons.person,
                validatorText: '',
                enabled: false,
              ),
              TextFormFieldWidget(
                controller: emailEC,
                hintText: 'Email',
                icon: Icons.email,
                validatorText: '',
                enabled: false,
              ),
              const SizedBox(
                height: 15,
              ),
              DateTimePicker(
                  enabled: false,
                  type: DateTimePickerType.date,
                  dateHintText: "Select Tour Date and Time",
                  icon: Icon(
                    Icons.event,
                    color: Theme.of(context).primaryColor,
                  ),
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  initialValue: dateValue,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  onChanged: (val) {
                    setState(() {
                      dateValue = val;
                    });
                  }),
              TextFormFieldWidget(
                keyboardType: TextInputType.number,
                controller: phoneEC,
                hintText: 'Phone Number',
                icon: Icons.phone,
                validatorText: '',
                enabled: false,
              ),
              TextFormFieldWidget(
                keyboardType: TextInputType.number,
                controller: prefessionEC,
                hintText: 'Profession',
                icon: Icons.work,
                validatorText: '',
                enabled: false,
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 30)),
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return BlockUnBlockWidget(
                            profileModel: widget.profileModel,
                          );
                        },
                      );
                    },
                    child: Text(
                      widget.profileModel.status == "approved"
                          ? "Block"
                          : "Approved",
                      style: GoogleFonts.inter(
                          fontSize: 15,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                          color: utils.getColor
                          //textStyle: TextStyle()
                          ),
                    )),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    ));
  }
}
