import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xpc_app/routing/app_router.dart';
import 'package:xpc_app/store/courses_state.dart';
import 'package:xpc_app/store/single_course_state.dart';
import 'package:xpc_app/store/single_training_state.dart';
import 'package:get_it/get_it.dart';
import 'package:xpc_app/store/site_state.dart';
import 'package:xpc_app/store/tokens_state.dart';
import 'package:xpc_app/store/trackbar_state.dart';
import 'package:xpc_app/store/student_user_state.dart';
import 'package:package_info_plus/package_info_plus.dart';

GetIt getIt = GetIt.instance;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  getIt.registerSingleton<AppRouter>(AppRouter());
  runApp(const XperiencifyApp());
}

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Your application version is obsolete.'),
                const Text('Please, update to the latest version'),
                const SizedBox(height: 16),
                ElevatedButton(
                    onPressed: () {
                      // TODO: add actual app address
                      launchUrl(Uri.parse('https://google.com'));
                    },
                    child: const Text('Update')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class XperiencifyApp extends StatefulWidget {
  const XperiencifyApp({super.key});

  @override
  State<XperiencifyApp> createState() => _XperiencifyAppState();
}

class _XperiencifyAppState extends State<XperiencifyApp> {
  final AppRouter appRouter = getIt<AppRouter>();
  bool isLatestVersion = false;
  Future<bool> compareVersions() async {
    final Dio initialDio = Dio();
    final PackageInfo package = await PackageInfo.fromPlatform();
    final latestVersion = await initialDio.get(
        'https://api.xperiencify.dev/api/v1/third-party/mobile-version-control/');
    return package.version == latestVersion.data['version'];
  }

  @override
  void didChangeDependencies() async {
    isLatestVersion = await compareVersions();
    setState(() {});
    FlutterNativeSplash.remove();
    super.didChangeDependencies();
  }

  final tokensBloc = TokensBloc();

  @override
  Widget build(BuildContext context) {
    if (!isLatestVersion) return const UpdateScreen();
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: tokensBloc),
        BlocProvider(create: (_) => SingleCourseBloc(tokensBloc: tokensBloc)),
        BlocProvider(create: (_) => SchoolSiteBloc(tokensBloc: tokensBloc)),
        BlocProvider(create: (_) => StudentUserBloc(tokensBloc: tokensBloc)),
        BlocProvider(create: (_) => CoursesBloc()),
        BlocProvider(
          create: (_) => SingleTrainingBloc(),
        ),
        BlocProvider(create: (_) => TrackBarBloc()),
      ],
      child: MaterialApp.router(
        title: "XPC App",
        routerConfig: appRouter.config(),
      ),
    );
  }
}
