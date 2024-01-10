import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/accountSettingScreen/account_settings_screen.dart';
import 'package:dating_app/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:get/get.dart';

class UserDetailScreen extends StatefulWidget {
  String? userID;
  UserDetailScreen({super.key, this.userID});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  String name = '';
  String age = '';
  String phoneNo = '';
  String city = '';
  String country = '';
  String profession ='';
  String gender = '';
  String religion = '';


  // Slider images

  String urlImage1 = "https://firebasestorage.googleapis.com/v0/b/dating-app-c3f54.appspot.com/o/Place%20Holder%2Fprofile_avatar.jpg?alt=media&token=cfd50d57-2c50-4fd0-b684-bab73e2d61ef";
  String urlImage2 = "https://firebasestorage.googleapis.com/v0/b/dating-app-c3f54.appspot.com/o/Place%20Holder%2Fprofile_avatar.jpg?alt=media&token=cfd50d57-2c50-4fd0-b684-bab73e2d61ef";
  String urlImage3 = "https://firebasestorage.googleapis.com/v0/b/dating-app-c3f54.appspot.com/o/Place%20Holder%2Fprofile_avatar.jpg?alt=media&token=cfd50d57-2c50-4fd0-b684-bab73e2d61ef";
  String urlImage4 = "https://firebasestorage.googleapis.com/v0/b/dating-app-c3f54.appspot.com/o/Place%20Holder%2Fprofile_avatar.jpg?alt=media&token=cfd50d57-2c50-4fd0-b684-bab73e2d61ef";
  String urlImage5 = "https://firebasestorage.googleapis.com/v0/b/dating-app-c3f54.appspot.com/o/Place%20Holder%2Fprofile_avatar.jpg?alt=media&token=cfd50d57-2c50-4fd0-b684-bab73e2d61ef";

  retrieveUserInfo() async {
    await FirebaseFirestore.instance.collection("users").doc(widget.userID).get().then((snapshot) {
      if (snapshot.exists) {
        if (snapshot.data()!["urlImage"] != null) {
          setState(() {
            urlImage1 = snapshot.data()!["urlImage1"] ?? "";
            urlImage2 = snapshot.data()!["urlImage2"] ?? "";
            urlImage3 = snapshot.data()!["urlImage3"] ?? "";
            urlImage4 = snapshot.data()!["urlImage4"] ?? "";
            urlImage5 = snapshot.data()!["urlImage5"] ?? "";
          });
        }

        setState(() {
          name = snapshot.data()!["name"];
          age = snapshot.data()!["age"].toString();
          phoneNo = snapshot.data()!["phoneNo"];
          city = snapshot.data()!["city"];
          country = snapshot.data()!["country"];
          profession = snapshot.data()!["profession"];
          gender = snapshot.data()!["gender"];
          religion = snapshot.data()!["religion"];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    retrieveUserInfo();
  }

  void showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
              child: Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "User Profile",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: widget.userID == currentUserID ? false : true,
          actions: [
            IconButton(
              onPressed: () {
                Get.to(AccountSettingsScreen());
              },
              icon: const Icon(
                Icons.settings,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () {
                showLogoutConfirmationDialog();
              },
              icon: const Icon(
                Icons.logout,
                size: 30,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(30),
    child: Column(
    children: [
    // Image Slider
    SizedBox(
    height: MediaQuery.of(context).size.height * 0.4,
    width: MediaQuery.of(context).size.width,
    child: Padding(
    padding: const EdgeInsets.all(2),
    child: Carousel(
    indicatorBarColor: Colors.black.withOpacity(0.3),
    autoScrollDuration: const Duration(seconds: 2),
    animationPageDuration: const Duration(milliseconds: 500),
    activateIndicatorColor: Colors.black,
    animationPageCurve: Curves.easeIn,
    indicatorBarHeight: 30,
    indicatorHeight: 10,
    indicatorWidth: 10,
    unActivatedIndicatorColor: Colors.grey,
    stopAtEnd: false,
    autoScroll: true,
    items: [
    if(urlImage1.isNotEmpty) Image.network(urlImage1, fit: BoxFit.cover),
    if(urlImage2.isNotEmpty) Image.network(urlImage2, fit: BoxFit.cover),
    if(urlImage3.isNotEmpty) Image.network(urlImage3, fit: BoxFit.cover),
    if(urlImage4.isNotEmpty) Image.network(urlImage4, fit: BoxFit.cover),
    if(urlImage5.isNotEmpty) Image.network(urlImage5, fit: BoxFit.cover),
    ],
    ),
    ),
    ),
    const SizedBox(height: 10.0,),

    // Personal Info
    const SizedBox(height: 30,),
    const Align(
    alignment: Alignment.topLeft,
    child: Text(
    "Personal Info:",
    style: TextStyle(
    color: Colors.white,
    fontSize: 22,
    fontWeight: FontWeight.bold,
    ),
    ),
    ),
    const Divider(
    color: Colors.black,
    thickness: 2,
    ),

    // Personal Info Table Data
    Container(
    color: Colors.black,
    padding: const EdgeInsets.all(20.0),
    child: Table(
    children: [
    TableRow(
    children: [
    const Text(
    "Name:",
    style: TextStyle(
    color: Colors.white,
    fontSize: 18,
    ),
    ),
    Text(
    name,
    style: TextStyle(
    color: Colors.white,
    fontSize: 18,
    ),
    ),
    ],
    ),
    TableRow(
    children: [
    const Text(
    "Age:",
    style: TextStyle(
    color: Colors.white,
    fontSize: 18,
    ),
    ),
    Text(
    age,
    style: TextStyle(
    color: Colors.white,
    fontSize: 18,
    ),
    ),
    ],
    ),
    TableRow(
    children: [
    const Text(
    "City:",
    style: TextStyle(
    color: Colors.white,
    fontSize: 18,
    ),
    ),
    Text(
    city,
    style:
    TextStyle(
      color: Colors.white,
      fontSize: 18,
    ),
    ),
    ],
    ),
      TableRow(
        children: [
          const Text(
            "Country:",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          Text(
            country,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
      TableRow(
        children: [
          const Text(
            "Profession:",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          Text(
            profession,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),

      TableRow(
        children: [
          const Text(
            "Gender:",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          Text(
            gender,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
      TableRow(
        children: [
          const Text(
            "Religion:",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          Text(
            religion,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
    ],
    ),
    ),

      ],
    ),
    ),
    ),
    );
  }
}

