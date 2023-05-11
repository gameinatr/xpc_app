import 'package:flutter/material.dart';
import 'package:xpc_app/widgets/tokenized_html.dart';

class ActionCheckmark extends StatelessWidget {
  final bool isCompleted;
  final VoidCallback checkmarkHandler;
  final String label;
  const ActionCheckmark(
      {super.key,
      required this.isCompleted,
      required this.checkmarkHandler,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: checkmarkHandler,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Row(
          children: [
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                border: isCompleted ? null : Border.all(color: const Color.fromRGBO(107,114,128,1), width: 2),
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
            const SizedBox(width: 8),
            Expanded(child: TokenizedHtml(htmlData: label))
          ],
        ),
      ),
    );
  }
}
