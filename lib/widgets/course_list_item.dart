import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:xpc_app/models/courses/login_course_model.dart';
import 'package:xpc_app/routing/app_router.dart';

class CourseListItem extends StatelessWidget {
  final LoginCourseItem courseItem;
  const CourseListItem({super.key, required this.courseItem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AutoRouter.of(context).push(CourseHomeRoute(
            courseId: courseItem.id, courseLink: courseItem.link));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
                radius: 30, backgroundImage: NetworkImage(courseItem.poster)),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  courseItem.title,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 24 / 16),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      '${courseItem.moduleCount} modules',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '${courseItem.progress}% completed',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff9fa6b2)),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
