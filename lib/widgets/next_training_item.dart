import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:xpc_app/constants/styling.dart';
import 'package:xpc_app/models/trainings/next_training_model.dart';
import 'package:xpc_app/routing/app_router.dart';
import 'package:xpc_app/widgets/next_training_status.dart';

class NextTrainingItem extends StatelessWidget {
  final NextTraining nextTraining;
  final int siteId;
  final int courseId;
  const NextTrainingItem(
      {super.key,
      required this.nextTraining,
      required this.siteId,
      required this.courseId});

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
            trainingTitle: nextTraining.title,
          ));
        },
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                    aspectRatio: 2 / 1,
                    child: Image.network(
                      nextTraining.thumbnail,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ))),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    nextTraining.title,
                    style: ThemeTextStyles.boldMediumSize,
                  ),
                  NextTrainingStatus(status: nextTraining.awaitingStatus),
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
