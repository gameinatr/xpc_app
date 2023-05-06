import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpc_app/models/trackbar_model.dart';

class TrackBarBloc extends Bloc<TrackBarEvent, TrackBarState> {
  final Trackbar initialTrackbar =
      Trackbar(totalXp: 0, totalXxp: 0, earnedXp: 0, earnedXxp: 0);
  TrackBarBloc()
      : super(TrackBarState(
            trackbar:
                Trackbar(totalXp: 0, totalXxp: 0, earnedXp: 0, earnedXxp: 0))) {
    on<TrackBarUpdated>(((event, emit) async {
      try {
        emit(TrackBarState(trackbar: event.trackbar));
      } catch (err) {
        print('user err: $err');
        emit(TrackBarState(trackbar: initialTrackbar));
      }
    }));
  }
}

abstract class TrackBarEvent {}

class TrackBarState {
  final Trackbar trackbar;
  TrackBarState({required this.trackbar});
}

class TrackBarUpdated extends TrackBarEvent {
  final Trackbar trackbar;
  TrackBarUpdated({required this.trackbar});
}
