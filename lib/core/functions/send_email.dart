import 'package:url_launcher/url_launcher.dart';

class EmailHandler {
  static void sendEmails(
    String? coverSheet,
    String? emailSubject,
    String? companyEmail,
  ) async {
    final rawBody = coverSheet!
        // normalize line endings
        .replaceAll('\r\n', '\n')
        .replaceAll('\n', '\r\n')
        // drop any **…** pairs
        .replaceAllMapped(RegExp(r'\*\*(.*?)\*\*'), (m) => m.group(1)!);

    final mailtoUri = Uri.parse('mailto:$companyEmail'
        '?subject=${Uri.encodeComponent(emailSubject!)}'
        '&body=${Uri.encodeComponent(rawBody)}');

    await launchUrl(mailtoUri);
  }
}
