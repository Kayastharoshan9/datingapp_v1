import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/global.dart';
import 'package:dating_app/homeScreen/home_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/custom_text_field_widget.dart';



class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {

  bool uploading = false, next = false;
  final List<File> _image = [];
  List<String> urlsList = [];
  double val = 0;

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController ageTextEditingController = TextEditingController();
  TextEditingController genderTextEditingController = TextEditingController();
  TextEditingController phoneNoTextEditingController = TextEditingController();
  TextEditingController citizenshipNumberTextEditingController = TextEditingController();
  TextEditingController cityTextEditingController = TextEditingController();
  TextEditingController countryTextEditingController = TextEditingController();
  TextEditingController profileHeadingTextEditingController = TextEditingController();
  TextEditingController professionTextEditingController = TextEditingController();
  TextEditingController nationalityTextEditingController = TextEditingController();
  TextEditingController educationTextEditingController = TextEditingController();
  TextEditingController languageSpokenTextEditingController = TextEditingController();
  TextEditingController religionTextEditingController = TextEditingController();


  String name = '';
  String age = '';
  String gender = '';
  String phoneNo = '';
  String citizenshipNumber = '';
  String city = '';
  String country = '';
  String profileHeading = '';
  String profession = '';
  String nationality = '';
  String education = '';
  String languageSpoken = '';
  String religion = '';

  chooseImage() async
  {
    XFile? pickedFIle = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _image.add(File(pickedFIle!.path));
    });
  }

  uploadImages() async
  {
    int i = 1;
    for(var img in _image)
      {
        setState(() {

        });

        var refImages = FirebaseStorage.instance
            .ref()
            .child("images/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg");

        await refImages.putFile(img)
            .whenComplete(() async
{
  await refImages.getDownloadURL()
      .then((urlImage)
  {
    urlsList.add(urlImage);

  });
});
      }
  }
  retrieveUserData() async
  {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserID)
        .get()
        .then((snapshot)
    {
      if(snapshot.exists)
      {
        setState(() {
      name = snapshot.data()!["name"];
      nameTextEditingController.text = name;
      age = snapshot.data()!["age"].toString();
      ageTextEditingController.text = age;
      gender = snapshot.data()!["gender"];
      genderTextEditingController.text = gender;
      phoneNo = snapshot.data()!["phoneNo"];
      phoneNoTextEditingController.text = phoneNo;
      city = snapshot.data()!["city"];
      cityTextEditingController.text = city;
      country = snapshot.data()!["country"];
      countryTextEditingController.text = country;
      profileHeading = snapshot.data()!["profileHeading"];
      profileHeadingTextEditingController.text = profileHeading;
      profession = snapshot.data()!["profession"];
      professionTextEditingController.text = profession;
      nationality = snapshot.data()!["nationality"];
      nationalityTextEditingController.text = nationality;
      education = snapshot.data()!["education"];
      educationTextEditingController.text = education;
      languageSpoken = snapshot.data()!["languageSpoken"];
      languageSpokenTextEditingController.text = languageSpoken;
      religion = snapshot.data()!["religion"];
      religionTextEditingController.text = religion;
        });
      }
    });
  }

  updateUserDataToFirestoreDatabase(
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
      ) async
  {
    showDialog(
        context: context,
        builder: (context)
        {
          return const AlertDialog(
            content: SizedBox(
              height: 200,
              child: Center(
                  child:
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 10,
                      ),
                      Text("uploading images..."),
                    ],
                  )
              ),
            ),
          );
        }
    );

    await uploadImages();

    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserID)
        .update(
        {
          "name": name,
          "age": int.parse(age),
          "gender": gender,
          "phoneNo": phoneNo,
          "citizenshipNumber": citizenshipNumber,
          "city": city,
          "country": country,
          "profileHeading": profileHeading,
          "profession": profession,
          "nationality": nationality,
          "education": education,
          "languageSpoken": languageSpoken,
          "religion": religion,

          "urlImage1": urlsList[0].toString(),
          "urlImage2": urlsList[1].toString(),
          "urlImage3": urlsList[2].toString(),
          "urlImage4": urlsList[3].toString(),
          "urlImage5": urlsList[4].toString(),

    });
    Get.snackbar("Updated", "Your account has been updated successfully.");

    Get.to(HomeScreen());

    setState(() {
      uploading = false;
      _image.clear();
      urlsList.clear();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          next ? "Profile Information" : "Choose 5 images",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        actions: [
          next ? Container()
              : IconButton(
              onPressed:()
          {
            if(_image.length == 5)
              {
                setState(() {
                  uploading = false;
                  next = true;
                });
              }
            else
              {
                Get.snackbar("5 images", "Please choose 5 images.");
              }
          },
            icon: Icon(Icons.navigate_next_outlined, size:36,),
          ),
        ],
      ),
      body: next
          ?
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10,
              ),


              //name
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 60,
                child: CustomTextFieldWidget(
                  editingController:nameTextEditingController,
                  labelText:"Name",
                  iconData: Icons.person_outline,
                  isObscure: false,
                ),
              ),


              const SizedBox(
                height:28,
              ),


              //age
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 60,
                child: CustomTextFieldWidget(
                  editingController:ageTextEditingController,
                  labelText:"Age",
                  iconData: Icons.numbers,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height:28,
              ),

              //gender
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 60,
                child: CustomTextFieldWidget(
                  editingController:genderTextEditingController,
                  labelText:"Gender",
                  iconData: Icons.male_outlined,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height:28,
              ),

              //phoneNo
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 60,
                child: CustomTextFieldWidget(
                  editingController:phoneNoTextEditingController,
                  labelText:"Phone",
                  iconData: Icons.phone,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height:28,
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 60,
                child: CustomTextFieldWidget(
                  editingController:citizenshipNumberTextEditingController,
                  labelText:"Citizenship Number",
                  iconData: Icons.card_membership,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height:28,
              ),


              //City
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 60,
                child: CustomTextFieldWidget(
                  editingController:cityTextEditingController,
                  labelText:"City",
                  iconData: Icons.location_city,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height:28,
              ),

              //country
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 60,
                child: CustomTextFieldWidget(
                  editingController:countryTextEditingController,
                  labelText:"Country",
                  iconData: Icons.location_city,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height:28,
              ),


              //profile heading
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 60,
                child: CustomTextFieldWidget(
                  editingController:profileHeadingTextEditingController,
                  labelText:"Profile Heading",
                  iconData: Icons.text_fields,
                  isObscure: false,
                ),
              ),


              const SizedBox(
                height:28,
              ),

              //profession
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 60,
                child: CustomTextFieldWidget(
                  editingController:professionTextEditingController,
                  labelText:"Profession",
                  iconData: Icons.business_center,
                  isObscure: false,
                ),
              ),


              const SizedBox(
                height:28,
              ),



              //nationality
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 60,
                child: CustomTextFieldWidget(
                  editingController:nationalityTextEditingController,
                  labelText:"Nationality",
                  iconData: Icons.flag_circle_outlined,
                  isObscure: false,
                ),
              ),


              const SizedBox(
                height:28,
              ),

              //education
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 60,
                child: CustomTextFieldWidget(
                  editingController:educationTextEditingController,
                  labelText:"Education",
                  iconData: Icons.history_edu,
                  isObscure: false,
                ),
              ),


              const SizedBox(
                height:28,
              ),

              //languagespoken
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 60,
                child: CustomTextFieldWidget(
                  editingController:languageSpokenTextEditingController,
                  labelText:"Language Spoken",
                  iconData: CupertinoIcons.person_badge_plus_fill,
                  isObscure: false,
                ),
              ),


              const SizedBox(
                height:28,
              ),

              //religion
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 60,
                child: CustomTextFieldWidget(
                  editingController:religionTextEditingController,
                  labelText:"Religion?",
                  iconData: CupertinoIcons.checkmark_seal_fill,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height:28,
              ),

              //create update button
              Container(
                width: MediaQuery.of(context).size.width -36,
                height: 60,
                decoration: const BoxDecoration(

                    borderRadius: BorderRadius.all(
                        Radius.circular(12)
                    )
                ),
                child: InkWell(
                  onTap: () async
                  {
                  if(nameTextEditingController.text.trim().isNotEmpty
                  && ageTextEditingController.text.trim().isNotEmpty
                  && genderTextEditingController.text.trim().isNotEmpty
                  && phoneNoTextEditingController.text.trim().isNotEmpty
                  && citizenshipNumberTextEditingController.text.trim().isNotEmpty
                  && cityTextEditingController.text.trim().isNotEmpty
                  && countryTextEditingController.text.trim().isNotEmpty
                  && profileHeadingTextEditingController.text.trim().isNotEmpty
                  && professionTextEditingController.text.trim().isNotEmpty
                  && nationalityTextEditingController.text.trim().isNotEmpty
                  && educationTextEditingController.text.trim().isNotEmpty
                  && languageSpokenTextEditingController.text.trim().isNotEmpty
                  && religionTextEditingController.text.trim().isNotEmpty)

                  {
                    _image.length > 0 ?
                  await updateUserDataToFirestoreDatabase
                  (
                  nameTextEditingController.text.trim(),
                  ageTextEditingController.text.trim(),
                  genderTextEditingController.text.trim(),
                  phoneNoTextEditingController.text.trim(),
                  citizenshipNumberTextEditingController.text.trim(),
                  cityTextEditingController.text.trim(),
                  countryTextEditingController.text.trim(),
                  profileHeadingTextEditingController.text.trim(),
                  professionTextEditingController.text.trim(),
                  nationalityTextEditingController.text.trim(),
                  educationTextEditingController.text.trim(),
                  languageSpokenTextEditingController.text.trim(),
                  religionTextEditingController.text.trim()
                  ) : null;

                  }
                  else
                  {
                  Get.snackbar("A Field is empty", "Please fll out all the fields.");
                  }
                  },
                  child: const Center(
                    child: Text(
                      "Update",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height:20,
              ),

            ],
          ),
        ),
      )
          : Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  child: GridView.builder(
                    itemCount: _image.length + 1,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:3,
                    ),
                    itemBuilder: (context, index)
                    {
                      return index == 0
                          ? Container(
                        color: Colors.black45,
                        child: Center(
                          child: IconButton(
                            onPressed: ()
                            {
                              if(_image.length < 5)
                                {
                                  !uploading ? chooseImage() : null;
                                }
                              else
                                {
                                  setState(() {
                                    uploading == true;
                                  });
                                  Get.snackbar("Image Selected", "5 images already selected");
                                }
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ),
                      )
                          : Container(
                        margin: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(
                                  _image[index - 1],
                              ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  )
                ),
              ],
      ),
    );
  }
}
