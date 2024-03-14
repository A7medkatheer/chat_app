// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'package:chat_app/helper/snack_bar.dart';
import 'package:chat_app/widgets/constant.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    Key? key,
  }) : super(key: key);

  static String id = "register_screen";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  String? password;
  String? email;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Image.asset(
                  'assets/images/scholar.png',
                  height: 100,
                ),
                const Text("Scholar Chat",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'pacifico')),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                const Text("Sign up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                CustomFormTextField(
                  onChanged: (data) {
                    email = data;
                  },
                  hintText: "Email",
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                CustomFormTextField(
                  onChanged: (data) {
                    password = data;
                  },
                  hintText: "Password",
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                CustomButton(
                  ontap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await registerUser();

                        snackBar(context, message: "User Registered");
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          snackBar(context,
                              message: "The password provided is too weak.");
                        } else if (e.code == 'email-already-in-use') {
                          snackBar(context,
                              message:
                                  "The account already exists for that email.");
                        }
                      } catch (e) {
                        snackBar(context, message: e.toString());
                      }
                    } else {
                      snackBar(context, message: "Please ");
                    }

                    isLoading = false;
                    setState(() {});
                  },
                  text: "sign up",
                ),
                Row(
                  children: [
                    const Text(
                      "already have an account ?",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Color(0xFFC7EDE6)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email!, password: password!);
  }
}
