import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpc_app/constants/styling.dart';
import 'package:xpc_app/models/trainings/next_training_model.dart';
import 'package:xpc_app/routing/app_router.dart';
import 'package:xpc_app/store/single_course_state.dart';
import 'package:xpc_app/widgets/next_training_status.dart';
import 'package:xpc_app/widgets/tokenized_html.dart';

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
    String xpLabel = 'XP';
    String xxpLabel = 'XXP';
    SingleCourseState courseState = context.watch<SingleCourseBloc>().state;
    if (courseState is SingleCourseLoaded) {
      xpLabel = courseState.course.xpLabel;
      xxpLabel = courseState.course.xxpLabel;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          AutoRouter.of(context).push(SingleTrainingRoute(
            siteId: siteId,
            courseId: courseId,
            moduleId: nextTraining.parentId,
            trainingId: nextTraining.id,
            trainingTitle: nextTraining.title,
          ));
        },
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 150,
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.network(
                          nextTraining.thumbnail,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ))),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nextTraining.title,
                            style: ThemeTextStyles.boldMediumSize,
                          ),
                          const SizedBox(height: 10),
                          NextTrainingStatus(
                              status: nextTraining.awaitingStatus),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        if (nextTraining.xp != null && nextTraining.xp! > 0)
                          TokenizedHtml(
                            htmlData: '${nextTraining.xp.toString()} $xpLabel',
                          ),
                        const SizedBox(width: 6),
                        if (nextTraining.xxp != null && nextTraining.xxp! > 0)
                          TokenizedHtml(
                            htmlData:
                                '${nextTraining.xxp.toString()} $xxpLabel',
                          ),
                      ],
                    ),
                    const SizedBox(height: 14),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
