 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:whatsapp_clone_app/feature/app/theme/style.dart';
  Widget messageLayout(
    {
    BuildContext? context,
    Color? messageColor,
    Alignment? alignment,
    Timestamp? createAt,
    Function? onSwipe,
    String? message,
    bool? isShowTick,
    bool? isSeen,
    VoidCallback? onLongPress,
    }
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SwipeTo(
        onRightSwipe: (details) {
          onSwipe;
        }, 
        child: GestureDetector(
          onLongPress: () {
            onLongPress;
          },
          child: Container(
            alignment: alignment,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.only(
                          top: 5, right: 85, left: 5, bottom: 5),
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context!).size.width * 0.80),
                      decoration: BoxDecoration(
                          color: messageColor,
                          borderRadius: BorderRadius.circular(8)),
                      child:  Text(
                        message!,
                        style:const TextStyle(
                          color: whiteColor,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                  ],
                ),
                Positioned(
                  right: 10,
                  bottom: 4,
                  child: Row(
                    children: [
                      Text(
                        DateFormat.jm().format(createAt!.toDate()),
                        style: const TextStyle(
                            color: lightGreyColor, fontSize: 12),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      isShowTick!
                          ? Icon(
                              isSeen! ? Icons.done_all : Icons.done,
                              size: 12,
                              color: lightGreyColor,
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }