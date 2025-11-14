import 'package:flutter/material.dart';
import '../../data/repositories/paciente_repository_impl.dart';
import '../../domain/models/paciente.dart';

class PacienteProvider with ChangeNotifier {
  final PacienteRepositoryImpl _repository = PacienteRepositoryImpl();
  
  List<Paciente> _pacientes = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Paciente> get pacientes => _pacientes;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadPacientes() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _pacientes = await _repository.getAll();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
      _pacientes = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createPaciente(Paciente paciente) async {
    try {
      final success = await _repository.create(paciente);
      if (success) {
        await loadPacientes();
      }
      return success;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> updatePaciente(String pacDni, Paciente paciente) async {
    try {
      final success = await _repository.update(pacDni, paciente);
      if (success) {
        await loadPacientes();
      }
      return success;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> deletePaciente(String pacDni) async {
    try {
      final success = await _repository.delete(pacDni);
      if (success) {
        _pacientes.removeWhere((p) => p.pacDni == pacDni);
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
