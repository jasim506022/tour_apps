class ProfileDataModel {
  String? about;
  String? birth;
  String? email;
  String? image;
  String? name;
  String? profession;
  String? uid;
  String? phone;
  String? status;
  String? userDiveceToken;

  ProfileDataModel(
      {this.about,
      this.birth,
      this.email,
      this.image,
      this.name,
      this.profession,
      this.uid,
      this.phone,
      this.status,
      this.userDiveceToken});

  factory ProfileDataModel.fromMap(Map<String, dynamic> map) {
    return ProfileDataModel(
        about: map['about'],
        birth: map['birth'],
        email: map['email'],
        image: map['image'],
        name: map['name'],
        profession: map['profession'],
        uid: map['uid'],
        phone: map['phone'],
        status: map['status'],
        userDiveceToken: map['userDiveceToken']);
  }
}
