import 'package:flutter/material.dart';
import '../../data/repositories/medico_repository_impl.dart';
import '../../domain/models/medico.dart';

class MedicoProvider with ChangeNotifier {
  final MedicoRepositoryImpl _repository = MedicoRepositoryImpl();
  
  List<Medico> _medicos = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Medico> get medicos => _medicos;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadMedicos() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _medicos = await _repository.getAll();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
      _medicos = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createMedico(Medico medico) async {
    try {
      final success = await _repository.create(medico);
      if (success) {
        await loadMedicos();
      }
      return success;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateMedico(String medCmp, Medico medico) async {
    try {
      final success = await _repository.update(medCmp, medico);
      if (success) {
        await loadMedicos();
      }
      return success;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteMedico(String medCmp) async {
    try {
      final success = await _repository.delete(medCmp);
      if (success) {
        _medicos.removeWhere((m) => m.medCmp == medCmp);
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
