import 'package:cloud_firestore/cloud_firestore.dart';

class GroupTipsModel {
  final String tourplace;
  final String location;
  final double cost;
  double progressNumber;
  final List<String> image;

  GroupTipsModel(
      {required this.tourplace,
      required this.location,
      required this.cost,
      required this.image,
      required this.progressNumber});
}

class GroupTipsModelFirebase {
  String? grouptrip;
  Timestamp? publishdate;
  String? tripcost;
  String? tripdescript;
  List<dynamic>? tripimage;
  String? triplocation;
  String? tripsname;
  String? tripsrate;

  GroupTipsModelFirebase(
      {this.grouptrip,
      this.publishdate,
      this.tripcost,
      this.tripdescript,
      this.tripimage,
      this.triplocation,
      this.tripsname,
      this.tripsrate});

  factory GroupTipsModelFirebase.fromMap(Map<String, dynamic> map) {
    return GroupTipsModelFirebase(
      grouptrip: map["grouptrip"],
      publishdate: map["publishdate"],
      tripcost: map["tripcost"],
      tripdescript: map["tripdescript"],
      tripimage: map["tripimage"],
      triplocation: map["triplocation"],
      tripsname: map["tripsname"],
      tripsrate: map["tripsrate"],
    );
  }
}

List<GroupTipsModel> grouptipsdetaillist = [
  GroupTipsModel(
      tourplace: "Cox's Bazar Beach",
      location: "Cox's Bazar",
      cost: 3000,
      image: [
        "https://c4.wallpaperflare.com/wallpaper/229/745/183/world-1920x1200-sea-coast-wallpaper-preview.jpg"
      ],
      progressNumber: .8),
  GroupTipsModel(
      tourplace: "Gangamati",
      progressNumber: .75,
      location: "Kuakata",
      cost: 2300,
      image: [
        "https://c4.wallpaperflare.com/wallpaper/799/608/26/bangladesh-forest-sunny-day-madhabpur-syleth-wallpaper-preview.jpg"
      ]),
  GroupTipsModel(
      tourplace: "Eriyadhu Island",
      progressNumber: .78,
      location: "Maldives ",
      cost: 23000,
      image: [
        "https://c4.wallpaperflare.com/wallpaper/61/3/660/artwork-fantasy-art-swan-digital-art-wallpaper-preview.jpg"
      ]),
  GroupTipsModel(
      tourplace: "Tanguar Haor",
      progressNumber: .69,
      location: "Sunamganj",
      cost: 2800,
      image: [
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/17/11/58/9f/panoramic-beauty-of-kaptai.jpg?w=1200&h=-1&s=1"
      ]),
];
