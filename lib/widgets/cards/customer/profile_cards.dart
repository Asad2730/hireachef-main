import 'package:flutter/material.dart';

profileCard(title, value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Text(
          title,
          style: const TextStyle(fontSize: 12),
        ),
      ),
      Text(
        value,
        style: const TextStyle(fontSize: 16),
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 0.5,
        color: Colors.grey,
      )
    ],
  );
}
