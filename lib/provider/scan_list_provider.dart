import 'package:flutter/foundation.dart';
import 'package:qr_scanner/models/scan_models.dart';
import 'package:qr_scanner/provider/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];

  String tipoSeleccionado = "http";

  Future<ScanModel> nuevoScan(String valor) async {
    final nuevoScan = ScanModel(valor: valor);
    final id = await DbProvider.db.nuevoScan(nuevoScan);

    //asignar id
    nuevoScan.id = id;
    if (tipoSeleccionado == nuevoScan.tipo) {
      scans.add(nuevoScan);
      notifyListeners();
    }

    return nuevoScan;
  }

  cargarScans(String tipo) async {
    final scans = await DbProvider.db.getAllScans();
    this.scans = [...scans];
    notifyListeners();
  }

  cargarScansPorTipo(String tipo) async {
    final scans = await DbProvider.db.getScansType(tipo);
    this.scans = [...scans];
    tipoSeleccionado = tipo;
    print(this.scans);
    notifyListeners();
  }

  borrarTodos() async {
    await DbProvider.db.deleteAllScan();
    this.scans = [];
    notifyListeners();
  }

  borrarScanId(int id) async {
    final scans = await DbProvider.db.deleteScan(id);
    print(tipoSeleccionado);
    cargarScansPorTipo(this.tipoSeleccionado);
  }
}
