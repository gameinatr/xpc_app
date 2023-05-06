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
      final args = routeData.argsAs<CoursesListRouteArgs>(
          orElse: () => const CoursesListRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CoursesListScreen(key: args.key),
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
    List<PageRouteInfo>? children,
  }) : super(
          SingleTrainingRoute.name,
          args: SingleTrainingRouteArgs(
            key: key,
            siteId: siteId,
            courseId: courseId,
            moduleId: moduleId,
            trainingId: trainingId,
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
  });

  final Key? key;

  final int siteId;

  final int courseId;

  final int moduleId;

  final int trainingId;

  @override
  String toString() {
    return 'SingleTrainingRouteArgs{key: $key, siteId: $siteId, courseId: $courseId, moduleId: $moduleId, trainingId: $trainingId}';
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
class CoursesListRoute extends PageRouteInfo<CoursesListRouteArgs> {
  CoursesListRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          CoursesListRoute.name,
          args: CoursesListRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'CoursesListRoute';

  static const PageInfo<CoursesListRouteArgs> page =
      PageInfo<CoursesListRouteArgs>(name);
}

class CoursesListRouteArgs {
  const CoursesListRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'CoursesListRouteArgs{key: $key}';
  }
}

/// generated route for
/// [CourseHomeScreen]
class CourseHomeRoute extends PageRouteInfo<CourseHomeRouteArgs> {
  CourseHomeRoute({
    Key? key,
    required int courseId,
    required String courseLink,
    List<PageRouteInfo>? children,
  }) : super(
          CourseHomeRoute.name,
          args: CourseHomeRouteArgs(
            key: key,
            courseId: courseId,
            courseLink: courseLink,
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
  });

  final Key? key;

  final int courseId;

  final String courseLink;

  @override
  String toString() {
    return 'CourseHomeRouteArgs{key: $key, courseId: $courseId, courseLink: $courseLink}';
  }
}
