import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/models/scan_models.dart';
import 'package:qr_scanner/provider/scan_list_provider.dart';
import 'package:qr_scanner/theme/global_themes.dart';
import 'package:qr_scanner/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ListTileWidgets extends StatelessWidget {
  final String type;

  const ListTileWidgets({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return Scaffold(
      body: ListView.builder(
        itemCount: scans.length,
        itemBuilder: (_, index) => Dismissible(
          key: UniqueKey(),
          background: Container(color: GlobalThemes.primary),
          onDismissed: (DismissDirection direction) {
            final scanListProvider = Provider.of<ScanListProvider>(
              context,
              listen: false,
            );
            scanListProvider.borrarScanId(scans[index].id!);
            
          },
          child: ListTile(
            title: Text(scans[index].valor),
            subtitle: Text(scans[index].id.toString()),
            leading: type=="geo" ?Icon(Icons.home):Icon(Icons.web_outlined),
            onTap: () => getlaunchUrl(context, scans[index]),
          ),
        ),
      ),
    );
  }
}
