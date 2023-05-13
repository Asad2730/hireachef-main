import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:hireachef/Helper.dart';
import 'package:hireachef/screens/customer/chef_detail.dart';

import '../../../Constants.dart';

chefCard(image, chefName, details, Map<String, dynamic> data, String cid,rate) {


  return GestureDetector(
    onTap: (){
      Get.to(()=> ChefDetail(cid: cid,data:data));
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
                child: Helper.type == 4?Image.network(
                  data['url'],
                  width: 130,
                  height: 130,
                ):Image(
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
                      RatingBarIndicator(
                        rating: rate,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 30.0,
                        direction: Axis.horizontal,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

chefCard2(image, chefName, details , Map<String, dynamic> data, String cid,double rate) {
  return GestureDetector(
    onTap: (){
      print('$data');
      Get.to(()=> ChefDetail(cid: cid,data:data));
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
           child: Helper.type == 4?Image.network(
             data['url'],
             height: 130,
             width: 130,
           ):Image(
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
                  RatingBarIndicator(
                    rating: rate,
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
