import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seminario_4/providers/scan_list_provider.dart';
import 'package:seminario_4/providers/ui_provider.dart';
import 'package:seminario_4/screens/screens.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => UiProvider()),
      ChangeNotifierProvider(create: (_) => ScanListProvider()),
    ], child: MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Reader',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.deepPurple,
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 24),
            iconTheme: IconThemeData(color: Colors.white)),
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Colors.deepPurple),
      ),
      initialRoute: 'home_screen',
      routes: {
        'home_screen': (_) => HomeScreen(),
        'map': (_) => MapScreen(),
      },
    );
  }
}
