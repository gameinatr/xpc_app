import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:xpc_app/store/single_course_state.dart';
import 'package:xpc_app/store/site_state.dart';
import 'package:xpc_app/store/student_user_state.dart';
import 'package:xpc_app/utils/index.dart';
import 'package:url_launcher/url_launcher.dart';

class TokenizedHtml extends StatefulWidget {
  final String htmlData;
  final Map<String, Style>? styles;
  const TokenizedHtml({super.key, required this.htmlData, this.styles});

  @override
  State<TokenizedHtml> createState() => _TokenizedHtmlState();
}

class _TokenizedHtmlState extends State<TokenizedHtml> {
  @override
  Widget build(BuildContext context) {
    SingleCourseState courseState = context.watch<SingleCourseBloc>().state;
    StudentUserState studentState = context.watch<StudentUserBloc>().state;
    SiteState siteState = context.watch<SchoolSiteBloc>().state;
    Map<String, String> tokensMap = {};
    if (courseState is SingleCourseLoaded) {
      tokensMap.addAll({
        '{Course Name}': courseState.course.title,
        '{Course ID}': courseState.course.id.toString(),
      });
    }
    if (studentState is StudentUserLoaded) {
      tokensMap.addAll({
        '{First Name}': studentState.student.firstName,
        '{Last Name}': studentState.student.lastName,
        '{Email}': studentState.student.email,
        '{Magic ID}': studentState.student.magicToken,
        '{Student ID}': studentState.student.id.toString(),
      });
      if (studentState.student.studentCustomFields != null) {
        studentState.student.studentCustomFields!.forEach((field) {
          tokensMap.addAll({'{${field.title}}': field.value ?? ''});
        });
      }
    }
    if (siteState is SiteLoaded) {
      tokensMap.addAll({
        '{Your First Name}': siteState.site.user.firstName,
        '{Your Last Name}': siteState.site.user.lastName,
        '{School/Co. Name}': siteState.site.school,
      });
    }
    return Html(
      data: replaceTokens(widget.htmlData, tokensMap),
      onLinkTap: (url, context, attributes, element) async {
        final Uri parsedUrl = Uri.parse(url ?? '');
        if (await canLaunchUrl(parsedUrl)) launchUrl(parsedUrl);
      },
      style: widget.styles ?? {'div': Style(fontSize: FontSize(16))},
    );
  }
}
