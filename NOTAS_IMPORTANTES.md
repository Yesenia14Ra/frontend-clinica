# Notas Importantes del Proyecto

## ⚠️ Configuración Crítica

### 1. Nombres de Campos del Backend

**IMPORTANTE**: Los nombres de campos siguen la convención del backend y deben respetarse exactamente:

#### Médico
- `medCmp` (ID único - CMP del médico)
- `medNombre`
- `medApellidos` (plural, UN solo campo)
- `espeNombre`
- `nombreCompletoConEspecialidad` (calculado por backend, NO enviar)

#### Paciente
- `pacDni` (ID único - 8 dígitos)
- `pacNombre`
- `pacApellidoPaterno` (DOS campos de apellidos separados)
- `pacApellidoMaterno`
- `pacTelefono`
- `pacDireccion`
- `nombreCompleto` (calculado por backend, NO enviar)

#### Historia Clínica
- `histId` (auto-generado)
- `pacDni` (FK)
- `medCmp` (FK)
- `histFechaAtencion` (formato yyyy-MM-dd)
- `histDiagnostico`
- `histAnalisis`
- `histTratamiento`
- `pacNombreCompleto`, `pacTelefono`, `medNombreCompleto`, `medEspecialidad` (calculados por backend, NO enviar)

### 2. Formato de Fechas

```dart
// Enviar al backend (sin hora)
final fechaFormateada = '${fecha.year}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}';

// Ejemplo: "2024-11-13"
```

**Razón**: El backend usa `LocalDate` de Java que NO incluye hora.

### 3. Campos Calculados por el Backend

**NO incluir estos campos en POST/PUT**:

```dart
// En toJson(), NO incluir:
// - nombreCompletoConEspecialidad (Medico)
// - nombreCompleto (Paciente)
// - pacNombreCompleto, pacTelefono, medNombreCompleto, medEspecialidad (Historia)
```

El backend los calcula automáticamente al recuperar los datos.

### 4. Configuración de URL Base

```dart
// Para emulador Android
baseUrl: 'http://10.0.2.2:8080'

// Para iOS Simulator
baseUrl: 'http://localhost:8080'

// Para dispositivo físico
baseUrl: 'http://TU_IP_LOCAL:8080'  // ej: http://192.168.1.100:8080
```

### 5. Dropdowns en Formularios

Siempre usar `isExpanded: true` para evitar overflow:

```dart
DropdownButtonFormField<String>(
  isExpanded: true,  // CRÍTICO
  items: items.map((item) {
    return DropdownMenuItem(
      value: item.id,
      child: Text(
        'Texto largo...',
        overflow: TextOverflow.ellipsis,  // IMPORTANTE
      ),
    );
  }).toList(),
  // ...
)
```

### 6. DatePicker en Español

Requiere configuración en MaterialApp:

```dart
MaterialApp(
  localizationsDelegates: const [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: const [Locale('es', 'ES')],
  locale: const Locale('es', 'ES'),
  // ...
)
```

Y usar el locale en showDatePicker:

```dart
showDatePicker(
  context: context,
  locale: const Locale('es', 'ES'),  // IMPORTANTE
  // ...
)
```

### 7. Optimización de Recarga

**NO recargar listas manualmente después de CRUD**. El Provider lo hace automáticamente:

```dart
Future<bool> createEntity(Entity entity) async {
  final success = await _repository.create(entity);
  if (success) {
    await loadEntities();  // Recarga automática
  }
  return success;
}
```

En la UI, Consumer se actualiza automáticamente.

### 8. Null Safety

Todos los campos calculados del backend pueden ser null:

```dart
// Degradación elegante
final nombre = historia.pacNombreCompleto ?? 'DNI: ${historia.pacDni}';
```

### 9. Manejo de Errores HTTP

Repositorios incluyen manejo específico:

```dart
// 400: Datos inválidos
// 404: Recurso no encontrado
// 500: Error del servidor
// Timeout: Error de conexión
```

### 10. Estructura de Providers

Cada provider debe:
- Mantener lista de entidades
- Indicador de carga (isLoading)
- Mensaje de error (errorMessage)
- Métodos CRUD que actualizan automáticamente

## 🔄 Flujo de Trabajo Típico

### Crear Nueva Entidad

1. Usuario abre formulario
2. Llena campos
3. Submit → Provider.create()
4. Provider llama Repository
5. Repository hace POST al backend
6. Provider recarga lista automáticamente
7. Navigator.pop() vuelve a lista
8. Consumer muestra entidad nueva

### Editar Entidad

1. Usuario selecciona "Editar"
2. Formulario pre-lleno con datos
3. Modifica campos
4. Submit → Provider.update()
5. Provider llama Repository.update()
6. Repository hace PUT al backend
7. Provider recarga lista automáticamente
8. Navigator.pop() vuelve a lista actualizada

## 🐛 Problemas Comunes y Soluciones

### Error: "No route defined for /home"

**Solución**: Verificar que routes esté definido en MaterialApp:

```dart
MaterialApp(
  initialRoute: '/login',
  routes: {
    '/login': (context) => const LoginScreen(),
    '/home': (context) => const MainNavigationScreen(),
  },
)
```

### Error: "Another exception was thrown: Incorrect use of ParentDataWidget"

**Solución**: Verificar que los hijos de Column/Row no tengan propiedades de posicionamiento absoluto.

### Error de formato de fecha del backend

**Solución**: Asegurar que se envía solo fecha sin hora (yyyy-MM-dd).

### Dropdown no muestra texto completo

**Solución**: Agregar `isExpanded: true` y `overflow: TextOverflow.ellipsis`.

### DatePicker en inglés

**Solución**: Configurar localizationsDelegates y locale en MaterialApp.

### Provider no actualiza UI

**Solución**: 
1. Verificar que se llama `notifyListeners()`
2. Usar `Consumer<Provider>` en lugar de `Provider.of(listen: false)`

## 📚 Recursos

- [Flutter Documentation](https://flutter.dev/docs)
- [Provider Package](https://pub.dev/packages/provider)
- [Dio HTTP Client](https://pub.dev/packages/dio)
- [Material Design 3](https://m3.material.io/)

## 🚀 Siguiente Pasos

- [ ] Implementar autenticación real con JWT
- [ ] Agregar paginación en listas largas
- [ ] Implementar búsqueda y filtros
- [ ] Agregar caché local con SQLite
- [ ] Implementar sincronización offline
- [ ] Agregar validaciones más robustas
- [ ] Implementar tests unitarios
- [ ] Agregar gráficos y estadísticas
