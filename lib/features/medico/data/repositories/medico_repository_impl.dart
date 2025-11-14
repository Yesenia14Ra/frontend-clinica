import 'package:dio/dio.dart';
import '../../domain/models/medico.dart';

class MedicoRepositoryImpl {
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
  )..interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        logPrint: (obj) => print('🌐 API Médico: $obj'),
      ),
    );

  Future<List<Medico>> getAll() async {
    try {
      final response = await _dio.get('/api/medicos');
      if (response.statusCode == 200) {
        // Manejar si response.data es una lista directamente o un objeto
        if (response.data is List) {
          final List<dynamic> data = response.data as List<dynamic>;
          return data.map((json) => Medico.fromJson(json)).toList();
        } else if (response.data is Map && response.data['data'] != null) {
          // Si viene envuelto en un objeto con propiedad 'data'
          final List<dynamic> data = response.data['data'] as List<dynamic>;
          return data.map((json) => Medico.fromJson(json)).toList();
        } else {
          // Si no es lista ni tiene 'data', devolver lista vacía
          print('⚠️ Respuesta inesperada del servidor: ${response.data}');
          return [];
        }
      }
      return [];
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      print('❌ Error al procesar datos: $e');
      throw 'Error al procesar los datos: $e';
    }
  }

  Future<Medico?> getById(String medCmp) async {
    try {
      final response = await _dio.get('/api/medicos/$medCmp');
      if (response.statusCode == 200) {
        return Medico.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<bool> create(Medico medico) async {
    try {
      final response = await _dio.post(
        '/api/medicos',
        data: medico.toJson(),
      );
      return response.statusCode == 201 || response.statusCode == 200;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<bool> update(String medCmp, Medico medico) async {
    try {
      final response = await _dio.put(
        '/api/medicos/$medCmp',
        data: medico.toJson(),
      );
      return response.statusCode == 200;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<bool> delete(String medCmp) async {
    try {
      final response = await _dio.delete('/api/medicos/$medCmp');
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
        return 'Médico no encontrado.';
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
