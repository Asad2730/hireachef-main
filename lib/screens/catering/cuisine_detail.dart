import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireachef/widgets/cards/catering/cuisine_card.dart';
import 'package:hireachef/widgets/cards/customer/dishes_cards.dart';

import '../../Constants.dart';
import '../commonScreens/dishes/add_dish.dart';

class CuisineDetail extends StatefulWidget {
  const CuisineDetail({Key? key}) : super(key: key);

  @override
  State<CuisineDetail> createState() => _CuisineDetailState();
}

class _CuisineDetailState extends State<CuisineDetail> {
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
                borderRadius: BorderRadius.circular(100.0),
                child: const Image(
                  image: AssetImage("assets/italian.jpg"),
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
                    "Italian Cuisine",
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
              const SizedBox(
                height: 20,
              ),
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
              const SizedBox(
                height: 15,
              ),
              dishCard(
                'assets/lasagna.jpg',
                "Lasagna",
                "Lasagna is a type of pasta, possibly one of the oldest types, made of very wide, flat sheets. Either term can also refer to an Italian dish made of stacked layers of lasagna alternating with fillings such as ragù, béchamel sauce, vegetables, cheeses, and seasonings and spices.",
                "4.4",
              ),
              dishCard(
                'assets/lasagna.jpg',
                "Lasagna",
                "Lasagna is a type of pasta, possibly one of the oldest types, made of very wide, flat sheets. Either term can also refer to an Italian dish made of stacked layers of lasagna alternating with fillings such as ragù, béchamel sauce, vegetables, cheeses, and seasonings and spices.",
                "4.4",
              ),
              dishCard(
                'assets/lasagna.jpg',
                "Lasagna",
                "Lasagna is a type of pasta, possibly one of the oldest types, made of very wide, flat sheets. Either term can also refer to an Italian dish made of stacked layers of lasagna alternating with fillings such as ragù, béchamel sauce, vegetables, cheeses, and seasonings and spices.",
                "4.4",
              ),
              dishCard(
                'assets/lasagna.jpg',
                "Lasagna",
                "Lasagna is a type of pasta, possibly one of the oldest types, made of very wide, flat sheets. Either term can also refer to an Italian dish made of stacked layers of lasagna alternating with fillings such as ragù, béchamel sauce, vegetables, cheeses, and seasonings and spices.",
                "4.4",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
