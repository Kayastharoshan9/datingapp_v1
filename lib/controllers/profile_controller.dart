import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/global.dart';
import 'package:dating_app/models/person.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController
{
  final Rx<List<Person>> userProfileList = Rx<List<Person>>([]);
  List<Person> get allUsersProfileList => userProfileList.value;
  
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    
    userProfileList.bindStream(
      FirebaseFirestore.instance.collection("users")
          .where("uid", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots()
          .map((QuerySnapshot queryDataSnapshot)
          {
            List<Person> profilesList =[];
            for(var eachProfile in queryDataSnapshot.docs)
            {
              profilesList.add(Person.fromDataSnapshot(eachProfile));
            }
            return profilesList;
          })
    );
  }

  favoriteSentAndFavoriteReceived(String toUserID, String senderName)async
  {
    var document = await FirebaseFirestore.instance
        .collection("users")
        .doc(toUserID).collection("favoriteReceived").doc(currentUserID)
        .get();


    //remove the favorite from database
    if(document.exists)
      {
        //remove current userID from the favorite received list of that profile person
        await FirebaseFirestore.instance
            .collection("users")
            .doc(toUserID).collection("favoriteReceived").doc(currentUserID)
            .delete();

        //  remove cuurent user from the favorite list of that profile
        await FirebaseFirestore.instance
            .collection("users")
            .doc(currentUserID).collection("favoriteSent").doc(toUserID)
            .delete();
      }
    else  //mark as fav in database
      {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(toUserID).collection("favoriteReceived").doc(currentUserID)
          .set({});

      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID).collection("favoriteSent").doc(toUserID)
          .set({});

      //send notification
      sendNotificationToUser(toUserID, "Favorite", senderName);
      }
    update();
  }

  likeSentAndLikeReceived(String toUserID, String senderName)async
   {
    var document = await FirebaseFirestore.instance
        .collection("users")
        .doc(toUserID).collection("likeReceived").doc(currentUserID)
        .get();


    //remove the like from database
    if(document.exists)
    {
      //remove current userID from the like received list of that profile person
      await FirebaseFirestore.instance
          .collection("users")
          .doc(toUserID).collection("likeReceived").doc(currentUserID)
          .delete();

      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID).collection("likeSent").doc(toUserID)
          .delete();
    }
    else  //mark as liked in database
        {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(toUserID).collection("likeReceived").doc(currentUserID)
          .set({});

      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID).collection("likeSent").doc(toUserID)
          .set({});

      //send notification

      sendNotificationToUser(toUserID, "like", senderName);
    }
    update();
  }

  ViewSentAndViewReceived(String toUserID, String senderName)async
  {
    var document = await FirebaseFirestore.instance
        .collection("users")
        .doc(toUserID).collection("viewReceived").doc(currentUserID)
        .get();


    //remove the like from database
    if(document.exists)
    {
      print("already in view list");
    }
    else  //madd new view in database
        {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(toUserID).collection("viewReceived").doc(currentUserID)
          .set({});

      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID).collection("viewSent").doc(toUserID)
          .set({});

      //send notification

      sendNotificationToUser(toUserID, "like", senderName);
    }
    update();
  }

  sendNotificationToUser(receiverID, featureType, senderName)async
  {
    String userDeviceToken = "";

    await FirebaseFirestore.instance
    .collection("users")
    .doc(receiverID)
    .get()
    .then((snapshot)
    {
      if(snapshot.data()!["userDeviceToken"] != null)
        {
          userDeviceToken = snapshot.data()!["userDeviceToke"].toString();
        }
    });

    notificationFormat(
      userDeviceToken,
      receiverID,
      featureType,
      senderName,
    );
  }

  notificationFormat(userDeviceToken, receiverID, featureType, senderName,)
  {
    Map<String, String> headerNotification =
        {
          "Content-Type": "application/json",
          "Authorization": fromServerToken,
        };
    Map bodyNotification =
        {
          "body": "You have received a new $featureType from $senderName. Click to see.",
          "title": "New $featureType",
        };
    Map dataMap =
        {
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "id": "1",
          "status": "done",
          "userID": receiverID,
          "senderID": currentUserID,
        };

    Map notificationOfficialFormat =
        {
          "notification": bodyNotification,
          "data": dataMap,
          "priority": "high",
          "to": userDeviceToken,
        };

    http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: headerNotification,
        body: jsonEncode(notificationOfficialFormat),
     );
  }
}