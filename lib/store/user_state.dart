import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpc_app/models/users/user_model.dart';
import 'package:xpc_app/providers/user_provider.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final _userProvider = UserProvider();
  UserBloc() : super(UserInitial()) {
    on<UserLoadEvent>(((event, emit) async {
      try {
        print('try');
        final user = await _userProvider.getUser(event.siteId);
        print('user get: $user');
        emit(UserLoaded(user: user));
      } catch (err) {
        print('user err: $err');
        emit(UserLoadFailed(errorText: err.toString()));
      }
    }));
  }
}

abstract class UserEvent {}

class UserLoadEvent extends UserEvent {
  final int siteId;
  UserLoadEvent({required this.siteId});
}

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoaded extends UserState {
  final User user;
  UserLoaded({required this.user});
}

class UserLoadFailed extends UserState {
  final String errorText;
  UserLoadFailed({required this.errorText});
}
