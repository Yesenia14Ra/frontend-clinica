import 'package:dio/dio.dart';
import '../../domain/models/paciente.dart';

class PacienteRepositoryImpl {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8080', // Para emulador Android
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  Future<List<Paciente>> getAll() async {
    try {
      final response = await _dio.get('/api/pacientes');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data.map((json) => Paciente.fromJson(json)).toList();
      }
      return [];
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Paciente?> getById(String pacDni) async {
    try {
      final response = await _dio.get('/api/pacientes/$pacDni');
      if (response.statusCode == 200) {
        return Paciente.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<bool> create(Paciente paciente) async {
    try {
      final response = await _dio.post(
        '/api/pacientes',
        data: paciente.toJson(),
      );
      return response.statusCode == 201 || response.statusCode == 200;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<bool> update(String pacDni, Paciente paciente) async {
    try {
      final response = await _dio.put(
        '/api/pacientes/$pacDni',
        data: paciente.toJson(),
      );
      return response.statusCode == 200;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<bool> delete(String pacDni) async {
    try {
      final response = await _dio.delete('/api/pacientes/$pacDni');
      return response.statusCode == 200 || response.statusCode == 204;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return 'Tiempo de conexión agotado. Verifique su conexión a internet.';
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return 'Tiempo de espera agotado. El servidor no responde.';
    } else if (e.response != null) {
      final statusCode = e.response!.statusCode;
      if (statusCode == 404) {
        return 'Paciente no encontrado.';
      } else if (statusCode == 400) {
        return 'Datos inválidos. Verifique la información ingresada.';
      } else if (statusCode == 500) {
        return 'Error del servidor. Intente más tarde.';
      }
      return 'Error: ${e.response!.statusMessage}';
    }
    return 'Error de conexión. Verifique que el servidor esté corriendo.';
  }
}
