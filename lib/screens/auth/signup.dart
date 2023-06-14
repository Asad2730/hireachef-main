import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hireachef/Constants.dart';
import 'package:hireachef/screens/auth/login.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/textfields/text_field.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController city = TextEditingController();
  var imageFile;

  int radioValue = 1;
  handleRadioValueChange(int value) {
    setState(() {
      radioValue = value;
    });
  }

  getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
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
              padding: const EdgeInsets.symmetric(horizontal: 25),
              width: Get.width - 20,
              height: 650,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        getFromGallery();
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(200.0),
                        child: imageFile != null
                            ? Image.file(
                                imageFile,
                                width: 130,
                                height: 130,
                              )
                            : const Image(
                                image: AssetImage("assets/camera.png"),
                                width: 100,
                                height: 100,
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    textField(username, "Username", Icons.person),
                    textField(email, "Email", Icons.email_outlined),
                    textField(password, "Password", Icons.password),
                    textField(city, "Location", Icons.location_city_outlined),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                            value: 1,
                            groupValue: radioValue,
                            onChanged: (value) {
                              handleRadioValueChange(1);
                            }),
                        const Text(
                          'Customer',
                          style: TextStyle(fontSize: 12.0),
                        ),
                        Radio(
                            value: 2,
                            groupValue: radioValue,
                            onChanged: (value) {
                              handleRadioValueChange(2);
                            }),
                        const Text(
                          'Chef',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                        Radio(
                            value: 3,
                            groupValue: radioValue,
                            onChanged: (value) {
                              handleRadioValueChange(3);
                            }),
                        const Text(
                          'Caterer',
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        addUser();
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
                      onTap: () {
                        Get.to(() => const Login());
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
              )),
        ),
      ),
    );
  }

  void addUser() async {
    try {
      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      final FirebaseStorage storage = FirebaseStorage.instance;
      final Reference ref = storage.ref().child('profile/$uniqueFileName');
      final TaskSnapshot uploadTask = await ref.putFile(imageFile);
      final String downloadURL = await uploadTask.ref.getDownloadURL();
      final FirebaseFirestore db = FirebaseFirestore.instance;
      Map<String, dynamic> data = {
        'username': username.text.toString().toLowerCase(),
        'email': email.text.toString().toLowerCase(),
        'password': password.text.toString(),
        'location': city.text.toString(),
        'type': radioValue,
        'pic': downloadURL,
      };

      await db.collection('users').add(data);
      Fluttertoast.showToast(msg: 'User added successfully!');
      Get.offAll(() => const Login());
    } catch (ex) {
      print(ex);
    }
  }
}
