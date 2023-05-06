import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:xpc_app/store/single_course_state.dart';
import 'package:xpc_app/store/single_training_state.dart';
import 'package:xpc_app/store/user_state.dart';
import 'package:xpc_app/utils/index.dart';

class TokenizedHtml extends StatefulWidget {
  final String htmlData;
  const TokenizedHtml({super.key, required this.htmlData});

  @override
  State<TokenizedHtml> createState() => _TokenizedHtmlState();
}

// TODO: add custom fields

class _TokenizedHtmlState extends State<TokenizedHtml> {
  @override
  Widget build(BuildContext context) {
    SingleCourseState courseState = context.watch<SingleCourseBloc>().state;
    SingleTrainingState trainingState =
        context.watch<SingleTrainingBloc>().state;
    UserState userState = context.watch<UserBloc>().state;
    print(userState);
    Map<String, String> tokensMap = {};
    if (courseState is SingleCourseLoaded) {
      tokensMap.addAll({'{Course Name}': courseState.course.title});
      print(tokensMap);
    }
    if (trainingState is SingleTrainingLoaded) {
      tokensMap.addAll({'{Training Name}': trainingState.training.title});
      print(tokensMap);
    }
    if (userState is UserLoaded) {
      tokensMap.addAll({'{First Name}': userState.user.firstName, '{Last Name}': userState.user.lastName,});
      print(tokensMap); 
    }
    return Html(data: replaceTokens(widget.htmlData, tokensMap));
  }
}
