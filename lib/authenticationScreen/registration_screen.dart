import 'dart:io';
import 'package:dating_app/controllers/authentication_controller.dart';
import 'package:dating_app/widgets/custom_text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {


  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
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

  bool showProgressBar = false;

  var authenticationController = AuthenticationController.authController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("images/chat.jpg"),
    fit: BoxFit.cover,
    ),
    ),
      child: SingleChildScrollView
        (
        child: Center(
          child: Column(
            children: [

              const SizedBox(
                height: 100,
              ),


              authenticationController.imageFile == null ?
              const CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage(
                    "images/profile.png"
                ),
              ) :
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: FileImage(
                      File(
                        authenticationController.imageFile!.path
                      ),
                    ),
                  )
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async
                    {
                     await authenticationController.pickImageFileFromGallery();

                     setState(() {
                       authenticationController.imageFile;
                     });
                    },
                    icon: const Icon(
                      Icons.image_outlined,
                      color: Colors.black,
                      size:30,
                  ),
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  IconButton(
                    onPressed: () async
                    {
                      await authenticationController.captureImageFromCamera();
                      setState(() {
                        authenticationController.imageFile;
                      });

                    },
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ],
              ),

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

              //email
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 60,
                child: CustomTextFieldWidget(
                  editingController:emailTextEditingController,
                  labelText:"Email",
                  iconData: Icons.email_outlined,
                  isObscure: false,
                ),
              ),

              const SizedBox(
                height:28,
              ),

              //password
              SizedBox(
                width: MediaQuery.of(context).size.width -36,
                height: 60,
                child: CustomTextFieldWidget(
                  editingController:passwordTextEditingController,
                  labelText:"Password",
                  iconData: Icons.lock_outline,
                  isObscure: true,
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

              //age
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



              //create account button
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
                    if(authenticationController.imageFile != null)
                    {
                       if(nameTextEditingController.text.trim().isNotEmpty
                           && emailTextEditingController.text.trim().isNotEmpty
                           && passwordTextEditingController.text.trim().isNotEmpty
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
                         setState(() {
                           showProgressBar = true;
                         });
                await authenticationController.createNewUserAccount
                           (
                             authenticationController.profileImage!,
                             emailTextEditingController.text.trim(),
                             passwordTextEditingController.text.trim(),
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
                         );
                          setState(() {
                            showProgressBar = false;
                          });
                       }
                       else
                       {
                         Get.snackbar("A Field is empty", "Please fll out all the fields.");
                       }
                    }
                    else
                      {
                        Get.snackbar("Image File Missing", "Please select an image or capture.");

                      }


                  },
                  child: const Center(
                    child: Text(
                      "Create Account",
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
// already have account account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  InkWell(
                    onTap: ()
                    {
                      Get.back();
                    },
                    child: const Text(
                      "Login Now",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height:20,
              ),

              showProgressBar == true
                  ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
              )
                  : Container(),


            ],
          ),
        ),
      ),
        ),
    );

  }
}
