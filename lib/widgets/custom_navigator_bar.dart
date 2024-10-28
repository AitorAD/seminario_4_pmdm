import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items: [
      BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'Mapa'),
      BottomNavigationBarItem(icon: Icon(Icons.compass_calibration), label: 'Direcciones')
    ],
    currentIndex: 0,
    elevation: 0,);
  }
}
