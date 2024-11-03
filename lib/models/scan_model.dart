import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class ScanModel {
  int? id;
  String tipo;
  String valor;

  ScanModel({
    required this.id,
    required this.valor,
  }) : tipo = valor.contains('http') ? 'http' : 'geo';

  factory ScanModel.fromJson(String str) => ScanModel.fromMap(json.decode(str));

  factory ScanModel.fromMap(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        valor: json["valor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
      };

  @override
  String toString() {
    return 'ScanModel(id: $id, tipo: $tipo, valor: $valor)';
  }

  LatLng getLatLng() {
    final coords = valor.replaceFirst('geo:', '').split(',');
    if (coords.length != 2) {
      throw FormatException('Invalid coordinate format');
    }

    final latitude = double.tryParse(coords[0]);
    final longitude = double.tryParse(coords[1]);

    if (latitude == null || longitude == null) {
      throw FormatException('Invalid latitude or longitude');
    }

    print('Latitud: $latitude, Longitud: $longitude');
    return LatLng(latitude, longitude);
  }
}
