class OrderModel {
  final String id;
  final String rute;
  final DateTime tanggal;
  final String waktu;
  final String nomorBus;
  final DateTime tanggalPesan;

  OrderModel({
    required this.id,
    required this.rute,
    required this.tanggal,
    required this.waktu,
    required this.nomorBus,
    required this.tanggalPesan,
  });

  // Diubah menjadi Map untuk penyimpanan
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rute': rute,
      'tanggal': tanggal.toIso8601String(),
      'waktu': waktu,
      'nomorBus': nomorBus,
      'tanggalPesan': tanggalPesan.toIso8601String(),
    };
  }

  // Dibuat dari Map
  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as String,
      rute: map['rute'] as String,
      tanggal: DateTime.parse(map['tanggal'] as String),
      waktu: map['waktu'] as String,
      nomorBus: map['nomorBus'] as String,
      tanggalPesan: DateTime.parse(map['tanggalPesan'] as String),
    );
  }
}
