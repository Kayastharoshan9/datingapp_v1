import 'package:cloud_firestore/cloud_firestore.dart';

class Person
{
  //personal info
  String? uid;
  String? imageProfile;
  String? email;
  String? password;
  String? name;
  int? age;
  String? gender;
  String? phoneNo;
  String? citizenshipNumber;
  String? city;
  String? country;
  String? profileHeading;
  int? publishedDateTime;
  String? profession;
  String? income;
  String? nationality;
  String? education;
  String? languageSpoken;
  String? religion;

  Person({
    this.uid,
    this.imageProfile,
    this.email,
    this.password,
    this.name,
    this.age,
    this.gender,
    this.phoneNo,
    this.citizenshipNumber,
    this.city,
    this.country,
    this.profileHeading,
    this.publishedDateTime,
    this.profession,
    this.income,
    this.nationality,
    this.education,
    this.languageSpoken,
    this.religion,
});
  static Person fromDataSnapshot(DocumentSnapshot snapshot)
  {
    var dataSnapshot = snapshot.data() as Map<String, dynamic>;
    return Person(
      uid: dataSnapshot["uid"],
      name: dataSnapshot["name"],
      imageProfile: dataSnapshot["imageProfile"],
      email: dataSnapshot["email"],
      password: dataSnapshot["password"],
      age: dataSnapshot["age"],
      gender: dataSnapshot["gender"],
      phoneNo: dataSnapshot["phoneNo"],
      citizenshipNumber: dataSnapshot["citizenshipNumber"],
      city: dataSnapshot["city"],
      country: dataSnapshot["country"],
      profileHeading: dataSnapshot["profileHeading"],
      publishedDateTime: dataSnapshot["publishedDateTime"],
      profession: dataSnapshot["profession"],
      income: dataSnapshot["income"],
      nationality: dataSnapshot["nationality"],
      education: dataSnapshot["education"],
      languageSpoken: dataSnapshot["languageSpoken"],
      religion: dataSnapshot["religion"],

    );
  }
  Map<String, dynamic> toJson()=>
  {
    "uid": uid,
    "imageProfile": imageProfile,
    "email": email,
    "password": password,
    "name": name,
    "age": age,
    "gender": gender,
    "phoneNo": phoneNo,
    "citizenshipNumber": citizenshipNumber,
    "city": city,
    "country": country,
    "profileHeading": profileHeading,
    "publishedDateTime": publishedDateTime,
    "profession": profession,
    "nationality": nationality,
    "education": education,
    "languageSpoken": languageSpoken,
    "religion": religion,
  };
}