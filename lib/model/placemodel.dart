class TourPlaceDetailsModel {
  final String tourplace;
  final double rate;
  final String location;
  final double cost;
  final String categories;
  final String description;
  final List<String> image;

  TourPlaceDetailsModel({
    required this.tourplace,
    required this.rate,
    required this.location,
    required this.cost,
    required this.image,
    required this.categories,
    required this.description,
  });
}

//sea
List<TourPlaceDetailsModel> tourplacedetaillist = [
  //okay
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
      categories: 'Sea',
      description:
          'What is Redfish Lake known for? Redfish Lake is the final stop on the longest  Pacific salmon run in North America, which  requires long-distance swimmers, such as  Sockeye and Chinook Salmon, to travel over 900 miles upstream to return to their spawning grounds.Redfish Lake is an alpine lake in Custer County, Idaho, just south of Stanley. It is the largest lake within the Sawtooth National Recreation Area.'),
  //okya
  TourPlaceDetailsModel(
      tourplace: "Kuakata Beach",
      rate: 4.3,
      location: "Patuakhali ",
      cost: 2500,
      description:
          'What is Redfish Lake known for? Redfish Lake is the final stop on the longest  Pacific salmon run in North America, which  requires long-distance swimmers, such as  Sockeye and Chinook Salmon, to travel over 900 miles upstream to return to their spawning grounds.Redfish Lake is an alpine lake in Custer County, Idaho, just south of Stanley. It is the largest lake within the Sawtooth National Recreation Area.',
      categories: 'Sea',
      image: [
        "https://c4.wallpaperflare.com/wallpaper/615/107/638/beach-sandy-beach-lagoon-tropical-landscape-wallpaper-preview.jpg",
        "https://cdn.pixabay.com/photo/2014/08/09/05/40/kuakata-413928_640.jpg",
        "https://cdn.pixabay.com/photo/2022/07/31/19/41/kuakata-7356673_640.jpg",
        "https://cdn.pixabay.com/photo/2015/03/11/05/03/sunset-668196_640.jpg"
      ]),

  //okay
  TourPlaceDetailsModel(
      tourplace: "Patenga sea beach",
      rate: 4.1,
      categories: 'Sea',
      location: "Chittagong",
      cost: 2200,
      description:
          'What is Redfish Lake known for? Redfish Lake is the final stop on the longest  Pacific salmon run in North America, which  requires long-distance swimmers, such as  Sockeye and Chinook Salmon, to travel over 900 miles upstream to return to their spawning grounds.Redfish Lake is an alpine lake in Custer County, Idaho, just south of Stanley. It is the largest lake within the Sawtooth National Recreation Area.',
      image: [
        "https://c4.wallpaperflare.com/wallpaper/440/12/60/nature-hd-for-pc-download-1920x1080-wallpaper-preview.jpg",
        "https://cdn.pixabay.com/photo/2017/01/16/19/54/sunset-1985086_640.jpg",
        "https://cdn.pixabay.com/photo/2015/03/02/23/40/father-656734_640.jpg",
        "https://cdn.pixabay.com/photo/2016/11/14/04/00/beach-1822544_640.jpg",
      ]),
  TourPlaceDetailsModel(
      tourplace: "Indian Beach",
      rate: 4.0,
      description:
          'What is Redfish Lake known for? Redfish Lake is the final stop on the longest  Pacific salmon run in North America, which  requires long-distance swimmers, such as  Sockeye and Chinook Salmon, to travel over 900 miles upstream to return to their spawning grounds.Redfish Lake is an alpine lake in Custer County, Idaho, just south of Stanley. It is the largest lake within the Sawtooth National Recreation Area.',
      categories: 'Sea',
      location: "Inia ",
      cost: 2000,
      image: [
        "https://c4.wallpaperflare.com/wallpaper/796/80/865/sunrise-over-the-horizon-sea-ships-sandy-beach-waves-beautiful-landscape-wallpapers-for-desktop-mobile-phones-and-laptops-3840%C3%972400-wallpaper-preview.jpg"
      ]),
  TourPlaceDetailsModel(
      tourplace: "Tarua Beach",
      description:
          'What is Redfish Lake known for? Redfish Lake is the final stop on the longest  Pacific salmon run in North America, which  requires long-distance swimmers, such as  Sockeye and Chinook Salmon, to travel over 900 miles upstream to return to their spawning grounds.Redfish Lake is an alpine lake in Custer County, Idaho, just south of Stanley. It is the largest lake within the Sawtooth National Recreation Area.',
      rate: 4.0,
      location: "Bhola ",
      categories: 'Sea',
      cost: 2000,
      image: [
        "https://c4.wallpaperflare.com/wallpaper/272/558/421/two-orange-and-red-flowers-with-drew-drops-wallpaper-preview.jpg",
        "https://cdn.pixabay.com/photo/2018/06/03/14/17/sea-3450584_640.jpg",
        "https://cdn.pixabay.com/photo/2019/08/02/02/02/beach-4378548_640.jpg",
        "https://cdn.pixabay.com/photo/2016/11/18/18/39/beach-1836335_640.jpg"
      ]),

  //Forest
  //okay
  TourPlaceDetailsModel(
      tourplace: "Ratargul Swamp",
      rate: 4.8,
      location: "Sylhet",
      description:
          'What is Redfish Lake known for? Redfish Lake is the final stop on the longest  Pacific salmon run in North America, which  requires long-distance swimmers, such as  Sockeye and Chinook Salmon, to travel over 900 miles upstream to return to their spawning grounds.Redfish Lake is an alpine lake in Custer County, Idaho, just south of Stanley. It is the largest lake within the Sawtooth National Recreation Area.',
      cost: 2500,
      image: [
        "https://c0.wallpaperflare.com/preview/135/981/228/bangladesh-landscape-nature-forest.jpg"
      ],
      categories: 'Forest'),
  //okay
  TourPlaceDetailsModel(
      tourplace: "Lebur Char",
      rate: 4.5,
      location: "Chittagong ",
      cost: 2200,
      description:
          'What is Redfish Lake known for? Redfish Lake is the final stop on the longest  Pacific salmon run in North America, which  requires long-distance swimmers, such as  Sockeye and Chinook Salmon, to travel over 900 miles upstream to return to their spawning grounds.Redfish Lake is an alpine lake in Custer County, Idaho, just south of Stanley. It is the largest lake within the Sawtooth National Recreation Area.',
      categories: 'Forest',
      image: [
        "https://c0.wallpaperflare.com/preview/439/18/445/brown-and-white-deer-during-daytime.jpg",
        "https://cdn.pixabay.com/photo/2018/11/17/22/15/trees-3822149_640.jpg",
        "https://cdn.pixabay.com/photo/2017/04/09/09/56/avenue-2215317_640.jpg",
        "https://cdn.pixabay.com/photo/2018/04/06/00/25/trees-3294681_640.jpg"
      ]),
  TourPlaceDetailsModel(
      tourplace: "Gangamati",
      rate: 4.1,
      categories: 'Forest',
      location: "Kuakata",
      cost: 2300,
      description:
          'What is Redfish Lake known for? Redfish Lake is the final stop on the longest  Pacific salmon run in North America, which  requires long-distance swimmers, such as  Sockeye and Chinook Salmon, to travel over 900 miles upstream to return to their spawning grounds.Redfish Lake is an alpine lake in Custer County, Idaho, just south of Stanley. It is the largest lake within the Sawtooth National Recreation Area.',
      image: [
        "https://c4.wallpaperflare.com/wallpaper/799/608/26/bangladesh-forest-sunny-day-madhabpur-syleth-wallpaper-preview.jpg",
        "https://cdn.pixabay.com/photo/2016/08/11/23/55/trees-1587301_640.jpg",
        "https://cdn.pixabay.com/photo/2016/11/14/04/45/elephant-1822636_640.jpg",
        "https://cdn.pixabay.com/photo/2018/08/12/15/29/hintersee-3601004_640.jpg"
      ]),
  TourPlaceDetailsModel(
      tourplace: "Jhau Forest",
      description:
          'What is Redfish Lake known for? Redfish Lake is the final stop on the longest  Pacific salmon run in North America, which  requires long-distance swimmers, such as  Sockeye and Chinook Salmon, to travel over 900 miles upstream to return to their spawning grounds.Redfish Lake is an alpine lake in Custer County, Idaho, just south of Stanley. It is the largest lake within the Sawtooth National Recreation Area.',
      rate: 4.0,
      categories: 'Forest',
      location: "Kuakata ",
      cost: 2300,
      image: [
        "https://c4.wallpaperflare.com/wallpaper/952/786/491/nature-landscape-forest-river-wallpaper-preview.jpg",
        "https://cdn.pixabay.com/photo/2018/01/30/22/50/forest-3119826_640.jpg",
        "https://cdn.pixabay.com/photo/2012/09/15/02/22/forest-56930_640.jpg",
        "https://cdn.pixabay.com/photo/2018/01/12/14/24/night-3078326_640.jpg"
      ]),

  //okay
  TourPlaceDetailsModel(
      tourplace: "Tilagor Eco Park",
      rate: 4.0,
      description:
          'What is Redfish Lake known for? Redfish Lake is the final stop on the longest  Pacific salmon run in North America, which  requires long-distance swimmers, such as  Sockeye and Chinook Salmon, to travel over 900 miles upstream to return to their spawning grounds.Redfish Lake is an alpine lake in Custer County, Idaho, just south of Stanley. It is the largest lake within the Sawtooth National Recreation Area.',
      location: "Sylhet ",
      categories: 'Forest',
      cost: 2000,
      image: [
        "https://c4.wallpaperflare.com/wallpaper/428/376/851/forest-4k-desktop-background-hd-wallpaper-preview.jpg",
        "https://cdn.pixabay.com/photo/2016/11/12/11/51/animals-1818690_640.jpg",
        "https://cdn.pixabay.com/photo/2016/11/08/04/49/jungle-1807476_640.jpg",
        "https://cdn.pixabay.com/photo/2017/11/12/13/37/forest-2942477_640.jpg"
      ]),
  //Island
  //okay
  TourPlaceDetailsModel(
      tourplace: "St Regis Bora",
      rate: 4.8,
      location: "Italy",
      description:
          'What is Redfish Lake known for? Redfish Lake is the final stop on the longest  Pacific salmon run in North America, which  requires long-distance swimmers, such as  Sockeye and Chinook Salmon, to travel over 900 miles upstream to return to their spawning grounds.Redfish Lake is an alpine lake in Custer County, Idaho, just south of Stanley. It is the largest lake within the Sawtooth National Recreation Area.',
      cost: 4000,
      image: [
        "https://c4.wallpaperflare.com/wallpaper/561/987/812/vacation-sandy-beach-water-crystal-clear-wallpaper-preview.jpg",
        "https://cdn.pixabay.com/photo/2018/07/16/16/08/island-3542290_640.jpg",
        "https://cdn.pixabay.com/photo/2017/07/07/18/10/island-2482200_640.jpg",
        "https://cdn.pixabay.com/photo/2016/10/22/18/52/beach-1761410_640.jpg"
      ],
      categories: 'Island'),
  //okay
  TourPlaceDetailsModel(
      tourplace: "Saint Martin",
      rate: 4.5,
      location: "Cox Bazar ",
      cost: 2200,
      description:
          'What is Redfish Lake known for? Redfish Lake is the final stop on the longest  Pacific salmon run in North America, which  requires long-distance swimmers, such as  Sockeye and Chinook Salmon, to travel over 900 miles upstream to return to their spawning grounds.Redfish Lake is an alpine lake in Custer County, Idaho, just south of Stanley. It is the largest lake within the Sawtooth National Recreation Area.',
      categories: 'Island',
      image: [
        "https://c4.wallpaperflare.com/wallpaper/371/373/249/nature-beach-sea-water-wallpaper-preview.jpg",
        "https://cdn.pixabay.com/photo/2017/12/16/22/22/bora-bora-3023437_640.jpg",
        "https://cdn.pixabay.com/photo/2020/04/21/18/49/tropical-5074304_640.jpg",
        "https://cdn.pixabay.com/photo/2018/04/27/08/56/water-3354063_640.jpg"
      ]),
  TourPlaceDetailsModel(
      tourplace: "Maldives Island",
      rate: 4.1,
      categories: 'Island',
      location: "Maldives",
      description:
          'What is Redfish Lake known for? Redfish Lake is the final stop on the longest  Pacific salmon run in North America, which  requires long-distance swimmers, such as  Sockeye and Chinook Salmon, to travel over 900 miles upstream to return to their spawning grounds.Redfish Lake is an alpine lake in Custer County, Idaho, just south of Stanley. It is the largest lake within the Sawtooth National Recreation Area.',
      cost: 23000,
      image: [
        "https://c4.wallpaperflare.com/wallpaper/977/548/906/beach-water-pier-tropical-wallpaper-preview.jpg",
        "https://cdn.stocksnap.io/img-thumbs/280h/lighthouse-architecture_9WGW8D33AO.jpg",
        "https://cdn.stocksnap.io/img-thumbs/280h/bay-island_LS48IVYFOA.jpg",
        "https://cdn.stocksnap.io/img-thumbs/280h/FUPABBDRCI.jpg"
      ]),
  TourPlaceDetailsModel(
      tourplace: "Eriyadhu Island",
      rate: 4.0,
      categories: 'Island',
      location: "Maldives ",
      cost: 23000,
      description:
          'What is Redfish Lake known for? Redfish Lake is the final stop on the longest  Pacific salmon run in North America, which  requires long-distance swimmers, such as  Sockeye and Chinook Salmon, to travel over 900 miles upstream to return to their spawning grounds.Redfish Lake is an alpine lake in Custer County, Idaho, just south of Stanley. It is the largest lake within the Sawtooth National Recreation Area.',
      image: [
        "https://c4.wallpaperflare.com/wallpaper/61/3/660/artwork-fantasy-art-swan-digital-art-wallpaper-preview.jpg",
        "https://cdn.pixabay.com/photo/2016/11/21/12/10/island-1844962_640.jpg",
        "https://cdn.pixabay.com/photo/2018/05/10/23/04/giglio-3389078_640.jpg",
        "https://cdn.pixabay.com/photo/2014/09/26/03/55/fountain-461552_640.jpg"
      ]),

  //okay
  TourPlaceDetailsModel(
      tourplace: "Bangkok Island ",
      rate: 4.0,
      location: "Bangkok  ",
      categories: 'Island',
      cost: 20000,
      description:
          'What is Redfish Lake known for? Redfish Lake is the final stop on the longest  Pacific salmon run in North America, which  requires long-distance swimmers, such as  Sockeye and Chinook Salmon, to travel over 900 miles upstream to return to their spawning grounds.Redfish Lake is an alpine lake in Custer County, Idaho, just south of Stanley. It is the largest lake within the Sawtooth National Recreation Area.',
      image: [
        "https://c4.wallpaperflare.com/wallpaper/428/376/851/forest-4k-desktop-background-hd-wallpaper-preview.jpg"
            "https://cdn.pixabay.com/photo/2020/04/22/09/59/tree-5077020_640.jpg",
        "https://cdn.pixabay.com/photo/2021/08/02/16/22/beach-6517214_640.jpg",
        "https://cdn.stocksnap.io/img-thumbs/280h/V09V9BB1KQ.jpg"
      ]),
  //Mountain
  //okay
  TourPlaceDetailsModel(
      tourplace: "Keokradong",
      rate: 4.8,
      location: "Bandarban",
      description:
          'What is Redfish Lake known for? Redfish Lake is the final stop on the longest  Pacific salmon run in North America, which  requires long-distance swimmers, such as  Sockeye and Chinook Salmon, to travel over 900 miles upstream to return to their spawning grounds.Redfish Lake is an alpine lake in Custer County, Idaho, just south of Stanley. It is the largest lake within the Sawtooth National Recreation Area.',
      cost: 4000,
      image: [
        "https://www.travelmate.com.bd/wp-content/uploads/2019/08/Keokradong.jpg",
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0e/86/34/5b/himchori-hill.jpg?w=1100&h=-1&s=1",
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0e/86/34/20/marine-drive-road.jpg?w=1100&h=-1&s=1",
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0e/86/2e/4a/sunset.jpg?w=700&h=-1&s=1"
      ],
      categories: 'Mountain'),
  //okay
  TourPlaceDetailsModel(
      tourplace: "Thingdawlte",
      rate: 4.5,
      location: "Bandarban",
      cost: 2200,
      categories: 'Mountain',
      description:
          'What is Redfish Lake known for? Redfish Lake is the final stop on the longest  Pacific salmon run in North America, which  requires long-distance swimmers, such as  Sockeye and Chinook Salmon, to travel over 900 miles upstream to return to their spawning grounds.Redfish Lake is an alpine lake in Custer County, Idaho, just south of Stanley. It is the largest lake within the Sawtooth National Recreation Area.',
      image: [
        "https://www.travelmate.com.bd/wp-content/uploads/2019/08/Thingdawlte-Tlang.jpg",
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/12/9a/3d/f1/the-bay-of-bengle-from.jpg?w=1200&h=-1&s=1",
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0e/86/34/60/himchori-hills.jpg?w=1100&h=-1&s=1",
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0e/86/34/5f/himchori-areas.jpg?w=500&h=-1&s=1"
      ]),
  TourPlaceDetailsModel(
      tourplace: "Taung Prai",
      rate: 4.3,
      categories: 'Mountain',
      location: "Rangamati",
      description:
          'What is Redfish Lake known for? Redfish Lake is the final stop on the longest  Pacific salmon run in North America, which  requires long-distance swimmers, such as  Sockeye and Chinook Salmon, to travel over 900 miles upstream to return to their spawning grounds.Redfish Lake is an alpine lake in Custer County, Idaho, just south of Stanley. It is the largest lake within the Sawtooth National Recreation Area.',
      cost: 2900,
      image: [
        "https://www.travelmate.com.bd/wp-content/uploads/2019/08/Taung-Prai.jpg",
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/09/bd/d1/fc/sajek.jpg?w=800&h=-1&s=1",
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/09/bd/d1/e7/sajek.jpg?w=1100&h=-1&s=1",
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/09/bd/d1/9e/sajek.jpg?w=700&h=-1&s=1"
      ]),
  TourPlaceDetailsModel(
      tourplace: "Kapital Peak",
      rate: 4.6,
      description:
          'What is Redfish Lake known for? Redfish Lake is the final stop on the longest  Pacific salmon run in North America, which  requires long-distance swimmers, such as  Sockeye and Chinook Salmon, to travel over 900 miles upstream to return to their spawning grounds.Redfish Lake is an alpine lake in Custer County, Idaho, just south of Stanley. It is the largest lake within the Sawtooth National Recreation Area.',
      categories: 'Mountain',
      location: "Bandarban ",
      cost: 3500,
      image: [
        "https://www.travelmate.com.bd/wp-content/uploads/2019/08/Sippi-Arsuang.jpg",
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/09/bd/d1/99/sajek.jpg?w=1000&h=-1&s=1",
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/09/bd/d1/92/sajek.jpg?w=1000&h=-1&s=1",
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/09/bd/d1/83/sajek.jpg?w=1000&h=-1&s=1"
      ]),
  //okay
  TourPlaceDetailsModel(
      tourplace: "Sippi Arsuang",
      description:
          'What is Redfish Lake known for? Redfish Lake is the final stop on the longest  Pacific salmon run in North America, which  requires long-distance swimmers, such as  Sockeye and Chinook Salmon, to travel over 900 miles upstream to return to their spawning grounds.Redfish Lake is an alpine lake in Custer County, Idaho, just south of Stanley. It is the largest lake within the Sawtooth National Recreation Area.',
      rate: 4.0,
      location: "Bandarban   ",
      categories: 'Mountain',
      cost: 3000,
      image: [
        "https://www.travelmate.com.bd/wp-content/uploads/2019/08/Maithaijama-Haphong.jpg",
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/09/7a/77/aa/sajek.jpg?w=1200&h=-1&s=1",
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/09/5e/4c/72/sajek.jpg?w=1200&h=-1&s=1",
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/09/54/6f/71/sajek.jpg?w=1000&h=-1&s=1"
      ]),

  //Lake
  //okay
  TourPlaceDetailsModel(
      tourplace: "Boga Lake",
      rate: 4.8,
      description:
          'What is Redfish Lake known for? Redfish Lake is the final stop on the longest  Pacific salmon run in North America, which  requires long-distance swimmers, such as  Sockeye and Chinook Salmon, to travel over 900 miles upstream to return to their spawning grounds.Redfish Lake is an alpine lake in Custer County, Idaho, just south of Stanley. It is the largest lake within the Sawtooth National Recreation Area.',
      location: "Bandarban",
      cost: 4000,
      image: [
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/05/3d/56/54/boga-lake.jpg?w=700&h=-1&s=1"
      ],
      categories: 'Lake'),
  // okay
  TourPlaceDetailsModel(
      tourplace: "Kaptai Lake",
      description:
          'What is Redfish Lake known for? Redfish Lake is the final stop on the longest  Pacific salmon run in North America, which  requires long-distance swimmers, such as  Sockeye and Chinook Salmon, to travel over 900 miles upstream to return to their spawning grounds.Redfish Lake is an alpine lake in Custer County, Idaho, just south of Stanley. It is the largest lake within the Sawtooth National Recreation Area.',
      rate: 4.5,
      location: "Rangamati",
      cost: 2800,
      categories: 'Lake',
      image: [
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/17/11/58/9f/panoramic-beauty-of-kaptai.jpg?w=1200&h=-1&s=1",
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/05/12/ff/2f/boga-lake.jpg?w=900&h=-1&s=1",
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/04/a5/ae/fd/boga-lake.jpg?w=800&h=-1&s=1",
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-s/01/f6/de/ea/bogalake-view.jpg?w=600&h=-1&s=1"
      ]),

  TourPlaceDetailsModel(
      tourplace: "Madhabpur ",
      description:
          'What is Redfish Lake known for? Redfish Lake is the final stop on the longest  Pacific salmon run in North America, which  requires long-distance swimmers, such as  Sockeye and Chinook Salmon, to travel over 900 miles upstream to return to their spawning grounds.Redfish Lake is an alpine lake in Custer County, Idaho, just south of Stanley. It is the largest lake within the Sawtooth National Recreation Area.',
      rate: 4.3,
      categories: 'Lake',
      location: "Sreemangal",
      cost: 2900,
      image: [
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0b/6c/82/2f/madhabpur-lake-2.jpg?w=1200&h=-1&s=1",
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/15/3c/a4/1c/photo3jpg.jpg?w=1200&h=-1&s=1",
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/15/3c/a4/19/photo0jpg.jpg?w=1200&h=-1&s=1",
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0e/c8/5b/22/view-of-lake.jpg?w=1200&h=-1&s=1"
      ]),
  TourPlaceDetailsModel(
      tourplace: "Vatiary Lake",
      rate: 4.6,
      categories: 'Lake',
      description:
          'What is Redfish Lake known for? Redfish Lake is the final stop on the longest  Pacific salmon run in North America, which  requires long-distance swimmers, such as  Sockeye and Chinook Salmon, to travel over 900 miles upstream to return to their spawning grounds.Redfish Lake is an alpine lake in Custer County, Idaho, just south of Stanley. It is the largest lake within the Sawtooth National Recreation Area.',
      location: " Chittagong ",
      cost: 3500,
      image: [
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0d/47/eb/1b/vatiyari-lake.jpg?w=1200&h=-1&s=1",
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/06/41/84/ba/kaptai-lake.jpg?w=1200&h=-1&s=1",
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-s/02/ec/ee/95/kaptai-lake.jpg?w=600&h=-1&s=1",
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-s/02/ec/ee/91/kaptai-lake.jpg?w=600&h=-1&s=1"
      ]),
  //okay
  TourPlaceDetailsModel(
      tourplace: "Jadukata Lake",
      rate: 4.0,
      description:
          'What is Redfish Lake known for? Redfish Lake is the final stop on the longest  Pacific salmon run in North America, which  requires long-distance swimmers, such as  Sockeye and Chinook Salmon, to travel over 900 miles upstream to return to their spawning grounds.Redfish Lake is an alpine lake in Custer County, Idaho, just south of Stanley. It is the largest lake within the Sawtooth National Recreation Area.',
      location: "Sylhet   ",
      categories: 'Lake',
      cost: 3000,
      image: [
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/09/7e/dc/10/jadukata-river.jpg?w=1200&h=-1&s=1",
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-s/02/ec/ee/91/kaptai-lake.jpg?w=600&h=-1&s=1",
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-s/02/ec/ee/8b/kaptai-lake.jpg?w=600&h=-1&s=1",
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-s/02/78/0c/ff/kaptai-lake-rangamati.jpg?w=600&h=-1&s=1"
      ]),

  //River
  //okay
  TourPlaceDetailsModel(
      tourplace: "Kishoreganj Haor",
      rate: 4.8,
      location: "Kishoreganj",
      description:
          'What is Redfish Lake known for? Redfish Lake is the final stop on the longest  Pacific salmon run in North America, which  requires long-distance swimmers, such as  Sockeye and Chinook Salmon, to travel over 900 miles upstream to return to their spawning grounds.Redfish Lake is an alpine lake in Custer County, Idaho, just south of Stanley. It is the largest lake within the Sawtooth National Recreation Area.',
      cost: 4000,
      image: [
        "https://www.theindependentbd.com/assets/news_images/Beauty-of-Kishoreganj.jpg",
        "https://media-cdn.tripadvisor.com/media/photo-s/1b/a5/5f/e1/tanguar-hoar.jpg",
        "https://media-cdn.tripadvisor.com/media/photo-s/1b/a5/5f/e1/tanguar-hoar.jpg",
        "https://media-cdn.tripadvisor.com/media/photo-s/18/1c/88/1f/img-20190622-174211-largejpg.jpg"
      ],
      categories: 'River'),
  //okay
  TourPlaceDetailsModel(
      tourplace: "Tanguar Haor",
      rate: 4.5,
      location: "Sunamganj",
      description:
          'What is Redfish Lake known for? Redfish Lake is the final stop on the longest  Pacific salmon run in North America, which  requires long-distance swimmers, such as  Sockeye and Chinook Salmon, to travel over 900 miles upstream to return to their spawning grounds.Redfish Lake is an alpine lake in Custer County, Idaho, just south of Stanley. It is the largest lake within the Sawtooth National Recreation Area.',
      cost: 2800,
      categories: 'River',
      image: [
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/17/11/58/9f/panoramic-beauty-of-kaptai.jpg?w=1200&h=-1&s=1",
        "https://w0.peakpx.com/wallpaper/249/305/HD-wallpaper-tanguar-haor-ultra-asia-bangladesh-nature-ecosystem-wetland-tanguarhaor-thumbnail.jpg",
        "https://cdn.pixabay.com/photo/2022/12/16/11/05/tanguar-haor-7659427_1280.jpg",
        "https://as1.ftcdn.net/v2/jpg/03/03/34/12/1000_F_303341223_5Zno68kSQYE2cQdhBN25yC9QWY6Wowwk.jpg"
      ]),
  //okay
  TourPlaceDetailsModel(
      tourplace: "Padma  ",
      rate: 4.3,
      description:
          'What is Redfish Lake known for? Redfish Lake is the final stop on the longest  Pacific salmon run in North America, which  requires long-distance swimmers, such as  Sockeye and Chinook Salmon, to travel over 900 miles upstream to return to their spawning grounds.Redfish Lake is an alpine lake in Custer County, Idaho, just south of Stanley. It is the largest lake within the Sawtooth National Recreation Area.',
      categories: 'River',
      location: "Munshiganj",
      cost: 2900,
      image: [
        "https://st4.depositphotos.com/38116566/41908/i/600/depositphotos_419083514-stock-photo-beautiful-evening-padma-bridge-construction.jpg",
        "https://cdn.pixabay.com/photo/2023/05/19/05/33/boats-8003723_1280.jpg",
        "https://cdn.pixabay.com/photo/2018/09/12/22/43/bangladesh-3673378_640.jpg",
        "https://cdn.pixabay.com/photo/2023/05/10/12/32/pabna-7983880_640.jpg"
      ]),
  TourPlaceDetailsModel(
      tourplace: "Jomuna",
      rate: 4.6,
      description:
          'What is Redfish Lake known for? Redfish Lake is the final stop on the longest  Pacific salmon run in North America, which  requires long-distance swimmers, such as  Sockeye and Chinook Salmon, to travel over 900 miles upstream to return to their spawning grounds.Redfish Lake is an alpine lake in Custer County, Idaho, just south of Stanley. It is the largest lake within the Sawtooth National Recreation Area.',
      categories: 'River',
      location: " SiranjGanj ",
      cost: 3500,
      image: [
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUdcQrTJPSiCtds-n75p3uYOaShBrfdQjw7hpKM-k8djaRKQF8sP_zaimqpOYgrqhPiqY&usqp=CAU",
        "https://cdn.pixabay.com/photo/2018/07/15/15/56/bangladesh-3539914_640.jpg",
        "https://cdn.pixabay.com/photo/2018/09/14/10/31/nature-3676693_640.jpg",
        "image.png"
      ]),
  // Okay
  TourPlaceDetailsModel(
      tourplace: "Sangu River",
      rate: 4.0,
      location: "Bandarban",
      description:
          'What is Redfish Lake known for? Redfish Lake is the final stop on the longest  Pacific salmon run in North America, which  requires long-distance swimmers, such as  Sockeye and Chinook Salmon, to travel over 900 miles upstream to return to their spawning grounds.Redfish Lake is an alpine lake in Custer County, Idaho, just south of Stanley. It is the largest lake within the Sawtooth National Recreation Area.',
      categories: 'River',
      cost: 3000,
      image: [
        "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0a/06/e2/71/sangu-river.jpg?w=1200&h=-1&s=1",
        "https://cdn.pixabay.com/photo/2021/08/28/10/28/river-6580641_640.jpg",
        "https://cdn.pixabay.com/photo/2022/11/17/15/41/river-7598374_640.jpg",
        "https://cdn.pixabay.com/photo/2022/08/01/20/47/boat-7358992_640.jpg"
      ]),
];

final messages = [
  {"isMe": false, "text": "Hey What is up with you!!", "time": "10:00 am"},
  {"isMe": true, "text": "im fine,wbu?", "time": "11:00 am"},
  {"isMe": false, "text": "I am great man!", "time": "11:01 am"},
  {
    "isMe": false,
    "text": "Just messaged cuz I had some work.",
    "time": "11:01 am"
  },
  {
    "isMe": true,
    "text":
        "Obviously,  Just messaged cuz I had some work.Just messaged cuz I had some work.say",
    "time": "11:03 am"
  },
  {
    "isMe": false,
    "text": "haha I wanted you to check out my new channel ^^",
    "time": "11:04 am"
  },
  {
    "isMe": true,
    "text": " Sure, what is the channel name?",
    "time": "11:05 am"
  },
  {
    "isMe": false,
    "text": "Rivaan Ranawat",
    "time": "11:06 am",
  },
  {
    "isMe": true,
    "text": "Looks great to me!",
    "time": "11:15 am",
  },
  {"isMe": false, "text": "Thanks bro!", "time": "11:17 am"},
  {"isMe": false, "text": "Did you subscribe?", "time": "11:16 am"},
  {"isMe": true, "text": "Yes, surely bro!", "time": "11:17 am"},
  {
    "isMe": false,
    "text": "Cool, did you like the content?",
    "time": "11:18 am",
  },
  {
    "isMe": true,
    "text": "I loved it?",
    "time": "11:19 am",
  },
  {
    "isMe": false,
    "text": "OMG! Woah! Thanks!",
    "time": "11:20 am",
  },
];
 