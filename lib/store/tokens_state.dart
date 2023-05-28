import 'package:flutter_bloc/flutter_bloc.dart';

class TokensBloc extends Bloc<TokensEvent, TokensState> {
  TokensBloc() : super(TokensState(tokens: {})) {
    on<TokensUpdate>(((event, emit) async {
      try {
        state.tokens.addAll(event.tokens);
        emit(TokensState(tokens: state.tokens));
      } catch (err) {
        emit(TokensState(tokens: state.tokens));
      }
    }));
  }
}

abstract class TokensEvent {}

class TokensUpdate extends TokensEvent {
  final Map<String, String> tokens;
  TokensUpdate({required this.tokens});
}

class TokensState {
  final Map<String, String> tokens;
  TokensState({required this.tokens});
}
