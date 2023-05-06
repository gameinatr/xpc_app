import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:xpc_app/models/trainings/next_training_model.dart';
import 'package:xpc_app/routing/app_router.dart';

class NextTrainingItem extends StatelessWidget {
  final NextTraining nextTraining;
  final int siteId;
  final int courseId;
  const NextTrainingItem(
      {super.key,
      required this.nextTraining,
      required this.siteId,
      required this.courseId});

  // TODO: implement statuses

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: GestureDetector(
        onTap: () {
          AutoRouter.of(context).push(SingleTrainingRoute(
            siteId: siteId,
            courseId: courseId,
            moduleId: nextTraining.parentId,
            trainingId: nextTraining.id,
          ));
        },
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(nextTraining.thumbnail)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    nextTraining.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text('Awaiting start'),
                  Text('${nextTraining.xp.toString()} XP'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
