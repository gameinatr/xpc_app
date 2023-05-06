import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpc_app/store/single_course_state.dart';
import 'package:xpc_app/store/trackbar_state.dart';
import 'package:xpc_app/store/user_state.dart';
import 'package:xpc_app/widgets/next_training_item.dart';

// const String videoUrl =
//     'https://cdn-dev.xperiencify.com/users/27392/trainings/48954/1669703616821__transcode/playlist.m3u8';
// //'https://youtu.be/G8nNGk6LHaM';

@RoutePage()
class CourseHomeScreen extends StatefulWidget {
  final int courseId;
  final String courseLink;
  const CourseHomeScreen(
      {super.key, required this.courseId, required this.courseLink});

  @override
  State<CourseHomeScreen> createState() => _CourseHomeScreenState();
}

class _CourseHomeScreenState extends State<CourseHomeScreen> {
  final List<String> pages = ['Home', 'All Trainings'];

  @override
  void didChangeDependencies() {
    final SingleCourseBloc singleCourseBloc =
        BlocProvider.of<SingleCourseBloc>(context);
    singleCourseBloc.add(SingleCourseLoadEvent(
        courseId: widget.courseId, courseLink: widget.courseLink));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Home'),
      ),
      endDrawer: Drawer(
        child: ListView.builder(
            itemCount: pages.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  pages[index],
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
              );
            }),
      ),
      body: BlocBuilder<SingleCourseBloc, SingleCourseState>(
        builder: (context, state) {
          if (state is SingleCourseLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SingleCourseLoaded) {
            final UserBloc userBloc = BlocProvider.of<UserBloc>(context);
            userBloc.add(UserLoadEvent(siteId: (state.course.siteId)));
            // stack is introduced to possibly add invokable trackbar later
            return Stack(children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Text(state.course.title),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.course.nextTrainings.length,
                      itemBuilder: (context, index) {
                        return NextTrainingItem(
                            nextTraining: state.course.nextTrainings[index],
                            siteId: state.course.siteId,
                            courseId: state.course.id);
                      },
                    ),
                    BlocBuilder<TrackBarBloc, TrackBarState>(
                      builder: (context, state) {
                        return Text(state.trackbar.earnedXp.toString());
                      },
                    ),
                  ],
                ),
              ),
            ]);
          }
          if (state is SingleCourseLoadFailed) {
            return Center(
              child: Text(state.errorText),
            );
          }
          return const SizedBox(height: 10);
        },
      ),
    );
  }
}
