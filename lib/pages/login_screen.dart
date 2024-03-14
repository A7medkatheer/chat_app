// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:chat_app/helper/snack_bar.dart';
import 'package:chat_app/pages/chat_screen.dart';
import 'package:chat_app/pages/register_screen.dart';
import 'package:chat_app/widgets/constant.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);
  static String id = "login_screen";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  String? password, email;
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                // SizedBox(height: MediaQuery.of(context).size.height * 0.11),
                Image.asset(
                  'assets/images/scholar.png',
                  height: 100,
                  //
                ),
                const Text("Scholar Chat",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'pacifico')),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                const Text("LOGIN",
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
                      // isLoading = true;
                      // setState(() {});
                      try {
                        await loginUser();

                        Navigator.pushNamed(context, ChatPage.id,
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          snackBar(context,
                              message: "No user found for that email.");
                        } else if (e.code == 'wrong-password') {
                          snackBar(context,
                              message:
                                  "Wrong password provided for that user.");
                        }
                      } catch (e) {
                        snackBar(context, message: e.toString());
                      }
                    } else {
                      snackBar(context, message: "Please try again");
                    }

                    // isLoading = false;
                    // setState(() {});
                  },
                  text: "login",
                ),
                Row(
                  children: [
                    const Text(
                      "Don't have an account ?",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: const Text(
                        "Sign Up",
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

  Future<void> loginUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.signInWithEmailAndPassword(
        email: email!, password: password!);
  }
}
