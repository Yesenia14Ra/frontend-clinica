class Medico {
  final String medCmp;
  final String medNombre;
  final String medApellidos;
  final String espeNombre;
  final String? nombreCompletoConEspecialidad;

  Medico({
    required this.medCmp,
    required this.medNombre,
    required this.medApellidos,
    required this.espeNombre,
    this.nombreCompletoConEspecialidad,
  });

  // Getters de compatibilidad (retornan null)
  String? get medTelefono => null;
  String? get medEmail => null;
  String? get medConsultorio => null;

  String get nombreCompleto => '$medNombre $medApellidos';

  factory Medico.fromJson(Map<String, dynamic> json) {
    return Medico(
      medCmp: json['medCmp']?.toString() ?? '',
      medNombre: json['medNombre']?.toString() ?? '',
      medApellidos: json['medApellidos']?.toString() ?? '',
      espeNombre: json['espeNombre']?.toString() ?? '',
      nombreCompletoConEspecialidad: json['nombreCompletoConEspecialidad']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medCmp': medCmp,
      'medNombre': medNombre,
      'medApellidos': medApellidos,
      'espeNombre': espeNombre,
      // NO enviar nombreCompletoConEspecialidad - es calculado por el backend
    };
  }

  Medico copyWith({
    String? medCmp,
    String? medNombre,
    String? medApellidos,
    String? espeNombre,
    String? nombreCompletoConEspecialidad,
  }) {
    return Medico(
      medCmp: medCmp ?? this.medCmp,
      medNombre: medNombre ?? this.medNombre,
      medApellidos: medApellidos ?? this.medApellidos,
      espeNombre: espeNombre ?? this.espeNombre,
      nombreCompletoConEspecialidad:
          nombreCompletoConEspecialidad ?? this.nombreCompletoConEspecialidad,
    );
  }

  @override
  String toString() {
    return 'Medico(medCmp: $medCmp, nombreCompleto: $nombreCompleto, espeNombre: $espeNombre)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Medico && other.medCmp == medCmp;
  }

  @override
  int get hashCode => medCmp.hashCode;
}
