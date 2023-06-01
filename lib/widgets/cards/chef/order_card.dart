import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';



pendingOrderCard(name, dish, time, image, String id, VoidCallback refresh) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.network(
                image,
                width: 50,
                height:50,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(name + " has placed order for " + dish),
                const SizedBox(
                  height: 5,
                ),
                Text(time),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8 , horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: GestureDetector(
                onTap: ()async{
                  DateTime now = DateTime.now();
                  String formattedTime = DateFormat('h:mm a').format(now);
                  await FirebaseFirestore.instance.collection('requests')
                   .doc(id)
                    .update({'status':1,'time':formattedTime});
                  refresh();
                },
                child: const Row(
                  children:  [
                    Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    Text(
                      "Accept",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: GestureDetector(
                onTap: ()async{
                  DateTime now = DateTime.now();
                  String formattedTime = DateFormat('h:mm a').format(now);
                  await FirebaseFirestore.instance.collection('requests')
                      .doc(id)
                      .update({'status':-1,'time':formattedTime});
                  refresh();
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    Text(
                      "Decline",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          width: Get.width - 80,
          height: 0.2,
          color: Colors.black,
        )
      ],
    ),
  );
}

completedOrderCard(name, dish, time, image) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.network(
                image,
                width: 50,
                height:50,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Order of $name  $dish"),
                const SizedBox(
                  height: 5,
                ),
                Text("was delivered at : $time"),
              ],
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          width: Get.width - 80,
          height: 0.2,
          color: Colors.black,
        )
      ],
    ),
  );
}

activeOrderCard(id,name, dish, time, image,VoidCallback refresh) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.network(
                image,
                width: 50,
                height:50,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$name order of $dish "),
                const SizedBox(
                  height: 5,
                ),
                Text("Punched at : $time"),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8 , horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GestureDetector(
                    onTap: ()async{
                      DateTime now = DateTime.now();
                      String formattedTime = DateFormat('h:mm a').format(now);
                      await FirebaseFirestore.instance.collection('requests')
                          .doc(id)
                          .update({'status':3,'time':formattedTime});
                      refresh();
                    },
                    child: const Row(
                      children:  [
                        Icon(
                          Icons.delivery_dining_sharp,
                          color: Colors.white,
                        ),
                        Text(
                          "Deliver",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          width: Get.width - 80,
          height: 0.2,
          color: Colors.black,
        ),

      ],
    ),
  );
}
