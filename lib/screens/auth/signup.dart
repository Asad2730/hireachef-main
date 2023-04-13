import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireachef/Constants.dart';
import 'package:hireachef/screens/auth/login.dart';
import 'package:hireachef/screens/customer/home.dart';

import '../../widgets/textfields/text_field.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController city = TextEditingController();

  int radioValue = 1;
  handleRadioValueChange(int value) {
    setState(() {
      radioValue = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        color: Constant.orange,
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            width: Get.width - 20,
            height: 650,
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
                textField(username, "Username", Icons.person),
                textField(email, "Email", Icons.email_outlined),
                textField(password, "Password", Icons.password),
                textField(username, "Location", Icons.location_city_outlined),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Radio(
                        value: 1,
                        groupValue: radioValue,
                        onChanged: (value){
                          handleRadioValueChange(1);
                        }
                    ),
                    const Text(
                      'Customer',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Radio(
                        value: 2,
                        groupValue: radioValue,
                        onChanged: (value){
                          handleRadioValueChange(2);
                        }
                    ),
                    const Text(
                      'Chef',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    Radio(
                        value: 3,
                        groupValue: radioValue,
                        onChanged: (value){
                          handleRadioValueChange(3);
                        }
                    ),
                    const Text(
                      'Caterer',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
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
                      "Signup",
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
                    Get.to(()=>const Login());
                  },
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(text: "Already have an account? "),
                        TextSpan(
                          text: 'Login!',
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
