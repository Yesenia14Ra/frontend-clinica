import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/models/paciente.dart';
import '../providers/paciente_provider.dart';

class PacienteFormScreen extends StatefulWidget {
  final Paciente? paciente;

  const PacienteFormScreen({super.key, this.paciente});

  @override
  State<PacienteFormScreen> createState() => _PacienteFormScreenState();
}

class _PacienteFormScreenState extends State<PacienteFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dniController = TextEditingController();
  final _nombreController = TextEditingController();
  final _apellidoPaternoController = TextEditingController();
  final _apellidoMaternoController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _direccionController = TextEditingController();

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    if (widget.paciente != null) {
      _isEditing = true;
      _dniController.text = widget.paciente!.pacDni;
      _nombreController.text = widget.paciente!.pacNombre;
      _apellidoPaternoController.text = widget.paciente!.pacApellidoPaterno;
      _apellidoMaternoController.text = widget.paciente!.pacApellidoMaterno;
      _telefonoController.text = widget.paciente!.pacTelefono;
      _direccionController.text = widget.paciente!.pacDireccion;
    }
  }

  @override
  void dispose() {
    _dniController.dispose();
    _nombreController.dispose();
    _apellidoPaternoController.dispose();
    _apellidoMaternoController.dispose();
    _telefonoController.dispose();
    _direccionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Paciente' : 'Nuevo Paciente'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _dniController,
                decoration: const InputDecoration(
                  labelText: 'DNI',
                  hintText: 'Ingrese el DNI (8 dígitos)',
                  prefixIcon: Icon(Icons.badge),
                ),
                keyboardType: TextInputType.number,
                maxLength: 8,
                enabled: !_isEditing,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el DNI';
                  }
                  if (value.length != 8) {
                    return 'El DNI debe tener 8 dígitos';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  hintText: 'Ingrese el nombre del paciente',
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
                controller: _apellidoPaternoController,
                decoration: const InputDecoration(
                  labelText: 'Apellido Paterno',
                  hintText: 'Ingrese el apellido paterno',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el apellido paterno';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _apellidoMaternoController,
                decoration: const InputDecoration(
                  labelText: 'Apellido Materno',
                  hintText: 'Ingrese el apellido materno',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el apellido materno';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _telefonoController,
                decoration: const InputDecoration(
                  labelText: 'Teléfono',
                  hintText: 'Ingrese el teléfono',
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el teléfono';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _direccionController,
                decoration: const InputDecoration(
                  labelText: 'Dirección',
                  hintText: 'Ingrese la dirección',
                  prefixIcon: Icon(Icons.home),
                ),
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la dirección';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _savePaciente,
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

  Future<void> _savePaciente() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final paciente = Paciente(
      pacDni: _dniController.text.trim(),
      pacNombre: _nombreController.text.trim(),
      pacApellidoPaterno: _apellidoPaternoController.text.trim(),
      pacApellidoMaterno: _apellidoMaternoController.text.trim(),
      pacTelefono: _telefonoController.text.trim(),
      pacDireccion: _direccionController.text.trim(),
    );

    final provider = context.read<PacienteProvider>();
    bool success;

    if (_isEditing) {
      success = await provider.updatePaciente(widget.paciente!.pacDni, paciente);
    } else {
      success = await provider.createPaciente(paciente);
    }

    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isEditing
                ? 'Paciente actualizado correctamente'
                : 'Paciente creado correctamente'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(provider.errorMessage ?? 'Error al guardar paciente'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
