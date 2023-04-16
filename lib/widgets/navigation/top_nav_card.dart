import 'package:flutter/material.dart';
import 'package:hireachef/Helper.dart';

import '../../Constants.dart';

topNavCard(title,type,VoidCallback refresh){
  return GestureDetector(
    onTap: (){
      Helper.type = type;
      refresh();
    },
    child: Container(
      width: 100,
      height: 40,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 5),
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
      child: Text(title,textAlign: TextAlign.center,),
    ),
  );
}