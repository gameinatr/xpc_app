import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpc_app/store/trackbar_state.dart';

class TrackbarWidget extends StatelessWidget {
  const TrackbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackBarBloc, TrackBarState>(builder: (context, state) {
      final trackbar = state.trackbar;
      return Text(
          'Your total points: ${trackbar.earnedXp}/${trackbar.totalXp} XP | ${trackbar.earnedXxp}/${trackbar.totalXxp} XXP');
    });
  }
}
