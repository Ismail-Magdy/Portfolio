import 'package:ismailmagdy/portfolio/models/social_link_model.dart';

class SocialLinksRepository {
  List<SocialLinkModel> getSocialLinks() {
    return [
      SocialLinkModel(
        id: "1",
        platform: "LinkedIn",
        url: "https://www.linkedin.com/in/ismailmagdy021",
        icon: "linkedin",
      ),
      SocialLinkModel(
        id: "2",
        platform: "GitHub",
        url: "https://github.com/Ismail-Magdy",
        icon: "github",
      ),
      SocialLinkModel(
        id: "3",
        platform: "Twitter",
        url: "https://x.com/ismailmagdy25",
        icon: "twitter",
      ),
      SocialLinkModel(
        id: "4",
        platform: "Instagram",
        url:
            "https://www.instagram.com/_ismail_magdy?igsh=MW8xajJvbTN5cjcwdQ==",
        icon: "instagram",
      ),
    ];
  }
}
