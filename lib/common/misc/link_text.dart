import 'package:dio_hub/style/border_radiuses.dart';
import 'package:dio_hub/utils/link_handler.dart';
import 'package:flutter/material.dart';

class LinkText extends StatelessWidget {
  final TextStyle? style;
  final String? text;
  final String link;
  const LinkText(this.link, {this.style, Key? key, this.text})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: AppThemeBorderRadius.smallBorderRadius,
        onTap: () {
          linkHandler(context, link);
        },
        onLongPress: () {
          linkHandler(context, link, showSheetOnDeepLink: true);
        },
        child: Text(
          text ?? link,
          style: (style ?? const TextStyle()).copyWith(color: Colors.blue),
        ),
      ),
    );
  }
}
