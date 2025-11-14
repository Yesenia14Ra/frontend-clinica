class HistoriaClinica {
  final int? histId;
  final String pacDni;
  final String? pacNombreCompleto;
  final String? pacTelefono;
  final String medCmp;
  final String? medNombreCompleto;
  final String? medEspecialidad;
  final DateTime histFechaAtencion;
  final String histDiagnostico;
  final String histAnalisis;
  final String histTratamiento;

  HistoriaClinica({
    this.histId,
    required this.pacDni,
    this.pacNombreCompleto,
    this.pacTelefono,
    required this.medCmp,
    this.medNombreCompleto,
    this.medEspecialidad,
    required this.histFechaAtencion,
    required this.histDiagnostico,
    required this.histAnalisis,
    required this.histTratamiento,
  });

  // Getters de compatibilidad
  DateTime get fechaAtencion => histFechaAtencion;
  String get diagnostico => histDiagnostico;
  String get analisis => histAnalisis;
  String get tratamiento => histTratamiento;

  factory HistoriaClinica.fromJson(Map<String, dynamic> json) {
    return HistoriaClinica(
      histId: json['histId'] as int?,
      pacDni: json['pacDni']?.toString() ?? '',
      pacNombreCompleto: json['pacNombreCompleto']?.toString(),
      pacTelefono: json['pacTelefono']?.toString(),
      medCmp: json['medCmp']?.toString() ?? '',
      medNombreCompleto: json['medNombreCompleto']?.toString(),
      medEspecialidad: json['medEspecialidad']?.toString(),
      histFechaAtencion: _parseFecha(json['histFechaAtencion']),
      histDiagnostico: json['histDiagnostico']?.toString() ?? '',
      histAnalisis: json['histAnalisis']?.toString() ?? '',
      histTratamiento: json['histTratamiento']?.toString() ?? '',
    );
  }

  static DateTime _parseFecha(dynamic fechaStr) {
    if (fechaStr == null || fechaStr.toString().isEmpty) {
      return DateTime.now();
    }
    
    String fecha = fechaStr.toString();
    // Si viene con hora (formato ISO), tomar solo la fecha
    if (fecha.contains('T')) {
      fecha = fecha.split('T')[0];
    }
    
    try {
      return DateTime.parse(fecha);
    } catch (e) {
      return DateTime.now();
    }
  }

  Map<String, dynamic> toJson() {
    // Formatear fecha como yyyy-MM-dd (sin hora)
    final fechaFormateada =
        '${histFechaAtencion.year}-${histFechaAtencion.month.toString().padLeft(2, '0')}-${histFechaAtencion.day.toString().padLeft(2, '0')}';

    return {
      if (histId != null) 'histId': histId,
      'pacDni': pacDni,
      'medCmp': medCmp,
      'histFechaAtencion': fechaFormateada,
      'histDiagnostico': histDiagnostico,
      'histAnalisis': histAnalisis,
      'histTratamiento': histTratamiento,
      // NO enviar campos calculados: pacNombreCompleto, pacTelefono, 
      // medNombreCompleto, medEspecialidad
    };
  }

  HistoriaClinica copyWith({
    int? histId,
    String? pacDni,
    String? pacNombreCompleto,
    String? pacTelefono,
    String? medCmp,
    String? medNombreCompleto,
    String? medEspecialidad,
    DateTime? histFechaAtencion,
    String? histDiagnostico,
    String? histAnalisis,
    String? histTratamiento,
  }) {
    return HistoriaClinica(
      histId: histId ?? this.histId,
      pacDni: pacDni ?? this.pacDni,
      pacNombreCompleto: pacNombreCompleto ?? this.pacNombreCompleto,
      pacTelefono: pacTelefono ?? this.pacTelefono,
      medCmp: medCmp ?? this.medCmp,
      medNombreCompleto: medNombreCompleto ?? this.medNombreCompleto,
      medEspecialidad: medEspecialidad ?? this.medEspecialidad,
      histFechaAtencion: histFechaAtencion ?? this.histFechaAtencion,
      histDiagnostico: histDiagnostico ?? this.histDiagnostico,
      histAnalisis: histAnalisis ?? this.histAnalisis,
      histTratamiento: histTratamiento ?? this.histTratamiento,
    );
  }

  @override
  String toString() {
    return 'HistoriaClinica(histId: $histId, pacDni: $pacDni, medCmp: $medCmp, fecha: $fechaAtencion)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is HistoriaClinica && other.histId == histId;
  }

  @override
  int get hashCode => histId.hashCode;
}
