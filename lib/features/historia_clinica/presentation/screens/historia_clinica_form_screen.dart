import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../domain/models/historia_clinica.dart';
import '../providers/historia_clinica_provider.dart';
import '../../../medico/presentation/providers/medico_provider.dart';
import '../../../paciente/presentation/providers/paciente_provider.dart';

class HistoriaClinicaFormScreen extends StatefulWidget {
  final HistoriaClinica? historiaClinica;

  const HistoriaClinicaFormScreen({super.key, this.historiaClinica});

  @override
  State<HistoriaClinicaFormScreen> createState() =>
      _HistoriaClinicaFormScreenState();
}

class _HistoriaClinicaFormScreenState extends State<HistoriaClinicaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _diagnosticoController = TextEditingController();
  final _analisisController = TextEditingController();
  final _tratamientoController = TextEditingController();

  String? _selectedPacienteDni;
  String? _selectedMedicoCmp;
  DateTime _selectedDate = DateTime.now();

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();

    // Cargar listas de pacientes y médicos
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PacienteProvider>().loadPacientes();
      context.read<MedicoProvider>().loadMedicos();
    });

    if (widget.historiaClinica != null) {
      _isEditing = true;
      _selectedPacienteDni = widget.historiaClinica!.pacDni;
      _selectedMedicoCmp = widget.historiaClinica!.medCmp;
      _selectedDate = widget.historiaClinica!.histFechaAtencion;
      _diagnosticoController.text = widget.historiaClinica!.histDiagnostico;
      _analisisController.text = widget.historiaClinica!.histAnalisis;
      _tratamientoController.text = widget.historiaClinica!.histTratamiento;
    }
  }

  @override
  void dispose() {
    _diagnosticoController.dispose();
    _analisisController.dispose();
    _tratamientoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            _isEditing ? 'Editar Historia Clínica' : 'Nueva Historia Clínica'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Dropdown de Paciente
              Consumer<PacienteProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  return DropdownButtonFormField<String>(
                    initialValue: _selectedPacienteDni,
                    decoration: const InputDecoration(
                      labelText: 'Paciente',
                      prefixIcon: Icon(Icons.person),
                    ),
                    isExpanded: true,
                    items: provider.pacientes.map((paciente) {
                      return DropdownMenuItem(
                        value: paciente.pacDni,
                        child: Text(
                          '${paciente.nombreCompletoCalculado} (${paciente.pacDni})',
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedPacienteDni = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor seleccione un paciente';
                      }
                      return null;
                    },
                  );
                },
              ),
              const SizedBox(height: 16),

              // Dropdown de Médico
              Consumer<MedicoProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  return DropdownButtonFormField<String>(
                    initialValue: _selectedMedicoCmp,
                    decoration: const InputDecoration(
                      labelText: 'Médico',
                      prefixIcon: Icon(Icons.medical_services),
                    ),
                    isExpanded: true,
                    items: provider.medicos.map((medico) {
                      return DropdownMenuItem(
                        value: medico.medCmp,
                        child: Text(
                          '${medico.nombreCompleto} - ${medico.espeNombre} (${medico.medCmp})',
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedMedicoCmp = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor seleccione un médico';
                      }
                      return null;
                    },
                  );
                },
              ),
              const SizedBox(height: 16),

              // Selector de fecha
              InkWell(
                onTap: _selectDate,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Fecha de Atención',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(
                    DateFormat('dd/MM/yyyy', 'es').format(_selectedDate),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Campo de diagnóstico
              TextFormField(
                controller: _diagnosticoController,
                decoration: const InputDecoration(
                  labelText: 'Diagnóstico',
                  hintText: 'Ingrese el diagnóstico',
                  prefixIcon: Icon(Icons.medical_information),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el diagnóstico';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo de análisis
              TextFormField(
                controller: _analisisController,
                decoration: const InputDecoration(
                  labelText: 'Análisis',
                  hintText: 'Ingrese el análisis',
                  prefixIcon: Icon(Icons.analytics),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el análisis';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo de tratamiento
              TextFormField(
                controller: _tratamientoController,
                decoration: const InputDecoration(
                  labelText: 'Tratamiento',
                  hintText: 'Ingrese el tratamiento',
                  prefixIcon: Icon(Icons.medication),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el tratamiento';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // Botón de guardar
              ElevatedButton(
                onPressed: _saveHistoria,
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

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale('es', 'ES'),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _saveHistoria() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final historia = HistoriaClinica(
      histId: widget.historiaClinica?.histId,
      pacDni: _selectedPacienteDni!,
      medCmp: _selectedMedicoCmp!,
      histFechaAtencion: _selectedDate,
      histDiagnostico: _diagnosticoController.text.trim(),
      histAnalisis: _analisisController.text.trim(),
      histTratamiento: _tratamientoController.text.trim(),
    );

    final provider = context.read<HistoriaClinicaProvider>();
    bool success;

    if (_isEditing) {
      success = await provider.updateHistoria(
          widget.historiaClinica!.histId!, historia);
    } else {
      success = await provider.createHistoria(historia);
    }

    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isEditing
                ? 'Historia clínica actualizada correctamente'
                : 'Historia clínica creada correctamente'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                provider.errorMessage ?? 'Error al guardar historia clínica'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
