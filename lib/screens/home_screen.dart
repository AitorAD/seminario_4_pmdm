import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seminario_4/providers/ui_provider.dart';
import 'package:seminario_4/screens/addresses_screen.dart';
import 'package:seminario_4/screens/screens.dart';
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
        onPressed: () {},
        child: Icon(Icons.filter_center_focus),
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
    switch (uiProvider.selectedMenuOpt) {
      case 0:
        return MapScreen();
      case 1:
        return AddressesScreen();
      default:
        return MapScreen();
    }
  }
}
