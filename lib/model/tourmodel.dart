import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TourModel with ChangeNotifier {
  String? id;
  String? tourname;
  String? location;
  String? rate;
  String? cost;
  List<dynamic>? image;
  String? categoris;
  String? description;
  Timestamp? publishdate;
  Timestamp? tourdate;
  TourModel({
    this.id,
    this.tourname,
    this.location,
    this.rate,
    this.cost,
    this.image,
    this.categoris,
    this.description,
    this.tourdate,
    this.publishdate,
  });

  factory TourModel.fromMap(Map<String, dynamic> map) {
    return TourModel(
      id: map['id'],
      tourname: map['tourname'],
      location: map['location'],
      rate: map['rate'],
      cost: map['cost'],
      image: map['image'],
      categoris: map['categoris'],
      description: map['description'],
      publishdate: map['publishdate'],
      tourdate: map['tourdate'],
    );
  }
}
