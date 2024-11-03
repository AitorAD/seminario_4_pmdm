import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/scan_model.dart';

Future<void> launchURL(BuildContext context, ScanModel scan) async {
  if (scan.tipo == 'http') {
    final url = Uri.parse(scan.valor);
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    Navigator.pushNamed(context, 'map', arguments: scan);
  }
}
