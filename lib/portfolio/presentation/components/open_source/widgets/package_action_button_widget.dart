import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ismailmagdy/portfolio/models/packages/package_model.dart';
import 'package:ismailmagdy/portfolio/presentation/components/open_source/components/package_action_button.dart';
import 'package:url_launcher/url_launcher.dart';

class PackageActionButtonWidget extends StatelessWidget {
  const PackageActionButtonWidget({
    super.key,
    required this.isBlueprint,
    required this.package,
  });
  final bool isBlueprint;
  final PackageModel package;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        PackageActionButton(
          icon: FontAwesomeIcons.arrowUpRightFromSquare,
          label: "pub.dev",
          onTap: () => _launchUrl(package.pubDevUrl),
          isPrimary: true,
          isBlueprint: isBlueprint,
        ),
        PackageActionButton(
          icon: FontAwesomeIcons.github,
          label: "GitHub",
          onTap: () => _launchUrl(package.githubUrl),
          isPrimary: false,
          isBlueprint: isBlueprint,
        ),
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: .externalApplication);
    }
  }
}
