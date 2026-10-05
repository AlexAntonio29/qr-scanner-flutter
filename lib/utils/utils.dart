import 'package:flutter/material.dart';
import 'package:qr_scanner/models/scan_models.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> getlaunchUrl(BuildContext context, ScanModel scan) async {
  if (scan.tipo == "http") {
    print(scan.valor);
    if (!await launchUrl(Uri.parse(scan.valor))) {
      throw Exception('Could not launch ${scan.valor}');
    }
  } else {
    Navigator.pushNamed(context, "mapa_page", arguments: scan);
  }
}
