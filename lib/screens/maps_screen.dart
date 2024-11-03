import 'package:flutter/material.dart';
import 'package:seminario_4/widgets/scan_tiles.dart';

class MapsScreen extends StatelessWidget {
  const MapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScanTiles(tipo: 'geo');
  }
}
