import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/provider/provider_app.dart';
import 'package:qr_scanner/theme/global_themes.dart';

class NavegationBar extends StatelessWidget {
  final int index = 0;
  const NavegationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderApp>(context);
    return BottomNavigationBar(

      onTap: (value) =>provider.indexBottomBar=value,

      currentIndex: provider.indexBottomBar,
      selectedItemColor: GlobalThemes.primary,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.map), label: "Maps"),

        BottomNavigationBarItem(
          icon: Icon(Icons.directions),
          label: "Directions",
        ),
      ],
    );
  }
}
