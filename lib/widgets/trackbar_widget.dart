import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpc_app/store/single_course_state.dart';
import 'package:xpc_app/store/trackbar_state.dart';

class TrackbarWidget extends StatelessWidget {
  const TrackbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String xpLabel = 'XP';
    String xxpLabel = 'XXP';
    SingleCourseState courseState = context.watch<SingleCourseBloc>().state;
    if (courseState is SingleCourseLoaded) {
      xpLabel = courseState.course.xpLabel;
      xxpLabel = courseState.course.xxpLabel;
    }
    return BlocBuilder<TrackBarBloc, TrackBarState>(builder: (context, state) {
      final trackbar = state.trackbar;
      return Text(
          'Your total points: ${trackbar.earnedXp}/${trackbar.totalXp} $xpLabel | ${trackbar.earnedXxp}/${trackbar.totalXxp} $xxpLabel');
    });
  }
}
