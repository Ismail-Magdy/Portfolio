class PackageModel {
  final String title;
  final String shortDescription;
  final String imageOut;
  final String imageIn;
  final String pubDevUrl;
  final String githubUrl;
  final List<String> features;
  final String installation;
  final String usage;

  PackageModel({
    required this.title,
    required this.shortDescription,
    required this.imageOut,
    required this.imageIn,
    required this.pubDevUrl,
    required this.githubUrl,
    required this.features,
    required this.installation,
    required this.usage,
  });
}
