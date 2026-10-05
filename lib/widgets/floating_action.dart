import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner_plus/flutter_barcode_scanner_plus.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/provider/scan_list_provider.dart';
import 'package:qr_scanner/utils/utils.dart';

class FloatingAction extends StatelessWidget {
  const FloatingAction({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
         String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode( "#3D8BEF","Cancelar", false,ScanMode.QR, );
        //final String barcodeScanRes = "geo:20.748320, -103.423668";

        if (barcodeScanRes == "-1") return;

        final scanListProvider = Provider.of<ScanListProvider>(
          context,
          listen: false,
        );
        final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);

        getlaunchUrl(context, nuevoScan); 
        //scanListProvider.nuevoScan("geo:15.33,15.66");
      },
      child: Icon(Icons.qr_code),
    );
  }
}
