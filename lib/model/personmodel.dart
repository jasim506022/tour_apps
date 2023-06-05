class PersonModel {
  final String image;
  final String text;
  final String time;
  final String name;
  final bool isSeen;
  final bool isSend;

  PersonModel({
    required this.image,
    required this.text,
    required this.time,
    required this.name,
    required this.isSeen,
    required this.isSend,
  });
}

List<PersonModel> personList = [
  PersonModel(
      image:
          "https://cdn.pixabay.com/photo/2016/12/03/20/02/child-portrait-1880477_640.jpg",
      text: "See you next week!",
      time: "09:32 AM",
      name: "Jessie Cooper",
      isSeen: true,
      isSend: false),
  PersonModel(
      image:
          "https://cdn.pixabay.com/photo/2018/05/15/15/00/man-3403180_640.jpg",
      text: "That’s Great, Thankyou!",
      time: "06:32 AM",
      name: "Shawn Jones",
      isSend: true,
      isSeen: true),
  PersonModel(
      image:
          "https://cdn.pixabay.com/photo/2016/03/31/17/17/woman-1293658_640.jpg",
      text: "How are you !",
      time: "09:32 AM",
      isSeen: true,
      isSend: true,
      name: "Md Jasim"),
  PersonModel(
      image:
          "https://cdn.pixabay.com/photo/2013/10/21/10/01/man-198949_640.jpg",
      text: "Voice Message 3:02!",
      time: "10:32 AM",
      isSeen: false,
      isSend: false,
      name: "Alexandria Lexi"),
  PersonModel(
      image:
          "https://cdn.pixabay.com/photo/2015/11/06/14/24/woman-1028398_640.jpg",
      text: "Waiting for you",
      time: "09:32 PM",
      isSeen: true,
      isSend: true,
      name: "Mary James"),
  PersonModel(
      image:
          "https://cdn.pixabay.com/photo/2017/12/30/11/58/man-3049894_640.jpg",
      text: "It’s at 3:30 sharp",
      time: "11:32 AM",
      isSeen: false,
      isSend: false,
      name: "Tom Parker"),
  PersonModel(
      image:
          "https://cdn.pixabay.com/photo/2018/01/15/09/17/woman-3083516_640.jpg",
      text: "What's your name",
      time: "09:32 AM",
      isSeen: true,
      isSend: true,
      name: "Nupur Akhter"),
];
