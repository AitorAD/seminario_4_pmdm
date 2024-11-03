import 'package:flutter/material.dart';
import 'package:seminario_4/widgets/scan_tiles.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScanTiles(tipo: 'http');
  }
}
