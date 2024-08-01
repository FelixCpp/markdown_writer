import 'package:generator/license_details.dart';
import 'package:test/test.dart';

void main() {
  group('LicenseDetails.fromJson', () {
    test('should construct object from json', () {
      final json = {
        'name': 'MIT',
        'websiteUrl': 'https://opensource.org/licenses/MIT',
        'badgeUrl': 'https://img.shields.io/badge/license-MIT-blue.svg',
      };

      final licenseDetails = LicenseDetails.fromJson(json);

      expect(licenseDetails.name, 'MIT');

      expect(
        licenseDetails.websiteUrl,
        Uri.parse('https://opensource.org/licenses/MIT'),
      );

      expect(
        licenseDetails.badgeUrl,
        Uri.parse('https://img.shields.io/badge/license-MIT-blue.svg'),
      );
    });

    test('should construct object with nullable urls from json', () {
      final json = {
        'name': 'unknown',
        'websiteUrl': null,
        'badgeUrl': null,
      };

      final licenseDetails = LicenseDetails.fromJson(json);

      expect(licenseDetails.name, 'unknown');
      expect(licenseDetails.websiteUrl, null);
      expect(licenseDetails.badgeUrl, null);
    });

    test('should construct object with nullable urls from invalid json', () {
      final json = {
        'name': 'unknown',
      };

      final licenseDetails = LicenseDetails.fromJson(json);

      expect(licenseDetails.name, 'unknown');
      expect(licenseDetails.websiteUrl, null);
      expect(licenseDetails.badgeUrl, null);
    });

    test('should construct object from json with invalid urls', () {
      final json = {
        'name': 'MIT',
        'websiteUrl': '::Not-Valid-URL::',
        'badgeUrl': '::Not-Valid-URL::',
      };

      final licenseDetails = LicenseDetails.fromJson(json);

      expect(licenseDetails.name, 'MIT');
      expect(licenseDetails.websiteUrl, null);
      expect(licenseDetails.badgeUrl, null);
    });
  });
}
