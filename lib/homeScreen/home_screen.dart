import 'package:dating_app/pushNotificationSystem/push-notification_system.dart';
import 'package:dating_app/tabScreen/favorite_sent_favorite_received_screen.dart';
import 'package:dating_app/tabScreen/like_sent_like_received_screen.dart';
import 'package:dating_app/tabScreen/swipping_screen.dart';
import 'package:dating_app/tabScreen/user_details_screen.dart';
import 'package:dating_app/tabScreen/view_sent_view_received_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
{
  int ScreenIndex =0;

  List tabScreenList =
      [
        SwippingScreen(),
        ViewSentViewReceivedScreen(),
        FavoriteSentFavoriteReceivedScreen(),
        LikeSentLikeReceivedScreen(),
        UserDetailScreen(userID: FirebaseAuth.instance.currentUser!.uid,),
      ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    PushNotificationSystem notificationSystem = PushNotificationSystem();
    notificationSystem.generateDeviceRegistrationToken();
    notificationSystem.whenNotificationReceived(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (indexNumber)
        {
          setState(() {
            ScreenIndex = indexNumber;
          });

        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        currentIndex: ScreenIndex,
        items: const [

          //Swipping Screen
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: " "
          ),


          //View sent view received
          BottomNavigationBarItem(
              icon: Icon(
                Icons.remove_red_eye_rounded,
                size: 30,
              ),
              label: " "
          ),



          //favorite sent favorite received
          BottomNavigationBarItem(
              icon: Icon(
                Icons.star,
                size: 30,
              ),
              label: " "
          ),


          //like sent like received
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                size: 30,
              ),
              label: " "
          ),



          //user details
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 30,
              ),
              label: " "
          ),

        ],
      ),
      body: tabScreenList[ScreenIndex],
    );
  }
}
