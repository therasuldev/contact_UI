import 'package:flutter/material.dart';
Widget stories({
  required int index,
  required String username,
  required String image,
}) =>
    Column(
      children: [
        Container(
          width: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.orange,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(image),
              ),
            ),
            margin: const EdgeInsets.all(5),
          ),
        ),
        const SizedBox(height: 5),
        Text(username),
      ],
    );
