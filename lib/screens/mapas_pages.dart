import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/provider/scan_list_provider.dart';
import 'package:qr_scanner/theme/global_themes.dart';
import 'package:qr_scanner/widgets/list_tile_widgets.dart';

class MapasPages extends StatelessWidget {
  const MapasPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListTileWidgets(type: "geo");
  }
}
