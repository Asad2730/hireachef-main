import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireachef/screens/customer/chef_detail.dart';

import '../../../Constants.dart';

chefCard(image, chefName, details, rating,dishes) {
  return GestureDetector(
    onTap: (){
      Get.to(()=>const ChefDetail());
    },
    child: Container(
      width: Get.width,
      height: 150,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      decoration: BoxDecoration(
        color: Constant.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2.5,
            offset: Offset(1, 1), // Shadow position
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(
                  image: AssetImage(image),
                  width: 130,
                  height: 130,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 18,vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chefName.toString().toUpperCase(),
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        details,
                        overflow: TextOverflow.fade,
                        maxLines: 4,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Constant.orange,
                            size: 15,
                          ),
                          const SizedBox(width: 5),
                          Text(rating),
                        ],
                      ),
                      Text("Items ($dishes)"),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

chefCard2(image, chefName, details, rating,dishes) {
  return GestureDetector(
    onTap: (){
      Get.to(()=>const ChefDetail());
    },
    child: Container(
      width: Get.width / 2.5,
      height: 230,
      margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      decoration: BoxDecoration(
        color: Constant.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2.5,
            offset: Offset(1, 1), // Shadow position
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: AssetImage(image),
              height: 130,
              width: 130,
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    chefName.toString().toUpperCase(),
                  ),
                  Text(
                    details,
                    overflow: TextOverflow.fade,
                    maxLines: 2,
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Constant.orange,
                            size: 15,
                          ),
                          const SizedBox(width: 5),
                          Text(rating),
                        ],
                      ),
                      Text("Items ($dishes)"),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
