import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpc_app/constants/styling.dart';
import 'package:xpc_app/store/single_course_state.dart';
import 'package:xpc_app/store/site_state.dart';
import 'package:xpc_app/store/student_user_state.dart';
import 'package:xpc_app/widgets/next_training_item.dart';
import 'package:xpc_app/widgets/tokenized_html.dart';
import 'package:xpc_app/widgets/video_player_widget.dart';

@RoutePage()
class CourseHomeScreen extends StatefulWidget {
  final int courseId;
  final String courseLink;
  final String courseTitle;
  const CourseHomeScreen(
      {super.key,
      required this.courseId,
      required this.courseLink,
      required this.courseTitle});

  @override
  State<CourseHomeScreen> createState() => _CourseHomeScreenState();
}

class _CourseHomeScreenState extends State<CourseHomeScreen> {
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
        title: Text(widget.courseTitle),
        backgroundColor: const Color(0xff5ce0aa),
      ),
      body: BlocBuilder<SingleCourseBloc, SingleCourseState>(
        builder: (context, state) {
          if (state is SingleCourseLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SingleCourseLoaded) {
            print(state.course.videoLink);
            final StudentUserBloc userBloc =
                BlocProvider.of<StudentUserBloc>(context);
            final SchoolSiteBloc siteBloc =
                BlocProvider.of<SchoolSiteBloc>(context);
            userBloc.add(UserLoadEvent(siteId: state.course.siteId));
            siteBloc.add(SiteLoadEvent(siteId: state.course.siteId));
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
              child: Column(
                children: [
                  if (state.course.videoLink != '')
                    VideoPlayerWidget(videoUrl: state.course.videoLink),
                  const SizedBox(height: 15),
                  TokenizedHtml(htmlData: state.course.description),
                  const SizedBox(height: 15),
                  const Text('Next Up Trainings',
                      style: ThemeTextStyles.headline),
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
                ],
              ),
            );
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
