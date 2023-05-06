import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpc_app/routing/app_router.dart';
import 'package:xpc_app/store/courses_state.dart';
import 'package:xpc_app/store/single_course_state.dart';
import 'package:xpc_app/store/single_training_state.dart';
import 'package:get_it/get_it.dart';
import 'package:xpc_app/store/trackbar_state.dart';
import 'package:xpc_app/store/user_state.dart';

GetIt getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<AppRouter>(AppRouter());
  runApp(XperiencifyApp());
}

class XperiencifyApp extends StatefulWidget {
  const XperiencifyApp({super.key});

  @override
  State<XperiencifyApp> createState() => _XperiencifyAppState();
}

class _XperiencifyAppState extends State<XperiencifyApp> {
  final AppRouter appRouter = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SingleCourseBloc()),
        BlocProvider(
          create: (_) => SingleTrainingBloc(),
        ),
        BlocProvider(create: (_) => UserBloc()),
        BlocProvider(create: (_) => TrackBarBloc())
      ],
      child: MaterialApp.router(
        title: "XPC App",
        routerConfig: appRouter.config(),
      ),
    );
  }
}
