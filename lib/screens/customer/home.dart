import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireachef/Constants.dart';
import 'package:hireachef/widgets/cards/customer/chef_cards.dart';
import 'package:hireachef/widgets/navigation/bottom_navigation.dart';
import 'package:hireachef/widgets/navigation/top_nav_card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                width: Get.width,
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    topNavCard("Chefs"),
                    topNavCard("Caterers"),
                    topNavCard("Cuisines"),
                    topNavCard("Top Picks"),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 15),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "OUR TOP CHEFS",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                width: Get.width,
                height: 240,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    chefCard2('assets/chef.jpg', "Lorem Chef",
                        "a professional cook, typically the chief cook in a restaurant or hotel.", '4.3', '50'),
                    chefCard2('assets/chef.jpg', "Lorem Chef",
                        "a professional cook, typically the chief cook in a restaurant or hotel.", '4.3', '50'),
                    chefCard2('assets/chef.jpg', "Lorem Chef",
                        "a professional cook, typically the chief cook in a restaurant or hotel.", '4.3', '50'),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "You Might Also Like",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              chefCard('assets/chef.jpg', "Lorem Chef", "a professional cook, typically the chief cook in a restaurant or hotel.",
                  '4.3', '50'),
              chefCard('assets/chef.jpg', "Lorem Chef", "a professional cook, typically the chief cook in a restaurant or hotel.",
                  '4.3', '50'),
              chefCard('assets/chef.jpg', "Lorem Chef", "a professional cook, typically the chief cook in a restaurant or hotel.",
                  '4.3', '50'),
              chefCard('assets/chef.jpg', "Lorem Chef", "a professional cook, typically the chief cook in a restaurant or hotel.",
                  '4.3', '50'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: navigationBar(context, 0),
    );
  }
}
