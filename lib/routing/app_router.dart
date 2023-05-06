import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:xpc_app/pages/course_home.dart';
import 'package:xpc_app/pages/courses_list.dart';
import 'package:xpc_app/pages/login.dart';
import 'package:xpc_app/pages/single_training.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: CoursesListRoute.page),
        AutoRoute(page: LoginRoute.page, path: '/'),
        AutoRoute(page: CourseHomeRoute.page),
        AutoRoute(page: SingleTrainingRoute.page),
      ];
}
