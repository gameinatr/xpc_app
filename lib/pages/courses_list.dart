import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpc_app/store/courses_state.dart';
import 'package:xpc_app/widgets/course_list_item.dart';

@RoutePage()
class CoursesListScreen extends StatefulWidget {
  CoursesListScreen({super.key});

  @override
  State<CoursesListScreen> createState() => _CoursesListScreenState();
}

class _CoursesListScreenState extends State<CoursesListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CoursesBloc()..add(CoursesLoadEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Select Course',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Color(0xfffffbeb),
          centerTitle: true,
        ),
        body: BlocBuilder<CoursesBloc, CoursesState>(builder: (context, state) {
          if (state is CoursesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CoursesLoaded) {
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.courses.length,
              itemBuilder: (context, index) => CourseListItem(
                courseItem: state.courses[index],
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 16),
            );
          }
          return const SizedBox(height: 20);
        }),
      ),
    );
  }
}
