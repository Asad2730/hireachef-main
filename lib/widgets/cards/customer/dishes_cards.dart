import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireachef/screens/customer/item_detail.dart';

import '../../../Constants.dart';

dishesCard(image, name, description, rating, price) {
  return GestureDetector(
    onTap: () {
      Get.to(()=>const ItemDetail());
    },
    child: Container(
      width: Get.width,
      height: 110,
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
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
              margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name.toString().toUpperCase(),
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(
                          description,
                          overflow: TextOverflow.fade,
                          maxLines: 2,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
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
                      Text(
                        "\$$price",
                        style: const TextStyle(fontSize: 14),
                      ),
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
