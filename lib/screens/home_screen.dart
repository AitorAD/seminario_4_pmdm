import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seminario_4/providers/ui_provider.dart';
import 'package:seminario_4/screens/addresses_screen.dart';
import 'package:seminario_4/screens/screens.dart';
import 'package:seminario_4/widgets/scan_button.dart';
import 'package:seminario_4/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.delete_forever))
        ],
      ),
      body: _HomeScreenBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('--------------------------------------------------------------------------------------------');
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ScanButton()),
          );
        },
        child: Icon(Icons.filter_center_focus),
        backgroundColor: Color(0xFF3D8BEF),
        elevation: 0,
      ),
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;
    switch (currentIndex) {
      case 0:
        return MapScreen();
      case 1:
        return AddressesScreen();
      default:
        return MapScreen();
    }
  }
}
