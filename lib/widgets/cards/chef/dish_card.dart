import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../Constants.dart';
import '../../../screens/commonScreens/dishes/edit_dish.dart';

dishCard(image, chefName, details, price,docId) {
  return  Container(
      width: Get.width,
      height: 120,
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
                child: Image.network(
                   image,
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
                        maxLines: 2,
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
                            Icons.money,
                            color: Constant.orange,
                            size: 15,
                          ),
                          const SizedBox(width: 5),
                          Text(price.toString()),
                        ],
                      ),
                      Row(
                        children:  [
                          GestureDetector(
                            child: const Icon(Icons.mode_edit_outlined,color: Colors.green,),
                            onTap: (){
                              Get.to(()=>EditDish(name: chefName,price: price,
                                  description: details,id: docId,url: image));
                            },
                          ),
                          const SizedBox(width: 15,),
                          const Text(" / "),
                          const SizedBox(width: 15,),
                          GestureDetector(
                            child: const  Icon(Icons.delete_forever_outlined,color: Colors.red,),
                            onTap: ()async{
                              await FirebaseFirestore.instance
                                  .collection('dishes')
                                  .doc(docId)
                                  .delete();

                              Fluttertoast.showToast(msg: 'Deleted!');
                            },
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),

  );
}