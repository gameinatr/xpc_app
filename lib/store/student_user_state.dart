import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpc_app/models/users/student_user_model.dart';
import 'package:xpc_app/providers/student_provider.dart';

class StudentUserBloc extends Bloc<UserEvent, StudentUserState> {
  final _userProvider = UserProvider();
  StudentUserBloc() : super(StudentUserInitial()) {
    on<UserLoadEvent>(((event, emit) async {
      try {
        final user = await _userProvider.getUser(event.siteId);
        emit(StudentUserLoaded(student: user));
      } catch (err) {
        emit(StudentUserLoadFailed(errorText: err.toString()));
      }
    }));
  }
}

abstract class UserEvent {}

class UserLoadEvent extends UserEvent {
  final int siteId;
  UserLoadEvent({required this.siteId});
}

abstract class StudentUserState {}

class StudentUserInitial extends StudentUserState {}

class StudentUserLoaded extends StudentUserState {
  final StudentUser student;
  StudentUserLoaded({required this.student});
}

class StudentUserLoadFailed extends StudentUserState {
  final String errorText;
  StudentUserLoadFailed({required this.errorText});
}
