class Paciente {
  final String pacDni;
  final String pacNombre;
  final String pacApellidoPaterno;
  final String pacApellidoMaterno;
  final String pacTelefono;
  final String pacDireccion;
  final String? nombreCompleto;

  Paciente({
    required this.pacDni,
    required this.pacNombre,
    required this.pacApellidoPaterno,
    required this.pacApellidoMaterno,
    required this.pacTelefono,
    required this.pacDireccion,
    this.nombreCompleto,
  });

  String get nombreCompletoCalculado =>
      nombreCompleto ?? '$pacNombre $pacApellidoPaterno $pacApellidoMaterno';

  factory Paciente.fromJson(Map<String, dynamic> json) {
    return Paciente(
      pacDni: json['pacDni']?.toString() ?? '',
      pacNombre: json['pacNombre']?.toString() ?? '',
      pacApellidoPaterno: json['pacApellidoPaterno']?.toString() ?? '',
      pacApellidoMaterno: json['pacApellidoMaterno']?.toString() ?? '',
      pacTelefono: json['pacTelefono']?.toString() ?? '',
      pacDireccion: json['pacDireccion']?.toString() ?? '',
      nombreCompleto: json['nombreCompleto']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pacDni': pacDni,
      'pacNombre': pacNombre,
      'pacApellidoPaterno': pacApellidoPaterno,
      'pacApellidoMaterno': pacApellidoMaterno,
      'pacTelefono': pacTelefono,
      'pacDireccion': pacDireccion,
      // NO enviar nombreCompleto - es calculado por el backend
    };
  }

  Paciente copyWith({
    String? pacDni,
    String? pacNombre,
    String? pacApellidoPaterno,
    String? pacApellidoMaterno,
    String? pacTelefono,
    String? pacDireccion,
    String? nombreCompleto,
  }) {
    return Paciente(
      pacDni: pacDni ?? this.pacDni,
      pacNombre: pacNombre ?? this.pacNombre,
      pacApellidoPaterno: pacApellidoPaterno ?? this.pacApellidoPaterno,
      pacApellidoMaterno: pacApellidoMaterno ?? this.pacApellidoMaterno,
      pacTelefono: pacTelefono ?? this.pacTelefono,
      pacDireccion: pacDireccion ?? this.pacDireccion,
      nombreCompleto: nombreCompleto ?? this.nombreCompleto,
    );
  }

  @override
  String toString() {
    return 'Paciente(pacDni: $pacDni, nombreCompleto: $nombreCompletoCalculado)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Paciente && other.pacDni == pacDni;
  }

  @override
  int get hashCode => pacDni.hashCode;
}
