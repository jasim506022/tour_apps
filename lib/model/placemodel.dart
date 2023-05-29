class TourPlaceDetailsModel {
  final String tourplace;
  final double rate;
  final String location;
  final double cost;
  final String categories;
  final List<String> image;

  TourPlaceDetailsModel({
    required this.tourplace,
    required this.rate,
    required this.location,
    required this.cost,
    required this.image,
    required this.categories,
  });
}

//sea
List<TourPlaceDetailsModel> tourplacedetaillist = [
  TourPlaceDetailsModel(
      tourplace: "Cox's Bazar Beach",
      rate: 4.5,
      location: "Cox's Bazar",
      cost: 3000,
      image: [
        "https://c4.wallpaperflare.com/wallpaper/229/745/183/world-1920x1200-sea-coast-wallpaper-preview.jpg",
        "https://c4.wallpaperflare.com/wallpaper/440/12/60/nature-hd-for-pc-download-1920x1080-wallpaper-preview.jpg",
        "https://c4.wallpaperflare.com/wallpaper/615/107/638/beach-sandy-beach-lagoon-tropical-landscape-wallpaper-preview.jpg",
        "https://c4.wallpaperflare.com/wallpaper/272/558/421/two-orange-and-red-flowers-with-drew-drops-wallpaper-preview.jpg"
      ],
      categories: 'Sea'),
  TourPlaceDetailsModel(
      tourplace: "Kuakata Beach",
      rate: 4.3,
      location: "Patuakhali ",
      cost: 2500,
      categories: 'Sea',
      image: [
        "https://c4.wallpaperflare.com/wallpaper/615/107/638/beach-sandy-beach-lagoon-tropical-landscape-wallpaper-preview.jpg"
      ]),
  TourPlaceDetailsModel(
      tourplace: "Patenga sea beach",
      rate: 4.1,
      categories: 'Sea',
      location: "Chittagong",
      cost: 2200,
      image: [
        "https://c4.wallpaperflare.com/wallpaper/440/12/60/nature-hd-for-pc-download-1920x1080-wallpaper-preview.jpg"
      ]),
  TourPlaceDetailsModel(
      tourplace: "Indian Beach",
      rate: 4.0,
      categories: 'Sea',
      location: "Inia ",
      cost: 2000,
      image: [
        "https://c4.wallpaperflare.com/wallpaper/796/80/865/sunrise-over-the-horizon-sea-ships-sandy-beach-waves-beautiful-landscape-wallpapers-for-desktop-mobile-phones-and-laptops-3840%C3%972400-wallpaper-preview.jpg"
      ]),
  TourPlaceDetailsModel(
      tourplace: "Tarua Beach",
      rate: 4.0,
      location: "Bhola ",
      categories: 'Sea',
      cost: 2000,
      image: [
        "https://c4.wallpaperflare.com/wallpaper/272/558/421/two-orange-and-red-flowers-with-drew-drops-wallpaper-preview.jpg"
      ]),
  TourPlaceDetailsModel(
      tourplace: "Ratargul Swamp",
      rate: 4.8,
      location: "Sylhet",
      cost: 2500,
      image: [
        "https://c0.wallpaperflare.com/preview/135/981/228/bangladesh-landscape-nature-forest.jpg"
      ],
      categories: 'Forest'),
  TourPlaceDetailsModel(
      tourplace: "Lebur Char",
      rate: 4.5,
      location: "Chittagong ",
      cost: 2200,
      categories: 'Forest',
      image: [
        "https://c0.wallpaperflare.com/preview/439/18/445/brown-and-white-deer-during-daytime.jpg"
      ]),
  TourPlaceDetailsModel(
      tourplace: "Gangamati",
      rate: 4.1,
      categories: 'Forest',
      location: "Kuakata",
      cost: 2300,
      image: [
        "https://c4.wallpaperflare.com/wallpaper/799/608/26/bangladesh-forest-sunny-day-madhabpur-syleth-wallpaper-preview.jpg"
      ]),
  TourPlaceDetailsModel(
      tourplace: "Jhau Forest",
      rate: 4.0,
      categories: 'Forest',
      location: "Kuakata ",
      cost: 2300,
      image: [
        "https://c4.wallpaperflare.com/wallpaper/952/786/491/nature-landscape-forest-river-wallpaper-preview.jpg"
      ]),
  TourPlaceDetailsModel(
      tourplace: "Tilagor Eco Park",
      rate: 4.0,
      location: "Sylhet ",
      categories: 'Forest',
      cost: 2000,
      image: [
        "https://c4.wallpaperflare.com/wallpaper/428/376/851/forest-4k-desktop-background-hd-wallpaper-preview.jpg"
      ]),
  TourPlaceDetailsModel(
      tourplace: "St Regis Bora",
      rate: 4.8,
      location: "Italy",
      cost: 4000,
      image: [
        "https://c4.wallpaperflare.com/wallpaper/561/987/812/vacation-sandy-beach-water-crystal-clear-wallpaper-preview.jpg"
      ],
      categories: 'Island'),
  TourPlaceDetailsModel(
      tourplace: "Saint Martin",
      rate: 4.5,
      location: "Cox Bazar ",
      cost: 2200,
      categories: 'Island',
      image: [
        "https://c4.wallpaperflare.com/wallpaper/371/373/249/nature-beach-sea-water-wallpaper-preview.jpg"
      ]),
  TourPlaceDetailsModel(
      tourplace: "Maldives Island",
      rate: 4.1,
      categories: 'Island',
      location: "Maldives",
      cost: 23000,
      image: [
        "https://c4.wallpaperflare.com/wallpaper/977/548/906/beach-water-pier-tropical-wallpaper-preview.jpg"
      ]),
  TourPlaceDetailsModel(
      tourplace: "Eriyadhu Island",
      rate: 4.0,
      categories: 'Island',
      location: "Maldives ",
      cost: 23000,
      image: [
        "https://c4.wallpaperflare.com/wallpaper/61/3/660/artwork-fantasy-art-swan-digital-art-wallpaper-preview.jpg"
      ]),
  TourPlaceDetailsModel(
      tourplace: "Bangkok Island ",
      rate: 4.0,
      location: "Bangkok  ",
      categories: 'Island',
      cost: 20000,
      image: [
        "https://c4.wallpaperflare.com/wallpaper/428/376/851/forest-4k-desktop-background-hd-wallpaper-preview.jpg"
      ]),
  TourPlaceDetailsModel(
      tourplace: "Keokradong",
      rate: 4.8,
      location: "Bandarban",
      cost: 4000,
      image: [
        "https://www.travelmate.com.bd/wp-content/uploads/2019/08/Keokradong.jpg"
      ],
      categories: 'Mountain'),
  TourPlaceDetailsModel(
      tourplace: "Thingdawlte",
      rate: 4.5,
      location: "Bandarban",
      cost: 2200,
      categories: 'Mountain',
      image: [
        "https://www.travelmate.com.bd/wp-content/uploads/2019/08/Thingdawlte-Tlang.jpg"
      ]),
  TourPlaceDetailsModel(
      tourplace: "Taung Prai",
      rate: 4.3,
      categories: 'Mountain',
      location: "Rangamati",
      cost: 2900,
      image: [
        "https://www.travelmate.com.bd/wp-content/uploads/2019/08/Taung-Prai.jpg"
      ]),
  TourPlaceDetailsModel(
      tourplace: "Kapital Peak",
      rate: 4.6,
      categories: 'Mountain',
      location: "Bandarban ",
      cost: 3500,
      image: [
        "https://www.travelmate.com.bd/wp-content/uploads/2019/08/Sippi-Arsuang.jpg"
      ]),
  TourPlaceDetailsModel(
      tourplace: "Sippi Arsuang",
      rate: 4.0,
      location: "Bandarban   ",
      categories: 'Mountain',
      cost: 3000,
      image: [
        "https://www.travelmate.com.bd/wp-content/uploads/2019/08/Maithaijama-Haphong.jpg"
      ]),
  TourPlaceDetailsModel(
      tourplace: "Boga Lake",
      rate: 4.8,
      location: "Bandarban",
      cost: 4000,
      image: [
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/05/3d/56/54/boga-lake.jpg?w=700&h=-1&s=1"
      ],
      categories: 'Lake'),
  TourPlaceDetailsModel(
      tourplace: "Kaptai Lake",
      rate: 4.5,
      location: "Rangamati",
      cost: 2800,
      categories: 'Lake',
      image: [
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/17/11/58/9f/panoramic-beauty-of-kaptai.jpg?w=1200&h=-1&s=1"
      ]),
  TourPlaceDetailsModel(
      tourplace: "Madhabpur ",
      rate: 4.3,
      categories: 'Lake',
      location: "Sreemangal",
      cost: 2900,
      image: [
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0b/6c/82/2f/madhabpur-lake-2.jpg?w=1200&h=-1&s=1"
      ]),
  TourPlaceDetailsModel(
      tourplace: "Vatiary Lake",
      rate: 4.6,
      categories: 'Lake',
      location: " Chittagong ",
      cost: 3500,
      image: [
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0d/47/eb/1b/vatiyari-lake.jpg?w=1200&h=-1&s=1"
      ]),
  TourPlaceDetailsModel(
      tourplace: "Jadukata Lake",
      rate: 4.0,
      location: "Sylhet   ",
      categories: 'Lake',
      cost: 3000,
      image: [
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/09/7e/dc/10/jadukata-river.jpg?w=1200&h=-1&s=1"
      ]),
  TourPlaceDetailsModel(
      tourplace: "Kishoreganj Haor",
      rate: 4.8,
      location: "Kishoreganj",
      cost: 4000,
      image: [
        "https://www.theindependentbd.com/assets/news_images/Beauty-of-Kishoreganj.jpg"
      ],
      categories: 'River'),
  TourPlaceDetailsModel(
      tourplace: "Tanguar Haor",
      rate: 4.5,
      location: "Sunamganj",
      cost: 2800,
      categories: 'River',
      image: [
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/17/11/58/9f/panoramic-beauty-of-kaptai.jpg?w=1200&h=-1&s=1"
      ]),
  TourPlaceDetailsModel(
      tourplace: "Padma  ",
      rate: 4.3,
      categories: 'River',
      location: "Munshiganj",
      cost: 2900,
      image: [
        "https://st4.depositphotos.com/38116566/41908/i/600/depositphotos_419083514-stock-photo-beautiful-evening-padma-bridge-construction.jpg"
      ]),
  TourPlaceDetailsModel(
      tourplace: "Jomuna",
      rate: 4.6,
      categories: 'River',
      location: " SiranjGanj ",
      cost: 3500,
      image: [
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUdcQrTJPSiCtds-n75p3uYOaShBrfdQjw7hpKM-k8djaRKQF8sP_zaimqpOYgrqhPiqY&usqp=CAU"
      ]),
  TourPlaceDetailsModel(
      tourplace: "Sangu River",
      rate: 4.0,
      location: "Bandarban",
      categories: 'River',
      cost: 3000,
      image: [
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0a/06/e2/71/sangu-river.jpg?w=1200&h=-1&s=1"
      ]),
];
