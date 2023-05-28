import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpc_app/models/site/site_model.dart';
import 'package:xpc_app/providers/site_provider.dart';
import 'package:xpc_app/store/tokens_state.dart';

class SchoolSiteBloc extends Bloc<SiteEvent, SiteState> {
  final _siteProvider = SiteProvider();
  final TokensBloc _tokensBloc;
  SchoolSiteBloc({required TokensBloc tokensBloc})
      : _tokensBloc = tokensBloc,
        super(StudentUserInitial()) {
    on<SiteLoadEvent>(((event, emit) async {
      try {
        final site = await _siteProvider.getSite(event.siteId);
        emit(SiteLoaded(site: site));
        _tokensBloc.add(TokensUpdate(tokens: {
          '{Your First Name}': site.user.firstName,
          '{Your Last Name}': site.user.lastName,
          '{School/Co. Name}': site.school,
        }));
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
