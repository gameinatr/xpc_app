import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpc_app/models/users/student_user_model.dart';
import 'package:xpc_app/providers/student_provider.dart';
import 'package:xpc_app/store/tokens_state.dart';

class StudentUserBloc extends Bloc<UserEvent, StudentUserState> {
  final _userProvider = UserProvider();
  final TokensBloc _tokensBloc;
  StudentUserBloc({required TokensBloc tokensBloc})
      : _tokensBloc = tokensBloc,
        super(StudentUserInitial()) {
    on<UserLoadEvent>(((event, emit) async {
      try {
        final user = await _userProvider.getUser(event.siteId);
        emit(StudentUserLoaded(student: user));
        _tokensBloc.add(TokensUpdate(tokens: {
          '{First Name}': user.firstName,
          '{Last Name}': user.lastName,
          '{Email}': user.email,
          '{Magic ID}': user.magicToken,
          '{Student ID}': user.id.toString(),
        }));
        if (user.studentCustomFields != null) {
          user.studentCustomFields!.forEach((field) {
            _tokensBloc.add(
                TokensUpdate(tokens: {'{${field.title}}': field.value ?? ''}));
          });
        }
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
