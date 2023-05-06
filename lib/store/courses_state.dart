import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpc_app/models/courses/login_course_model.dart';
import 'package:xpc_app/providers/courses_provider.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  final _coursesProvider = CoursesProvider();
  CoursesBloc() : super(CoursesInitial()) {
    on<CoursesLoadEvent>(((event, emit) async {
      emit(CoursesLoading());
      try {
        final courses = await _coursesProvider.getAllCourses();
        emit(CoursesLoaded(courses: courses));
      } catch (err) {
        emit(CoursesFailed(errorText: err.toString()));
      }
    }));
  }
}

abstract class CoursesEvent {}

class CoursesLoadEvent extends CoursesEvent {}

abstract class CoursesState {}

class CoursesInitial extends CoursesState {}

class CoursesLoading extends CoursesState {}

class CoursesLoaded extends CoursesState {
  final List<LoginCourseItem> courses;
  CoursesLoaded({required this.courses});
}

class CoursesFailed extends CoursesState {
  final String errorText;
  CoursesFailed({required this.errorText});
}
