import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpc_app/models/site/site_model.dart';
import 'package:xpc_app/providers/site_provider.dart';

class SchoolSiteBloc extends Bloc<SiteEvent, SiteState> {
  final _siteProvider = SiteProvider();
  SchoolSiteBloc() : super(StudentUserInitial()) {
    on<SiteLoadEvent>(((event, emit) async {
      try {
        final site = await _siteProvider.getSite(event.siteId);
        emit(SiteLoaded(site: site));
      } catch (err) {
        emit(SiteLoadFailed(errorText: err.toString()));
      }
    }));
  }
}

abstract class SiteEvent {}

class SiteLoadEvent extends SiteEvent {
  final int siteId;
  SiteLoadEvent({required this.siteId});
}

abstract class SiteState {}

class StudentUserInitial extends SiteState {}

class SiteLoaded extends SiteState {
  final SchoolSite site;
  SiteLoaded({required this.site});
}

class SiteLoadFailed extends SiteState {
  final String errorText;
  SiteLoadFailed({required this.errorText});
}
