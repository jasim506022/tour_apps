import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class TripsModel {
  String? tripsId;
  String? tripsname;
  String? triplocation;
  String? tripsrate;
  String? tripcost;
  List<dynamic>? tripimage;
  String? tripcategories;
  String? tripdescript;
  Timestamp? publishdate;
  TripsModel({
    this.tripsId,
    this.tripsname,
    this.triplocation,
    this.tripsrate,
    this.tripcost,
    this.tripimage,
    this.tripcategories,
    this.tripdescript,
    this.publishdate,
  });

  factory TripsModel.fromMap(Map<String, dynamic> map) {
    return TripsModel(
      tripsId: map['tripsId'],
      tripsname: map['tripsname'],
      triplocation: map['triplocation'],
      tripsrate: map['tripsrate'],
      tripcost: map['tripcost'],
      tripimage: map['tripimage'],
      tripcategories: map['tripcategories'],
      tripdescript: map['tripdescript'],
      publishdate: map['publishdate'],
    );
  }

  static List<TripsModel> snapshotTripsList(List tripsList) {
    return tripsList.map((e) => TripsModel.fromMap(e)).toList();
  }
}

class TripsModels {
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
  TripsModels({
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

  factory TripsModels.fromMap(Map<String, dynamic> map) {
    return TripsModels(
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
