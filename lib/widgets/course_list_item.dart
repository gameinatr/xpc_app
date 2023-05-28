import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:xpc_app/constants/styling.dart';
import 'package:xpc_app/models/courses/login_course_model.dart';
import 'package:xpc_app/routing/app_router.dart';

class CourseListItem extends StatelessWidget {
  final LoginCourseItem courseItem;
  const CourseListItem({super.key, required this.courseItem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        AutoRouter.of(context).push(CourseHomeRoute(
            courseId: courseItem.id,
            courseLink: courseItem.link,
            courseTitle: courseItem.title));
      },
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                  radius: 30, backgroundImage: NetworkImage(courseItem.poster)),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    courseItem.title,
                    style: ThemeTextStyles.semiBoldMediumSize,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        '${courseItem.moduleCount} modules',
                        style: ThemeTextStyles.boldSmallSize,
                      ),
                      const SizedBox(width: 10),
                      Text('${courseItem.progress}% completed',
                          style: ThemeTextStyles.courseCardProgress)
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
