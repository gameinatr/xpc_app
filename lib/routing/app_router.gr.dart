// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    SingleTrainingRoute.name: (routeData) {
      final args = routeData.argsAs<SingleTrainingRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SingleTrainingPage(
          key: args.key,
          siteId: args.siteId,
          courseId: args.courseId,
          moduleId: args.moduleId,
          trainingId: args.trainingId,
          trainingTitle: args.trainingTitle,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginPage(),
      );
    },
    CoursesListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CoursesListScreen(),
      );
    },
    CourseHomeRoute.name: (routeData) {
      final args = routeData.argsAs<CourseHomeRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CourseHomeScreen(
          key: args.key,
          courseId: args.courseId,
          courseLink: args.courseLink,
          courseTitle: args.courseTitle,
        ),
      );
    },
  };
}

/// generated route for
/// [SingleTrainingPage]
class SingleTrainingRoute extends PageRouteInfo<SingleTrainingRouteArgs> {
  SingleTrainingRoute({
    Key? key,
    required int siteId,
    required int courseId,
    required int moduleId,
    required int trainingId,
    required String trainingTitle,
    List<PageRouteInfo>? children,
  }) : super(
          SingleTrainingRoute.name,
          args: SingleTrainingRouteArgs(
            key: key,
            siteId: siteId,
            courseId: courseId,
            moduleId: moduleId,
            trainingId: trainingId,
            trainingTitle: trainingTitle,
          ),
          initialChildren: children,
        );

  static const String name = 'SingleTrainingRoute';

  static const PageInfo<SingleTrainingRouteArgs> page =
      PageInfo<SingleTrainingRouteArgs>(name);
}

class SingleTrainingRouteArgs {
  const SingleTrainingRouteArgs({
    this.key,
    required this.siteId,
    required this.courseId,
    required this.moduleId,
    required this.trainingId,
    required this.trainingTitle,
  });

  final Key? key;

  final int siteId;

  final int courseId;

  final int moduleId;

  final int trainingId;

  final String trainingTitle;

  @override
  String toString() {
    return 'SingleTrainingRouteArgs{key: $key, siteId: $siteId, courseId: $courseId, moduleId: $moduleId, trainingId: $trainingId, trainingTitle: $trainingTitle}';
  }
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CoursesListScreen]
class CoursesListRoute extends PageRouteInfo<void> {
  const CoursesListRoute({List<PageRouteInfo>? children})
      : super(
          CoursesListRoute.name,
          initialChildren: children,
        );

  static const String name = 'CoursesListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CourseHomeScreen]
class CourseHomeRoute extends PageRouteInfo<CourseHomeRouteArgs> {
  CourseHomeRoute({
    Key? key,
    required int courseId,
    required String courseLink,
    required String courseTitle,
    List<PageRouteInfo>? children,
  }) : super(
          CourseHomeRoute.name,
          args: CourseHomeRouteArgs(
            key: key,
            courseId: courseId,
            courseLink: courseLink,
            courseTitle: courseTitle,
          ),
          initialChildren: children,
        );

  static const String name = 'CourseHomeRoute';

  static const PageInfo<CourseHomeRouteArgs> page =
      PageInfo<CourseHomeRouteArgs>(name);
}

class CourseHomeRouteArgs {
  const CourseHomeRouteArgs({
    this.key,
    required this.courseId,
    required this.courseLink,
    required this.courseTitle,
  });

  final Key? key;

  final int courseId;

  final String courseLink;

  final String courseTitle;

  @override
  String toString() {
    return 'CourseHomeRouteArgs{key: $key, courseId: $courseId, courseLink: $courseLink, courseTitle: $courseTitle}';
  }
}
