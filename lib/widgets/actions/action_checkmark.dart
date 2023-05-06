import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ActionCheckmark extends StatelessWidget {
  bool isCompleted;
  VoidCallback checkmarkHandler;
  String label;
  ActionCheckmark(
      {super.key,
      required this.isCompleted,
      required this.checkmarkHandler,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: checkmarkHandler,
      child: Row(
        children: [
          Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              border: isCompleted ? null : Border.all(color: const Color.fromRGBO(107,114,128,1)),
                shape: BoxShape.circle,
                color:
                    isCompleted ? const Color.fromRGBO(33, 207, 155, 1) : null),
            child: isCompleted
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                  )
                : null,
          ),
          Expanded(child: Html(data: label))
        ],
      ),
    );
  }
}
