import 'package:flutter/material.dart';
import 'package:whatsapp_clone_app/feature/app/theme/style.dart';

class NewMessage extends StatefulWidget {
 NewMessage(
      {super.key, this.messageController,required this.isShowAttach});

  final TextEditingController? messageController;
  final Function(bool isShowAttachWindow) isShowAttach;
  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  bool? isShowAttachWindow = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: senderMessageColor,
                  borderRadius: BorderRadius.circular(25)),
              child: Row(
                children: [
                  const Icon(Icons.emoji_emotions),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: TextField(
                      onTap: () => setState(() {
                        isShowAttachWindow = false;
                      }),
                      controller:widget.messageController,
                      cursorColor: tabColor,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Message',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                      isShowAttachWindow = !isShowAttachWindow!;
                        widget.isShowAttach(isShowAttachWindow!);
                      });
                    },
                    child: Transform.rotate(
                        angle: -.5, child: const Icon(Icons.attach_file)),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(Icons.camera_alt)
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
                color: tabColor, borderRadius: BorderRadius.circular(30)),
            child: Center(
                child: Icon(
                    widget.messageController!.text.isEmpty ? Icons.mic : Icons.send)),
          )
        ],
      ),
    );
  }
}
