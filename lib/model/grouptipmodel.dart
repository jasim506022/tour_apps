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
