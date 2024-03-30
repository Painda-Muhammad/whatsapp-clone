import 'package:flutter/material.dart';
import 'package:whatsapp_clone_app/feature/app/theme/style.dart';

Widget attachWindowItem(
    IconData? icon,
    Color color,
    String title,
    VoidCallback onPressed,
  ) {
    return Column(
      children: [
        Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Icon(icon),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          title,
          style:const TextStyle(color: greyColor, fontSize: 13),
        ),
      ],
    );
  }