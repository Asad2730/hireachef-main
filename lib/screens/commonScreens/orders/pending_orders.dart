import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireachef/widgets/navigation/chef_navigation.dart';

import '../../../Constants.dart';
import '../../../widgets/cards/chef/order_card.dart';

class PendingOrders extends StatefulWidget {
  const PendingOrders({Key? key}) : super(key: key);

  @override
  State<PendingOrders> createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
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
              pendingOrderCard("Dummy User","Burger","9:59pm",'assets/avatar-2.jpg'),
              pendingOrderCard("Dummy User","Burger","9:59pm",'assets/avatar-2.jpg'),
              pendingOrderCard("Dummy User","Burger","9:59pm",'assets/avatar-2.jpg')
            ],
          ),
        ),
      ),

    );
  }
}
