import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hireachef/screens/commonScreens/blogs/blog_detail.dart';
import 'package:hireachef/screens/commonScreens/blogs/blog_post.dart';

import '../../../Constants.dart';

blogCard(data,id,docId){
  return GestureDetector(
    onTap: (){
      Get.to(()=> BlogDetail(data: data,));
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
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  data['url'],
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
                        data['title'].toString().toUpperCase(),
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        data['subTitle'].toString(),
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        data['description'].toString() ,
                        overflow: TextOverflow.fade,
                        maxLines: 2,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  id!=1?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children:  [
                          GestureDetector(
                            onTap: (){
                              Get.to(()=>BlogPost(id: docId,option: 2, url: data['url'],));
                            },
                            child: const Icon(Icons.mode_edit_outlined,color: Colors.green,),
                          ),
                          const Text(" / "),
                          GestureDetector(
                            onTap: ()async{
                             await FirebaseFirestore.instance.collection('blogs')
                                  .doc(docId)
                                  .delete();
                             Fluttertoast.showToast(msg: 'Blog deleted!');
                            },
                            child: const Icon(Icons.delete_forever_outlined,color: Colors.red,),
                          ),
                        ],
                      ),
                    ],
                  ):Container()
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}