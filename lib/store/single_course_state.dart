import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpc_app/models/courses/single_course_item_model.dart';
import 'package:xpc_app/providers/single_course_provider.dart';

class SingleCourseBloc extends Bloc<SingleCourseEvent, SingleCourseState> {
  final _courseProvider = SingleCourseProvider();
  SingleCourseBloc() : super(SingleCourseInitial()) {
    on<SingleCourseLoadEvent>(((event, emit) async {
      emit(SingleCourseLoading());
      try {
        final course = await _courseProvider.getSingleCourse(
            event.courseId, event.courseLink);
        emit(SingleCourseLoaded(course: course));
      } catch (err) {
        emit(SingleCourseLoadFailed(errorText: err.toString()));
      }
    }));
  }
}

abstract class SingleCourseEvent {}

class SingleCourseLoadEvent extends SingleCourseEvent {
  final int courseId;
  final String courseLink;
  SingleCourseLoadEvent({required this.courseId, required this.courseLink});
}

abstract class SingleCourseState {}

class SingleCourseInitial extends SingleCourseState {}

class SingleCourseLoading extends SingleCourseState {}

class SingleCourseLoaded extends SingleCourseState {
  final SingleCourse course;
  SingleCourseLoaded({required this.course});
}

class SingleCourseLoadFailed extends SingleCourseState {
  final String errorText;
  SingleCourseLoadFailed({required this.errorText});
}
