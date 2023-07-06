class CategoryModel {
  final String name;
  final String imagename;

  CategoryModel({
    required this.name,
    required this.imagename,
  });
}

List<CategoryModel> categories = [
  CategoryModel(name: "Sea", imagename: "asset/categories/sea.png"),
  CategoryModel(name: "Forest", imagename: "asset/categories/forest.png"),
  CategoryModel(name: "Island", imagename: "asset/categories/island.png"),
  CategoryModel(name: "Mountain", imagename: "asset/categories/mountain.png"),
  CategoryModel(name: "Lake", imagename: "asset/categories/pond.png"),
  CategoryModel(name: "River", imagename: "asset/categories/river.png"),
];

List<String> categoryString = [
  "Sea",
  "Forest",
  "Island",
  "Mountain",
  "Lake",
  "River"
];

List<String> categoryAllString = [
  "All",
  "Sea",
  "Forest",
  "Island",
  "Mountain",
  "Lake",
  "River"
];
