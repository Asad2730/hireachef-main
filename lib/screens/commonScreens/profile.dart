import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:hireachef/Helper.dart';
import 'package:hireachef/screens/auth/login.dart';
import 'package:hireachef/screens/customer/password_edit.dart';
import 'package:hireachef/widgets/navigation/bottom_navigation.dart';
import 'package:hireachef/widgets/navigation/catering_navigation.dart';

import '../../Constants.dart';
import '../../widgets/cards/customer/profile_cards.dart';
import '../../widgets/navigation/chef_navigation.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  var id;
  Profile.set({this.id});
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bottomNavigation() {
    if (widget.id == 1) {
      return navigationBar(context, 4);
    } else if (widget.id == 2) {
      return chefNavigation(context, 4);
    } else if (widget.id == 3) {
      return cateringNavigation(context, 4);
    } else if (widget.id == 4) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Image(
          image: AssetImage('assets/text-logo.png'),
          width: 170,
        ),
        backgroundColor: Constant.orange,
        iconTheme: IconThemeData(color: Constant.white),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              setState(
                () {
                  Get.offAll(() => const Login());
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Constant.orange,
              Constant.white,
            ],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(200.0),
              child: Image.network(
                Helper.loggedUser.pic,
                width: 130,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              Helper.loggedUser.username,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 40,
            ),
            profileCard("Name", Helper.loggedUser.username),
            profileCard("Email", Helper.loggedUser.email),
            profileCard("City", Helper.loggedUser.location),
            Helper.loggedUser.rating != 0
                ? profileCard('Rating',
                    Helper.loggedUser.rating.toPrecision(1).toString())
                : const Text(''),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: const Text(
                    "Password",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "●●●●●●●●",
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const PasswordEdit());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Icon(
                          Icons.mode_edit_outline_outlined,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 0.5,
                  color: Colors.grey,
                )
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigation(),
    );
  }
}
