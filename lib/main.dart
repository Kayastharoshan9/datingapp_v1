import 'package:dating_app/controllers/authentication_controller.dart';
import 'package:dating_app/authenticationScreen/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async

{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey:"AIzaSyDLkVxR30JM4wJ0vs4DXjZN-8IwOmYMw1k",
      appId: "1:249053253836:android:fa0a05064d696b24233269",
      messagingSenderId: "249053253836",
      projectId: "dating-app-c3f54",
      storageBucket: "gs://dating-app-c3f54.appspot.com"
    ),
  );

  AuthenticationController authenticationController = AuthenticationController();
  Get.put(authenticationController);

  await Permission.notification.isDenied.then((value)
  {
    if(value)
      {
        Permission.notification.request();
      }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Dating App',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

