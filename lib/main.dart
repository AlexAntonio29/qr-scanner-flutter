

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/provider/provider_app.dart';
import 'package:qr_scanner/provider/scan_list_provider.dart';
import 'package:qr_scanner/screens/home_page.dart';
import 'package:qr_scanner/screens/mapa_page.dart';
import 'package:qr_scanner/theme/global_themes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>ProviderApp()),
        ChangeNotifierProvider(create: (_)=>ScanListProvider())
        
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: "home_pages",
        theme: GlobalThemes.lightTheme,
        routes: {
          "home_pages": (_)=>HomePage(),
          "mapa_page": (_)=>MapaPage()
        },
      ),
    );
  }
}