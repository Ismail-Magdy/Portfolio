import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

/// Get Icon
FaIconData getIconForPlatform(String platform) {
  switch (platform.toLowerCase()) {
    case "linkedin":
      return FontAwesomeIcons.linkedin;
    case "github":
      return FontAwesomeIcons.github;
    case "twitter":
      return FontAwesomeIcons.twitter;
    case "instagram":
      return FontAwesomeIcons.instagram;
    default:
      return FontAwesomeIcons.link;
  }
}

/// Download CV
Future<void> downloadCV() async {
  final Uri cvUrl = Uri.parse(
    "https://drive.google.com/file/d/1hgPnLinxGSvXMkWmJbZ4IzagzBHxovPy/view?usp=sharing",
  );
  if (await canLaunchUrl(cvUrl)) {
    await launchUrl(cvUrl, webOnlyWindowName: "_blank");
  }
}

/// Social
Future<void> launchSocial(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: .externalApplication);
  }
}

/// WhatsApp
Future<void> contactWhatsApp() async {
  final url = Uri.parse("https://wa.me/201206607906");
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: .externalApplication);
  }
}
