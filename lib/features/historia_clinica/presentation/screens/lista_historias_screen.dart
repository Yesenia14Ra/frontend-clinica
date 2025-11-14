import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/historia_clinica_provider.dart';
import 'historia_clinica_form_screen.dart';

class ListaHistoriasScreen extends StatefulWidget {
  const ListaHistoriasScreen({super.key});

  @override
  State<ListaHistoriasScreen> createState() => _ListaHistoriasScreenState();
}

class _ListaHistoriasScreenState extends State<ListaHistoriasScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HistoriaClinicaProvider>().loadHistorias();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historias Clínicas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<HistoriaClinicaProvider>().loadHistorias();
            },
          ),
        ],
      ),
      body: Consumer<HistoriaClinicaProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      provider.errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      provider.loadHistorias();
                    },
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          if (provider.historias.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.description_outlined, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No hay historias clínicas registradas',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.historias.length,
            itemBuilder: (context, index) {
              final historia = provider.historias[index];
              final dateFormat = DateFormat('dd/MM/yyyy', 'es');

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ExpansionTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: const Icon(Icons.description, color: Colors.white),
                  ),
                  title: Text(
                    historia.pacNombreCompleto ?? 'DNI: ${historia.pacDni}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text('Fecha: ${dateFormat.format(historia.fechaAtencion)}'),
                      Text('Médico: ${historia.medNombreCompleto ?? 'CMP: ${historia.medCmp}'}'),
                      if (historia.medEspecialidad != null)
                        Text('Especialidad: ${historia.medEspecialidad}'),
                    ],
                  ),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 20),
                            SizedBox(width: 8),
                            Text('Editar'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, size: 20, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Eliminar', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                    onSelected: (value) {
                      if (value == 'edit') {
                        _editHistoria(historia);
                      } else if (value == 'delete') {
                        _confirmDelete(historia);
                      }
                    },
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (historia.pacTelefono != null) ...[
                            Row(
                              children: [
                                const Icon(Icons.phone, size: 16, color: Colors.grey),
                                const SizedBox(width: 8),
                                Text('Teléfono: ${historia.pacTelefono}'),
                              ],
                            ),
                            const SizedBox(height: 8),
                          ],
                          const Divider(),
                          const SizedBox(height: 8),
                          const Text(
                            'Diagnóstico:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(historia.diagnostico),
                          const SizedBox(height: 12),
                          const Text(
                            'Análisis:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(historia.analisis),
                          const SizedBox(height: 12),
                          const Text(
                            'Tratamiento:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(historia.tratamiento),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addHistoria,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addHistoria() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HistoriaClinicaFormScreen(),
      ),
    );
  }

  void _editHistoria(historia) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HistoriaClinicaFormScreen(historiaClinica: historia),
      ),
    );
  }

  void _confirmDelete(historia) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text(
            '¿Está seguro de eliminar la historia clínica #${historia.histId}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await context
                  .read<HistoriaClinicaProvider>()
                  .deleteHistoria(historia.histId!);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(success
                        ? 'Historia clínica eliminada correctamente'
                        : 'Error al eliminar historia clínica'),
                    backgroundColor: success ? Colors.green : Colors.red,
                  ),
                );
              }
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
