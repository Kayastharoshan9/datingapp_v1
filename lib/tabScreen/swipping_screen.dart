import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/controllers/profile_controller.dart';
import 'package:dating_app/global.dart';
import 'package:dating_app/tabScreen/user_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SwippingScreen extends StatefulWidget {
  const SwippingScreen({super.key});

  @override
  State<SwippingScreen> createState() => _SwippingScreenState();
}

class _SwippingScreenState extends State<SwippingScreen>
{
  ProfileController profileController = Get.put(ProfileController());

  String senderName = "";

  startChattingInWhatsApp(String receiverPhoneNumber)async
  {
    var androidUrl = "whatsapp://send?phone=$receiverPhoneNumber&text=Hi, I found your profile on dating app.";
    var iosUrl = "https://wa.me/$receiverPhoneNumber?text=${Uri.parse('Hi, I found your profile on dating app.')}";


    try
    {
      if(Platform.isIOS)
        {
          await launchUrl(Uri.parse(iosUrl));
        }
      else
        {
          await launchUrl(Uri.parse(androidUrl));
        }
    }
    on Exception
    {
      showDialog(
        context: context,
        builder: (BuildContext context)
          {
            return AlertDialog(
              title: const Text("Whatsapp Not Found"),
              content: const Text("Whatsapp is not installed."),
              actions: [
                TextButton(
                    onPressed: ()
                    {
                      Get.back();
                    },
                  child: const Text("OK"),
                ),
              ],

            );
          }
      );
    }

  }
  readCurrentUserData() async
  {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserID)
        .get()
        .then((dataSnapshot)
    {
      setState(() {
        senderName = dataSnapshot.data()!["name"].toString();
      });
    }
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    readCurrentUserData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()
      {
      return PageView.builder(
        itemCount:profileController.allUsersProfileList.length,
        controller: PageController(initialPage: 0, viewportFraction: 1),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index)
        {
          final eachProfileInfo = profileController.allUsersProfileList[index];

          return DecoratedBox(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    eachProfileInfo.imageProfile.toString(),
                  ),
                  fit: BoxFit.cover,
                )
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [


                  // user data

                  GestureDetector(
                    onTap: ()
                    {
                      profileController.ViewSentAndViewReceived(
                        eachProfileInfo.uid.toString(),
                        senderName,
                      );
                        //send user to profile person

                      Get.to(UserDetailScreen(
                        userID: eachProfileInfo.uid.toString(),
                      ));

                    },
                    child: Column(
                      children: [

                        //name
                        Text(
                        eachProfileInfo.name.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          letterSpacing: 4,
                          fontWeight: FontWeight.bold,
                        ),
                        ),

                        //age and city
                        Text(
                          eachProfileInfo.age.toString() + "☄" + eachProfileInfo.profileHeading.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            letterSpacing: 4,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 600,
                  ),

                  //image buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      //favorite button
                      GestureDetector(
                        onTap: ()
                        {
                          profileController.favoriteSentAndFavoriteReceived(
                              eachProfileInfo.uid.toString(),
                              senderName,);

                        },
                        child:const Icon(
                          Icons.star,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),


                      SizedBox(
                        width: 50,
                      ),
                      GestureDetector(
                        onTap: ()
                        {
                          startChattingInWhatsApp(eachProfileInfo.phoneNo.toString());
                        },
                        child: const Icon(
                          Icons.chat_sharp,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      GestureDetector(
                        onTap: ()
                        {
                          profileController.likeSentAndLikeReceived(
                            eachProfileInfo.uid.toString(),
                            senderName,);
                        },
                        child: const Icon(
                          Icons.thumb_up,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),

                    ],
                  )


                ],
              ),
            ),
          );
        },

      );
      })
    );
  }
}

