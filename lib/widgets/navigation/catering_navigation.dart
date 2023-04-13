import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireachef/screens/catering/catering_home.dart';
import 'package:hireachef/screens/commonScreens/chat/chat_main.dart';
import '../../Constants.dart';
import '../../screens/commonScreens/orders/orders_tab.dart';
import '../../screens/commonScreens/profile.dart';

cateringNavigation(context, indexNo) {
  return CurvedNavigationBar(
    backgroundColor: Constant.orange,
    color: Constant.white,
    items: const [
      Icon(
        Icons.food_bank_outlined,
        size: 15,
        color: Colors.black,
      ),
      Icon(
        Icons.message_outlined,
        size: 15,
        color: Colors.black,
      ),
      Icon(
        Icons.border_color_outlined,
        size: 15,
        color: Colors.black,
      ),
      Icon(
        Icons.person,
        size: 15,
        color: Colors.black,
      ),
    ],
    index: indexNo,
    height: 50,
    animationDuration: const Duration(milliseconds: 200),
    animationCurve: Curves.bounceInOut,
    onTap: (index) async {
      if (index == 0) {
        await Future.delayed(const Duration(milliseconds: 200));
        Get.offAll(() => const CateringHome());
      }
      if (index == 1) {
        await Future.delayed(const Duration(milliseconds: 200));
        Get.offAll(() =>  ChatMain.set(id:3));
      }
      if (index == 2) {
        await Future.delayed(const Duration(milliseconds: 200));
        Get.offAll(() =>  OrdersTab.set(id:3));
      }
      if (index == 3) {
        await Future.delayed(const Duration(milliseconds: 200));
        Get.offAll(() => Profile.set(id:3));
      }
    },
  );
}
