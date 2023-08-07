import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GroupTourModel with ChangeNotifier {
  String? id;
  double? bookingsit;
  double? cost;
  double? rate;
  String? description;
  String? duration;
  String? location;
  String? tourname;
  Timestamp? publishdate;
  Timestamp? tourdate;
  List<dynamic>? image;

  GroupTourModel({
    this.bookingsit,
    this.cost,
    this.rate,
    this.description,
    this.duration,
    this.location,
    this.tourname,
    this.publishdate,
    this.tourdate,
    this.image,
    this.id,
  });

  factory GroupTourModel.fromMap(Map<String, dynamic> map) {
    return GroupTourModel(
      bookingsit: map["bookingsit"],
      cost: map["cost"],
      rate: map["rate"],
      duration: map["duration"],
      location: map["location"],
      description: map["description"],
      tourname: map["tourname"],
      publishdate: map["publishdate"],
      tourdate: map["tourdate"],
      image: map["image"],
      id: map["id"],
    );
  }
}
