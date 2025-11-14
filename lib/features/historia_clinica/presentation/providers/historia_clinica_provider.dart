import 'package:flutter/material.dart';
import '../../data/repositories/historia_clinica_repository_impl.dart';
import '../../domain/models/historia_clinica.dart';

class HistoriaClinicaProvider with ChangeNotifier {
  final HistoriaClinicaRepositoryImpl _repository = HistoriaClinicaRepositoryImpl();
  
  List<HistoriaClinica> _historias = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<HistoriaClinica> get historias => _historias;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadHistorias() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _historias = await _repository.getAll();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
      _historias = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createHistoria(HistoriaClinica historia) async {
    try {
      final success = await _repository.create(historia);
      if (success) {
        await loadHistorias();
      }
      return success;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateHistoria(int histId, HistoriaClinica historia) async {
    try {
      final success = await _repository.update(histId, historia);
      if (success) {
        await loadHistorias();
      }
      return success;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteHistoria(int histId) async {
    try {
      final success = await _repository.delete(histId);
      if (success) {
        _historias.removeWhere((h) => h.histId == histId);
        notifyListeners();
      }
      return success;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
