import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:tour_apps/admin/group/uploadgrouppage.dart';
import 'package:tour_apps/admin/widget/delete_tour.dart';
import 'package:tour_apps/others/const.dart';
import 'package:tour_apps/others/globalcolor.dart';
import '../../others/textstyle.dart';
import '../../model/grouptipmodel.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import '../../service/provider/details_provider.dart';
import '../../widget/change_image_silder_widget.dart';

class GroupDetailsAdminPage extends StatefulWidget {
  const GroupDetailsAdminPage({
    super.key,
    required this.model,
  });

  final GroupTourModel model;

  @override
  State<GroupDetailsAdminPage> createState() => _GroupDetailsAdminPageState();
}

class _GroupDetailsAdminPageState extends State<GroupDetailsAdminPage> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
      DetailsProvider detailsProvider =
          Provider.of<DetailsProvider>(context, listen: false);
      detailsProvider.setImage(imageNumber: 0);
      detailsProvider.setColor(colorNumber: 0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.model.tourname} View",
        ),
        centerTitle: true,
        actions: [
          Consumer<DetailsProvider>(
            builder: (context, values, child) {
              return PopupMenuButton(onSelected: (value) {
                values.setMenu(setMenu: value);
                if (values.getMenu == DeleteUpdate.delete) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DeleteTour(
                          id: widget.model.id!, collection: "grouptrips");
                    },
                  );
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UploadGroupPage(
                            groupTourModel: widget.model, isUpdate: true),
                      ));
                }
              }, itemBuilder: (BuildContext bc) {
                return [
                  const PopupMenuItem(
                    value: DeleteUpdate.delete,
                    child: Text("Delete"),
                  ),
                  const PopupMenuItem(
                    value: DeleteUpdate.update,
                    child: Text("Update"),
                  ),
                ];
              });
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<DetailsProvider>(
                builder: (context, value, child) {
                  return ChangeImageSildeWidget(
                      value: value, model: widget.model);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(widget.model.tourname!,
                      overflow: TextOverflow.ellipsis,
                      style: largeTextStyle.copyWith(
                        fontSize: 22,
                        color: Theme.of(context).colorScheme.secondary,
                      )),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: yelloColor,
                        size: 22,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(widget.model.rate.toString(),
                          style: largestTextStyle.copyWith(
                              color: Theme.of(context).hintColor)),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Ionicons.location_sharp,
                    size: 18,
                    color: lightTextColor,
                  ),
                  Text(
                    widget.model.location!,
                    style: mediumTextStyle.copyWith(
                        color: Theme.of(context).hintColor),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('yyyy-MM-dd HH:mm:ss')
                          .format(widget.model.tourdate!.toDate()),
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.model.duration!,
                      style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.model.description!,
                textAlign: TextAlign.justify,
                style: largestTextStyle.copyWith(
                    fontSize: 15, color: Theme.of(context).hintColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      height: 45,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: const Color.fromRGBO(233, 233, 233, 1),
                              width: 1)),
                      child: Text("4 Persons | \$ ${widget.model.cost}",
                          textAlign: TextAlign.justify,
                          style: appbarTextStyle.copyWith(color: white)),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
