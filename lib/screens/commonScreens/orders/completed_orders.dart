import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Constants.dart';
import '../../../widgets/cards/chef/order_card.dart';

class CompletedOrders extends StatefulWidget {
  const CompletedOrders({Key? key}) : super(key: key);

  @override
  State<CompletedOrders> createState() => _CompletedOrdersState();
}

class _CompletedOrdersState extends State<CompletedOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              completedOrderCard("Dummy User","Burger","9:59pm",'assets/avatar-2.jpg'),
              completedOrderCard("Dummy User","Burger","9:59pm",'assets/avatar-2.jpg'),
              completedOrderCard("Dummy User","Burger","9:59pm",'assets/avatar-2.jpg')
            ],
          ),
        ),
      ),
    );
  }
}
