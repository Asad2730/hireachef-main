import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Constants.dart';
import '../../widgets/cards/chef/dish_card.dart';
import '../../widgets/navigation/chef_navigation.dart';
import '../commonScreens/dishes/add_dish.dart';

class ChefHome extends StatefulWidget {
  const ChefHome({Key? key}) : super(key: key);

  @override
  State<ChefHome> createState() => _ChefHomeState();
}

class _ChefHomeState extends State<ChefHome> {
  TextEditingController search = TextEditingController();
  bool searchBoolean = false;

  searchTextField() {
    return TextField(
      controller: search,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.white,
      appBar: AppBar(
        title: !searchBoolean
            ? const Image(
          image: AssetImage('assets/text-logo.png'),
          width: 170,
        )
            : searchTextField(),
        backgroundColor: Constant.orange,
        iconTheme: IconThemeData(color: Constant.white),
        elevation: 0,
        actions: !searchBoolean
            ? [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              setState(
                    () {
                  searchBoolean = true;
                },
              );
            },
          ),
        ]
            : [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              setState(
                    () {
                  searchBoolean = false;
                },
              );
            },
          ),
        ],
      ),
      body:  Container(
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
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                margin:const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Dishes",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Get.to(()=>const AddDish());
                      },
                      child: Container(
                        width:80,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Constant.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Add +",
                          style: TextStyle(
                            color: Constant.orange,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              dishCard('assets/burger.jpg', "Burger", "a professional cook, typically the chief cook in a restaurant or hotel.",
                  '4.3'),
              dishCard('assets/burger.jpg', "Burger", "a professional cook, typically the chief cook in a restaurant or hotel.",
                  '4.3'),
              dishCard('assets/burger.jpg', "Burger", "a professional cook, typically the chief cook in a restaurant or hotel.",
                  '4.3'),
              dishCard('assets/burger.jpg', "Burger", "a professional cook, typically the chief cook in a restaurant or hotel.",
                  '4.3'),
              dishCard('assets/burger.jpg', "Burger", "a professional cook, typically the chief cook in a restaurant or hotel.",
                  '4.3'),

            ],
          ),
        ),
      ),
      bottomNavigationBar: chefNavigation(context, 0),
    );
  }
}
