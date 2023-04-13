import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireachef/Constants.dart';
import 'package:hireachef/screens/auth/signup.dart';
import 'package:hireachef/screens/catering/catering_home.dart';
import 'package:hireachef/screens/chef/chef_home.dart';
import 'package:hireachef/screens/customer/home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        color: Constant.orange,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            width: Get.width - 20,
            height: 500,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage('assets/logo-circle.png'),
                  width: 100,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: username,
                  //Set decoration
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Username",
                    prefixIcon: Icon(Icons.supervised_user_circle_outlined),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  controller: password,
                  //Set decoration
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                    prefixIcon: Icon(Icons.password),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: (){
                    Get.offAll(()=>const Home());
                  },
                  child: Container(
                    width: Get.width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Constant.orange,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: (){
                    Get.offAll(const Signup());
                  },
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(color: Colors.black),
                      //apply style to all
                      children: [
                        TextSpan(text: "Don't have an account? "),
                        TextSpan(
                          text: 'Signup!',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
