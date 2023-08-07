

class ProfileDataModel {
  String? about;
  String? birth;
  String? email;
  String? image;
  String? name;
  String? password;
  String? profession;
  String? uid;
  ProfileDataModel({
    this.about,
    this.birth,
    this.email,
    this.image,
    this.name,
    this.password,
    this.profession,
    this.uid,
  });

  factory ProfileDataModel.fromMap(Map<String, dynamic> map) {
    return ProfileDataModel(
      about: map['about'],
      birth: map['birth'],
      email: map['email'],
      image: map['image'],
      name: map['name'],
      password: map['password'],
      profession: map['profession'],
      uid: map['uid'],
    );
  }
}
