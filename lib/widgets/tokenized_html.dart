import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:xpc_app/store/tokens_state.dart';
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
    return BlocBuilder<TokensBloc, TokensState>(builder: (context, state) {
      return Html(
        shrinkWrap: true,
        data: replaceTokens(widget.htmlData, state.tokens),
        onLinkTap: (url, context, attributes, element) async {
          final Uri parsedUrl = Uri.parse(url ?? '');
          if (await canLaunchUrl(parsedUrl)) launchUrl(parsedUrl);
        },
        style: widget.styles ?? {'div': Style(fontSize: FontSize(16))},
      );
    });
  }
}
