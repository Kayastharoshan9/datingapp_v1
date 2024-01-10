import 'package:dating_app/authenticationScreen/registration_screen.dart';
import 'package:dating_app/controllers/authentication_controller.dart';
import 'package:dating_app/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  bool showProgressBar = false;
  bool isPasswordVisible = false;
  var controllerAuth = AuthenticationController.authController;

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

      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height:220,
              ),
              Image.asset(
              "images/logo.png",
                width:300,
              ),
              // const Text(
              //   "Welcome",
              //   style: TextStyle(
              //     fontSize: 22,
              //     fontWeight: FontWeight.bold
              //   ),
              // ),
              const SizedBox(
                height:100,
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
                width: MediaQuery.of(context).size.width - 36,
                height: 60,
                child: CustomTextFieldWidget(
                  editingController: passwordTextEditingController,
                  labelText: "Password",
                  iconData: Icons.lock_outline,
                  isObscure: !isPasswordVisible, // Updated this line
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(
                height:28,
              ),


          //loginButton
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
                if(emailTextEditingController.text.trim().isNotEmpty
                && passwordTextEditingController.text.trim().isNotEmpty
                )
                  {
                    setState(() {
                      showProgressBar =true;
                    });

                   await controllerAuth.loginUser(
                        emailTextEditingController.text.trim(),
                        passwordTextEditingController.text.trim()
                    );

                   setState(() {
                     showProgressBar = false;
                   });
                  }
                    else
                    {
                      Get.snackbar("Email or password is missing", "Please fill all fields");
                    }


              },
              child: const Center(
                child: Text(
                  "Login",
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
// new account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height:200,
                  ),
                 const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  InkWell(
                    onTap: ()
                    {
                      Get.to(RegistrationScreen());
                    },
                    child: const Text(
                      "Register Now",
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
