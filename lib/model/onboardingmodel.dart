import 'package:flutter/material.dart';

class OnboardModel {
  String img;
  String text;
  String desc;
  Color bg;
  Color button;

  OnboardModel({
    required this.img,
    required this.text,
    required this.desc,
    required this.bg,
    required this.button,
  });
}

List<OnboardModel> onboardModeList = [
  OnboardModel(
      img: "asset/onboarding/photoone.png",
      text: "Plan Your Dream Vacation",
      desc:
          "Turn your travel dreams into reality. Plan every detail of your vacation with our intuitive app. From flights to accommodations, we've got you covered.",
      bg: Colors.white,
      button: Colors.black),
  OnboardModel(
      img: "asset/onboarding/phonetwo.png",
      text: "Plan, Book, and Go!",
      desc:
          " Plan your trip, book your journey, and embark on your next adventure with ease. Our app simplifies travel planning so you can focus on making memories.",
      bg: Colors.black,
      button: Colors.white),
  OnboardModel(
      img: "asset/onboarding/photothree.png",
      text: "ravel Smarter with Our App",
      desc:
          " Make the most of your travels with our smart travel app. Access exclusive deals, travel tips, and real-time updates to enhance your journey.",
      bg: Colors.black,
      button: Colors.black)
];
