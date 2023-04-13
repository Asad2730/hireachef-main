import 'package:flutter/material.dart';

import '../../Constants.dart';

topNavCard(title){
  return GestureDetector(
    onTap: (){

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