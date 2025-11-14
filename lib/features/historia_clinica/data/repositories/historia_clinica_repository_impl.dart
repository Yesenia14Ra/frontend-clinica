import 'package:dio/dio.dart';
import '../../domain/models/historia_clinica.dart';

class HistoriaClinicaRepositoryImpl {
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
        logPrint: (obj) => print('🌐 API: $obj'),
      ),
    );

  Future<List<HistoriaClinica>> getAll() async {
    try {
      final response = await _dio.get('/api/historias-clinicas');
      if (response.statusCode == 200) {
        // Manejar si response.data es una lista directamente o un objeto
        if (response.data is List) {
          final List<dynamic> data = response.data as List<dynamic>;
          return data.map((json) => HistoriaClinica.fromJson(json)).toList();
        } else if (response.data is Map && response.data['data'] != null) {
          // Si viene envuelto en un objeto con propiedad 'data'
          final List<dynamic> data = response.data['data'] as List<dynamic>;
          return data.map((json) => HistoriaClinica.fromJson(json)).toList();
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

  Future<HistoriaClinica?> getById(int histId) async {
    try {
      final response = await _dio.get('/api/historias-clinicas/$histId');
      if (response.statusCode == 200) {
        return HistoriaClinica.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<bool> create(HistoriaClinica historiaClinica) async {
    try {
      final jsonData = historiaClinica.toJson();
      print('📤 Enviando historia clínica: $jsonData');

      final response = await _dio.post(
        '/api/historias-clinicas',
        data: jsonData,
      );

      print(
          '✅ Respuesta del servidor: ${response.statusCode} - ${response.data}');
      return response.statusCode == 201 || response.statusCode == 200;
    } on DioException catch (e) {
      print('❌ Error DioException: ${e.type}');
      print('❌ Response: ${e.response?.data}');
      print('❌ Status: ${e.response?.statusCode}');
      throw _handleError(e);
    } catch (e) {
      print('❌ Error general: $e');
      throw 'Error inesperado: $e';
    }
  }

  Future<bool> update(int histId, HistoriaClinica historiaClinica) async {
    try {
      final response = await _dio.put(
        '/api/historias-clinicas/$histId',
        data: historiaClinica.toJson(),
      );
      return response.statusCode == 200;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<bool> delete(int histId) async {
    try {
      final response = await _dio.delete('/api/historias-clinicas/$histId');
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
        return 'Historia clínica no encontrada.';
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
