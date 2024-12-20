import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seminario_4/providers/scan_list_provider.dart';
import 'package:seminario_4/providers/ui_provider.dart';
import 'package:seminario_4/providers/db_provider.dart';
import 'package:seminario_4/screens/addresses_screen.dart';
import 'package:seminario_4/screens/maps_screen.dart';
import 'package:seminario_4/widgets/scan_button.dart';
import 'package:seminario_4/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DBProvider.db.database;

    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<ScanListProvider>(context, listen: false)
                    .deleteAll();
              },
              icon: Icon(Icons.delete_forever))
        ],
      ),
      body: _HomeScreenBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ScanButton()),
          );
        },
        child: Icon(Icons.filter_center_focus, color: Colors.white),
        backgroundColor:
            Theme.of(context).floatingActionButtonTheme.backgroundColor,
        elevation: 0,
      ),
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;
    switch (currentIndex) {
      case 0:
        scanListProvider.loadScanByType('geo');
        return MapsScreen();
      case 1:
        scanListProvider.loadScanByType('http');
        return AddressesScreen();
      default:
        scanListProvider.loadScanByType('geo');
        return MapsScreen();
    }
  }
}
