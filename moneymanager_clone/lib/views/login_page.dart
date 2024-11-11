import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:moneymanager_clone/bottomNav/bottomNav.dart';
import 'package:moneymanager_clone/controller/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  AuthController authController = Get.put(AuthController());
  TextEditingController usernameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("MoneyManager"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                child: Text(
                  "SIGN IN",
                  style: TextStyle(fontSize: 40),
                ),
              ),
              Gap(40),
              Text(
                "Please sign in your account to get started!",
                style: TextStyle(
                    fontSize: 17, color: Color.fromARGB(255, 102, 101, 101)),
              ),
              Gap(35),
              TextFormField(
                controller: usernameTextController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: const Color.fromARGB(255, 157, 156, 156)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  hintText: "Username",
                  hintStyle: TextStyle(
                    color: const Color.fromARGB(255, 177, 177, 177),
                    fontSize: 20,
                  ),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? "Please enter your username ."
                    : null,
              ),
              Gap(20),
              TextFormField(
                controller: passwordTextController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: const Color.fromARGB(255, 157, 156, 156)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  hintText: "Password",
                  hintStyle: TextStyle(
                    color: const Color.fromARGB(255, 177, 177, 177),
                    fontSize: 20,
                  ),
                ),
                obscureText: true,
                validator: (value) => value == null || value.isEmpty
                    ? "Please enter your password ."
                    : null,
              ),
              Gap(40),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate() &&
                      await authController.loginOrRegisterUser(
                          userName: usernameTextController.text,
                          password: passwordTextController.text))
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyBottomNavBar(),
                        ),
                        (r) => false);
                },
                child: authController.isAuthentication
                    ? LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.white, size: 60)
                    : Text(
                        "Sign In",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(100, 40),
                  backgroundColor: const Color.fromARGB(255, 168, 194, 236),
                ),
              ),
            ]),
          ),
        ),
      );
    });
  }
}
