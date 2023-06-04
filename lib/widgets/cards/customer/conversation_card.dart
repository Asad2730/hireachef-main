import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hireachef/screens/commonScreens/chat/chat_detail.dart';

convoCard(name, messageText,imageUrl,{required String id}) {
  return GestureDetector(
    onTap: () {
      Get.to(()=> ChatDetail(id: id,name: name,pic: imageUrl,));
    },
    child: Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: [
                CircleAvatar(
                  maxRadius: 30,
                  backgroundImage: NetworkImage(imageUrl),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          messageText,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    ),
  );
}
