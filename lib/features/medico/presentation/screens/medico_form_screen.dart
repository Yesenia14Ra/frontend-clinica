import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/models/medico.dart';
import '../providers/medico_provider.dart';

class MedicoFormScreen extends StatefulWidget {
  final Medico? medico;

  const MedicoFormScreen({super.key, this.medico});

  @override
  State<MedicoFormScreen> createState() => _MedicoFormScreenState();
}

class _MedicoFormScreenState extends State<MedicoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cmpController = TextEditingController();
  final _nombreController = TextEditingController();
  final _apellidosController = TextEditingController();
  final _especialidadController = TextEditingController();

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    if (widget.medico != null) {
      _isEditing = true;
      _cmpController.text = widget.medico!.medCmp;
      _nombreController.text = widget.medico!.medNombre;
      _apellidosController.text = widget.medico!.medApellidos;
      _especialidadController.text = widget.medico!.espeNombre;
    }
  }

  @override
  void dispose() {
    _cmpController.dispose();
    _nombreController.dispose();
    _apellidosController.dispose();
    _especialidadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Médico' : 'Nuevo Médico'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _cmpController,
                decoration: const InputDecoration(
                  labelText: 'CMP',
                  hintText: 'Ingrese el CMP del médico',
                  prefixIcon: Icon(Icons.badge),
                ),
                enabled: !_isEditing,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el CMP';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  hintText: 'Ingrese el nombre del médico',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _apellidosController,
                decoration: const InputDecoration(
                  labelText: 'Apellidos',
                  hintText: 'Ingrese los apellidos del médico',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese los apellidos';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _especialidadController,
                decoration: const InputDecoration(
                  labelText: 'Especialidad',
                  hintText: 'Ingrese la especialidad médica',
                  prefixIcon: Icon(Icons.medical_services),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la especialidad';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveMedico,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  _isEditing ? 'Actualizar' : 'Guardar',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveMedico() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final medico = Medico(
      medCmp: _cmpController.text.trim(),
      medNombre: _nombreController.text.trim(),
      medApellidos: _apellidosController.text.trim(),
      espeNombre: _especialidadController.text.trim(),
    );

    final provider = context.read<MedicoProvider>();
    bool success;

    if (_isEditing) {
      success = await provider.updateMedico(widget.medico!.medCmp, medico);
    } else {
      success = await provider.createMedico(medico);
    }

    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isEditing
                ? 'Médico actualizado correctamente'
                : 'Médico creado correctamente'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(provider.errorMessage ?? 'Error al guardar médico'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
