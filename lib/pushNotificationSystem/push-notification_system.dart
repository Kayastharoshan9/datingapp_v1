import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/global.dart';
import 'package:dating_app/tabScreen/user_details_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PushNotificationSystem
{
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //notification arrived or received

Future whenNotificationReceived(BuildContext context) async
{
  //1. when the app is completely closed and opened directly from push notification
  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? remoteMessage)
  {
    if(remoteMessage != null)
      {
        //open app and show notification
        openAppAndShowNotificationData(
          remoteMessage.data["userID"],
          remoteMessage.data["senderID"],
          context,
        );
      }

  });

  //2. when the app is open and it receives notification
  FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage)
  {
    if(remoteMessage != null)
    {
      //open app and show notification
      openAppAndShowNotificationData(
        remoteMessage.data["userID"],
        remoteMessage.data["senderID"],
        context,
      );
    }
  });

  //3. when the app is in the background and opened directly from the push notofocation.

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage)
  {
    if(remoteMessage != null)
    {
      //open app and show notification
      openAppAndShowNotificationData(
        remoteMessage.data["userID"],
        remoteMessage.data["senderID"],
        context,
      );
    }
  });
}

  openAppAndShowNotificationData(receiverID, senderID, context) async
  {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(senderID)
        .get()
        .then((snapshot)
        {
          String profileImage = snapshot.data()!["imageProfile"].toString();
          String name = snapshot.data()!["name"].toString();
          String age = snapshot.data()!["age"].toString();
          String city = snapshot.data()!["city"].toString();
          String country = snapshot.data()!["country"].toString();
          String profession = snapshot.data()!["profession"].toString();

          showDialog(
              context: context,
              builder: (context)
          {
            return NotificationDialogBox(
              senderID,
              profileImage,
              name,
              age,
              city,
              country,
              profession,
              context,

            );
          }
          );
        });
  }

  NotificationDialogBox(senderId, profileImage, name, age, city, country, profession, context)
  {
    return Dialog(
      child: GridTile(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: SizedBox(
            height: 300,
            child: Card(
              color: Colors.blue.shade200,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(profileImage),
                    fit: BoxFit.cover,
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name + " * " + age.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                        Row(
                          children: [

                            const Icon(
                              Icons.location_on_outlined,
                              color: Colors.black,
                              size: 16,
                            ),

                            const SizedBox(
                              width: 2,
                            ),

                           Expanded(
                               child: Text(
                                 city + " , " + country.toString(),
                               ),
                           ),
                          ],
                        ),

                        const Spacer(),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Center(
                              child: ElevatedButton(
                                onPressed: ()
                                {
                                  Get.back();
                                  
                                  Get.to(UserDetailScreen(userID:senderId,));

                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                                child: const Text(
                                  "View Profile"
                                ),
                              ),
                            ),

                            Center(
                              child: ElevatedButton(
                                onPressed: ()
                                {
                                  Get.back();
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),

                                child: const Text(
                                    "Close"
                                ),
                                ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future generateDeviceRegistrationToken() async
  {
    String? deviceToken = await messaging.getToken();

    await FirebaseFirestore.instance.collection("users")
        .doc(currentUserID)
        .update(
        {
          "userDeviceToken": deviceToken,
        });

  }
}