import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ismailmagdy/core/constants/app_strings.dart';

///
FaIconData getIconForPlatform(String platform) {
  switch (platform.toLowerCase()) {
    case AppStrings.linkedin:
      return FontAwesomeIcons.linkedin;
    case AppStrings.githubText:
      return FontAwesomeIcons.github;
    case AppStrings.twitter:
      return FontAwesomeIcons.twitter;
    case AppStrings.instagram:
      return FontAwesomeIcons.instagram;
    default:
      return FontAwesomeIcons.link;
  }
}
