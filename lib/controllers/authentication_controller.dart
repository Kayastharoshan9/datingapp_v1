import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/authenticationScreen/login_screen.dart';
import 'package:dating_app/homeScreen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:dating_app/models/person.dart' as PersonModel;


class AuthenticationController extends GetxController
{
  static AuthenticationController authController = Get.find();

  late Rx<User?> firebaseCurrentUser;

  late Rx<File?> pickedFile;
  File? get profileImage => pickedFile.value;
  XFile? imageFile;


  pickImageFileFromGallery() async {
    imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      Get.snackbar(
          "Profile Image", "You have successfully picked your profile image.");
    }
      pickedFile = Rx<File?>(File(imageFile!.path)); // Update the existing Rx property.

  }

  captureImageFromCamera() async {
    imageFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (imageFile != null) {
      Get.snackbar(
          "Profile Image", "You have successfully captured your image.");
    }
    pickedFile = Rx<File?>(File(imageFile!.path)); // Update the existing Rx property.

  }

  Future<String> uploadImageToStorage(File imageFile) async
  {
    Reference referenceStorage = FirebaseStorage.instance.ref()
        .child("Profile Images")
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask task = referenceStorage.putFile(imageFile);
    TaskSnapshot snapshot = await task;

    String downloadUrlOfImage = await snapshot.ref.getDownloadURL();

    return downloadUrlOfImage;
  }
  createNewUserAccount(
  File imageProfile, String email, String password,
  String name,
  String age,
  String gender,
  String phoneNo,
  String citizenshipNumber,
  String city,
  String country,
  String profileHeading,
  String profession,
  String nationality,
  String education,
  String languageSpoken,
  String religion,
      )async
  {
    try
        {
          //create user with email and password
          UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: email,
              password: password
          );
          //upload image to storage
          String urlOfDownloadedImage = await uploadImageToStorage(imageProfile);

         // save userinfo to firebase
          PersonModel.Person personInstance = PersonModel.Person(
            uid: FirebaseAuth.instance.currentUser!.uid,
            imageProfile: urlOfDownloadedImage,
            email: email,
            password: password,
            name: name,
            age: int.parse(age),
            gender: gender,
            phoneNo: phoneNo,
            citizenshipNumber: citizenshipNumber,
            city: city,
            country: country,
            profileHeading: profileHeading,
            publishedDateTime: DateTime.now().millisecondsSinceEpoch,
            profession: profession,
            nationality: nationality,
            education: education,
            languageSpoken: languageSpoken,
            religion: religion,


          );

          await FirebaseFirestore.instance.collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .set(personInstance.toJson());

          Get.snackbar("Account Created", "Congratulations");
          Get.to (HomeScreen());
        }
    catch(errorMsg)
    {
      Get.snackbar("Account creation Unsuccessful", "Error occurred: $errorMsg");
    }
  }
  loginUser(String emailUser, String passwordUser) async
  {
    try
        {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: emailUser,
              password: passwordUser,
          );
          Get.snackbar("Logged in Successfully", "You are logged in.");
          Get.to(HomeScreen());
        }
        catch(errorMsg)
        {
          Get.snackbar("Login Unsuccessful", "Error occured: $errorMsg");

        }
  }

  checkIfUserIsLoggedIn(User? currentUser)
  {
    if(currentUser == null)
      {
        Get.to(LoginScreen());
      }
    else
      {
        Get.to(HomeScreen());
      }
  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();


    firebaseCurrentUser = Rx<User?>(FirebaseAuth.instance.currentUser);
    firebaseCurrentUser.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(firebaseCurrentUser, checkIfUserIsLoggedIn);

  }

}