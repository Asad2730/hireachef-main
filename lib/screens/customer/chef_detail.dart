import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireachef/widgets/cards/customer/dishes_cards.dart';

import '../../Constants.dart';

class ChefDetail extends StatefulWidget {
  const ChefDetail({Key? key}) : super(key: key);

  @override
  State<ChefDetail> createState() => _ChefDetailState();
}

class _ChefDetailState extends State<ChefDetail> {
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(200.0),
                child: const Image(
                  image: AssetImage("assets/avatar-2.jpg"),
                  width: 130,
                  height: 130,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "LOREM USER",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.star,
                    color: Constant.white,
                    size: 15,
                  ),
                  const SizedBox(width: 5),
                  const Text("4.5"),
                ],
              ),
              const Text("+92 3xx xxxxxxx"),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Dishes",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              dishesCard(
                'assets/burger.jpg',
                "Burger",
                "A  hamburger, or simply burger, is a sandwich consisting of fillings—usually a patty of ground meat, typically beef—placed inside a sliced bun or bread roll.",
                "4.4",
                "50",
              ),
              dishesCard(
                'assets/burger.jpg',
                "Burger",
                "A  hamburger, or simply burger, is a sandwich consisting of fillings—usually a patty of ground meat, typically beef—placed inside a sliced bun or bread roll.",
                "4.4",
                "50",
              ),
              dishesCard(
                'assets/burger.jpg',
                "Burger",
                "A  hamburger, or simply burger, is a sandwich consisting of fillings—usually a patty of ground meat, typically beef—placed inside a sliced bun or bread roll.",
                "4.4",
                "50",
              ),
              dishesCard(
                'assets/burger.jpg',
                "Burger",
                "A  hamburger, or simply burger, is a sandwich consisting of fillings—usually a patty of ground meat, typically beef—placed inside a sliced bun or bread roll.",
                "4.4",
                "50",
              ),

            ],
          ),
        ),
      ),
    );
  }
}
