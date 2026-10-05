import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/models/scan_models.dart';
import 'package:qr_scanner/provider/db_provider.dart';
import 'package:qr_scanner/provider/provider_app.dart';
import 'package:qr_scanner/provider/scan_list_provider.dart';
import 'package:qr_scanner/screens/direcciones_pages.dart';
import 'package:qr_scanner/screens/mapas_pages.dart';
import 'package:qr_scanner/theme/global_themes.dart';
import 'package:qr_scanner/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tempScan = ScanModel(valor: "http://google.com");
    // DbProvider.db.nuevoScan(tempScan);

    //DbProvider.db.getScandById(56).then((scan)=>print(scan?.valor));
    //DbProvider.db.getAllScans().then(print);

    //DbProvider.db.getScansType("http").then(print);

    // DbProvider.db.updateScan(tempScan);

    //DbProvider.db.deleteAllScan().then(print);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalThemes.primary,
        foregroundColor: GlobalThemes.secundary,
        title: Text("Historial"),
        actions: [
          IconButton(
            onPressed: () {
              final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
              scanListProvider.borrarTodos();

              
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: _HomesPagesBody(),

      bottomNavigationBar: NavegationBar(),
      floatingActionButton: FloatingAction(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomesPagesBody extends StatelessWidget {
  final int index = 0;

  const _HomesPagesBody({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderApp>(context);

    //usar el ScanListProvier
    final scanListProvider = Provider.of<ScanListProvider>(
      context,
      listen: false,
    );

    switch (provider.indexBottomBar) {
      case 0:
        scanListProvider.cargarScansPorTipo("geo");
        return MapasPages();
      case 1:
        scanListProvider.cargarScansPorTipo("http");
        return DireccionesPages();

      default:
        scanListProvider.cargarScansPorTipo("geo");
        return MapasPages();
    }
  }
}
