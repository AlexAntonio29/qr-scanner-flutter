import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/provider/scan_list_provider.dart';
import 'package:qr_scanner/widgets/list_tile_widgets.dart';

class DireccionesPages extends StatelessWidget {
  const DireccionesPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scan = scanListProvider.scans;

    return ListTileWidgets(type: "http");
  }
}
