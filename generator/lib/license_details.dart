final class LicenseDetails {
  final String name;
  final Uri? websiteUrl;
  final Uri? badgeUrl;

  const LicenseDetails({
    required this.name,
    this.websiteUrl,
    this.badgeUrl,
  });

  factory LicenseDetails.fromJson(Map<String, dynamic> json) {
    return LicenseDetails(
      name: json['name'],
      websiteUrl:
          json['websiteUrl'] != null ? Uri.tryParse(json['websiteUrl']) : null,
      badgeUrl:
          json['badgeUrl'] != null ? Uri.tryParse(json['badgeUrl']) : null,
    );
  }

  static LicenseDetails unknown = LicenseDetails(
    name: 'unknown',
    websiteUrl: null,
    badgeUrl: Uri.tryParse(
      'https://img.shields.io/badge/license-unknown-blue.svg',
    ),
  );
}
