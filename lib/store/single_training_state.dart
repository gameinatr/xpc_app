import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpc_app/models/trainings/single_training_model.dart';
import 'package:xpc_app/providers/single_training_provider.dart';

class SingleTrainingBloc
    extends Bloc<SingleTrainingEvent, SingleTrainingState> {
  final _trainingProvider = SingleTrainingProvider();
  SingleTrainingBloc() : super(SingleTrainingInitial()) {
    on<SingleTrainingLoadEvent>(((event, emit) async {
      emit(SingleTrainingLoading());
      try {
        final training = await _trainingProvider.getSingleTraining(
            event.siteId, event.courseId, event.moduleId, event.trainingId);
        emit(SingleTrainingLoaded(training: training));
      } catch (err) {
        print(err.toString());
        emit(SingleTrainingLoadFailed(errorText: err.toString()));
      }
    }));
  }
}

abstract class SingleTrainingEvent {}

class SingleTrainingLoadEvent extends SingleTrainingEvent {
  final int siteId;
  final int courseId;
  final int moduleId;
  final int trainingId;
  SingleTrainingLoadEvent(
      {required this.siteId,
      required this.courseId,
      required this.moduleId,
      required this.trainingId});
}

abstract class SingleTrainingState {}

class SingleTrainingInitial extends SingleTrainingState {}

class SingleTrainingLoading extends SingleTrainingState {}

class SingleTrainingLoaded extends SingleTrainingState {
  final SingleTraining training;
  SingleTrainingLoaded({required this.training});
}

class SingleTrainingLoadFailed extends SingleTrainingState {
  final String errorText;
  SingleTrainingLoadFailed({required this.errorText});
}
