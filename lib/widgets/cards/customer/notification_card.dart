import 'package:flutter/material.dart';
import 'package:get/get.dart';

notificationCard(name,message,time,image){
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image(
                image: AssetImage(image),
                width: 50,
                height:50,
              ),
            ),
            const SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name+" "+message),
                const SizedBox(
                  height: 5,
                ),
                Text(time),
              ],
            ),

          ],
        ),
        const SizedBox(height: 10,),
        Container(
          width: Get.width-80,
          height: 0.2
          ,
          color: Colors.black,
        )
      ],
    ),
  );
}
