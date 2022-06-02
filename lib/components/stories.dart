import 'package:contact_ui/view/utils/utils.dart';
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
          decoration: ViewUtils.bigStori(),
          child: Container(
            width: 60,
            height: 60,
            decoration: ViewUtils.littleStori(image),
            margin: const EdgeInsets.all(5),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 3),
        ),
        const SizedBox(height: 5),
        Text(username),
      ],
    );
