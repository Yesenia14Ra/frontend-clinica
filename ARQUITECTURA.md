# 📐 Arquitectura del Proyecto - Vista Completa

```
app-frontend-clinica/
│
├── 📄 pubspec.yaml                    # Dependencias y configuración del proyecto
├── 📄 analysis_options.yaml           # Reglas de linting
├── 📄 .gitignore                      # Archivos ignorados por Git
├── 📄 README.md                       # Documentación principal
├── 📄 NOTAS_IMPORTANTES.md            # Notas críticas del proyecto
├── 📄 GUIA_INICIO.md                  # Guía de instalación y ejecución
│
└── 📁 lib/
    │
    ├── 📄 main.dart                   # Punto de entrada de la aplicación
    │                                  # - Configuración de MultiProvider
    │                                  # - Localización (español)
    │                                  # - Rutas de navegación
    │                                  # - Temas Material Design 3
    │
    ├── 📁 core/                       # Funcionalidades transversales
    │   │
    │   ├── 📁 theme/
    │   │   └── 📄 theme.dart          # Temas light/dark Material Design 3
    │   │
    │   ├── 📁 providers/
    │   │   ├── 📄 theme_provider.dart # State management del tema
    │   │   └── 📄 providers.dart      # Barrel file de providers
    │   │
    │   └── 📁 utils/
    │       └── 📄 responsive_utils.dart # Utilidades para responsividad
    │
    └── 📁 features/                   # Módulos por funcionalidad
        │
        ├── 📁 auth/                   # 🔐 AUTENTICACIÓN
        │   ├── 📄 auth.dart           # Barrel file
        │   └── 📁 presentation/
        │       └── 📁 screens/
        │           └── 📄 login_screen.dart
        │
        ├── 📁 home/                   # 🏠 NAVEGACIÓN PRINCIPAL
        │   ├── 📄 home.dart           # Barrel file
        │   └── 📁 presentation/
        │       └── 📁 screens/
        │           └── 📄 main_navigation_screen.dart
        │                              # NavigationBar con 3 tabs
        │
        ├── 📁 medico/                 # 👨‍⚕️ MÉDICOS
        │   ├── 📄 medico.dart         # Barrel file
        │   │
        │   ├── 📁 domain/             # Capa de Dominio
        │   │   └── 📁 models/
        │   │       └── 📄 medico.dart
        │   │           # Campos: medCmp, medNombre, medApellidos, espeNombre
        │   │
        │   ├── 📁 data/               # Capa de Datos
        │   │   └── 📁 repositories/
        │   │       └── 📄 medico_repository_impl.dart
        │   │           # CRUD con Dio
        │   │           # GET /api/medicos
        │   │           # POST /api/medicos
        │   │           # PUT /api/medicos/{cmp}
        │   │           # DELETE /api/medicos/{cmp}
        │   │
        │   └── 📁 presentation/       # Capa de Presentación
        │       ├── 📁 providers/
        │       │   └── 📄 medico_provider.dart
        │       │       # State management con ChangeNotifier
        │       │
        │       └── 📁 screens/
        │           ├── 📄 lista_medicos_screen.dart
        │           │   # Lista con Consumer<MedicoProvider>
        │           │   # Cards con PopupMenu (edit/delete)
        │           │   # FloatingActionButton para crear
        │           │
        │           └── 📄 medico_form_screen.dart
        │               # Formulario de creación/edición
        │               # Validaciones
        │
        ├── 📁 paciente/               # 👥 PACIENTES
        │   ├── 📄 paciente.dart       # Barrel file
        │   │
        │   ├── 📁 domain/
        │   │   └── 📁 models/
        │   │       └── 📄 paciente.dart
        │   │           # Campos: pacDni, pacNombre, 
        │   │           #         pacApellidoPaterno, pacApellidoMaterno
        │   │           #         pacTelefono, pacDireccion
        │   │
        │   ├── 📁 data/
        │   │   └── 📁 repositories/
        │   │       └── 📄 paciente_repository_impl.dart
        │   │           # CRUD con Dio
        │   │           # GET /api/pacientes
        │   │           # POST /api/pacientes
        │   │           # PUT /api/pacientes/{dni}
        │   │           # DELETE /api/pacientes/{dni}
        │   │
        │   └── 📁 presentation/
        │       ├── 📁 providers/
        │       │   └── 📄 paciente_provider.dart
        │       │
        │       └── 📁 screens/
        │           ├── 📄 lista_pacientes_screen.dart
        │           │   # Lista con cards expandibles
        │           │   # Muestra nombre completo, DNI, teléfono
        │           │
        │           └── 📄 paciente_form_screen.dart
        │               # Formulario con 6 campos
        │               # Validación de DNI (8 dígitos)
        │
        └── 📁 historia_clinica/       # 📋 HISTORIAS CLÍNICAS
            ├── 📄 historia_clinica.dart # Barrel file
            │
            ├── 📁 domain/
            │   └── 📁 models/
            │       └── 📄 historia_clinica.dart
            │           # Campos: histId, pacDni, medCmp
            │           #         histFechaAtencion (DateTime)
            │           #         histDiagnostico, histAnalisis, histTratamiento
            │           # toJson() formatea fecha como yyyy-MM-dd
            │
            ├── 📁 data/
            │   └── 📁 repositories/
            │       └── 📄 historia_clinica_repository_impl.dart
            │           # CRUD con Dio
            │           # GET /api/historias-clinicas
            │           # POST /api/historias-clinicas
            │           # PUT /api/historias-clinicas/{id}
            │           # DELETE /api/historias-clinicas/{id}
            │
            └── 📁 presentation/
                ├── 📁 providers/
                │   └── 📄 historia_clinica_provider.dart
                │
                └── 📁 screens/
                    ├── 📄 lista_historias_screen.dart
                    │   # ExpansionTile con detalles
                    │   # Muestra pacNombreCompleto, medNombreCompleto
                    │   # Formato de fecha dd/MM/yyyy
                    │
                    └── 📄 historia_clinica_form_screen.dart
                        # DropdownButtonFormField para Paciente (isExpanded: true)
                        # DropdownButtonFormField para Médico (isExpanded: true)
                        # showDatePicker con locale español
                        # TextFormField multilínea para diagnóstico/análisis/tratamiento
```

## 🔄 Flujo de Datos

```
┌─────────────────────────────────────────────────────────────────┐
│                           FRONTEND                              │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  UI (Screens)  →  Provider  →  Repository  →  Dio HTTP Client  │
│       ↑              ↓                                          │
│       └──────────────┘                                          │
│    (notifyListeners)                                            │
│                                                                 │
└────────────────────────────────┬────────────────────────────────┘
                                 │
                                 │ HTTP (JSON)
                                 │
┌────────────────────────────────┴────────────────────────────────┐
│                           BACKEND                               │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  Spring Boot REST API  →  Service  →  Repository  →  MySQL DB  │
│                                                                 │
│  Endpoints:                                                     │
│  • /api/medicos                                                 │
│  • /api/pacientes                                               │
│  • /api/historias-clinicas                                      │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

## 🎨 Componentes UI Principales

### 1. Cards con ListTile
```dart
Card(
  child: ListTile(
    leading: CircleAvatar(...),
    title: Text(...),
    subtitle: Column(...),
    trailing: PopupMenuButton(...),
  ),
)
```

### 2. ExpansionTile (Historias)
```dart
Card(
  child: ExpansionTile(
    leading: CircleAvatar(...),
    title: Text(...),
    subtitle: Column(...),
    children: [
      Padding(
        child: Column(...),  // Detalles completos
      ),
    ],
  ),
)
```

### 3. NavigationBar (Bottom Tabs)
```dart
NavigationBar(
  destinations: [
    NavigationDestination(icon: ..., label: 'Historias'),
    NavigationDestination(icon: ..., label: 'Pacientes'),
    NavigationDestination(icon: ..., label: 'Médicos'),
  ],
)
```

### 4. DropdownButtonFormField
```dart
DropdownButtonFormField<String>(
  isExpanded: true,  // CRÍTICO
  decoration: InputDecoration(...),
  items: list.map((item) {
    return DropdownMenuItem(
      value: item.id,
      child: Text(
        item.displayText,
        overflow: TextOverflow.ellipsis,  // IMPORTANTE
      ),
    );
  }).toList(),
)
```

## 📦 Dependencias Clave

| Dependencia | Propósito | Uso |
|------------|-----------|-----|
| `provider` | State Management | MultiProvider, Consumer, ChangeNotifier |
| `dio` | HTTP Client | Comunicación con API REST |
| `google_fonts` | Tipografía | Roboto en todo el app |
| `flutter_screenutil` | Responsividad | Adaptación a diferentes pantallas |
| `shared_preferences` | Storage Local | Persistencia del tema |
| `intl` | Internacionalización | Formato de fechas en español |

## 🔐 Estado de Autenticación (Simplificado)

```
┌──────────────┐
│ LoginScreen  │
└──────┬───────┘
       │ Navigator.pushReplacementNamed('/home')
       ↓
┌────────────────────────┐
│ MainNavigationScreen   │
│  ├─ Historias Tab      │
│  ├─ Pacientes Tab      │
│  └─ Médicos Tab        │
└────────────────────────┘
```

## 🎯 Patrones de Diseño Implementados

1. **Repository Pattern**: Abstracción de fuentes de datos
2. **Provider Pattern**: State management reactivo
3. **Clean Architecture**: Separación de capas
4. **Barrel Files**: Exports organizados
5. **Factory Pattern**: fromJson constructors

## 📱 Navegación

```
/login  →  LoginScreen
              ↓ (pushReplacementNamed)
/home   →  MainNavigationScreen
              ├─ [0] ListaHistoriasScreen
              │       ↓ (push)
              │     HistoriaClinicaFormScreen
              │
              ├─ [1] ListaPacientesScreen
              │       ↓ (push)
              │     PacienteFormScreen
              │
              └─ [2] ListaMedicosScreen
                      ↓ (push)
                    MedicoFormScreen
```

## 🛡️ Manejo de Estados

Cada Provider maneja 3 estados:

```dart
class EntityProvider with ChangeNotifier {
  List<Entity> _entities = [];      // 📊 Datos
  bool _isLoading = false;          // ⏳ Cargando
  String? _errorMessage;            // ❌ Error
  
  // Getters públicos
  // Métodos CRUD que actualizan estados
  // notifyListeners() después de cambios
}
```

Visualización en UI:

```
┌─────────────────────────┐
│   Consumer<Provider>    │
└───────────┬─────────────┘
            │
     ┌──────┴──────┐
     │  isLoading? │
     └──────┬──────┘
            │
    ┌───────┴────────┐
    │ YES         NO │
    ↓                ↓
┌───────┐    ┌──────────────┐
│Spinner│    │ errorMessage?│
└───────┘    └──────┬───────┘
                    │
             ┌──────┴──────┐
             │ YES      NO │
             ↓             ↓
        ┌────────┐   ┌──────────┐
        │Error UI│   │isEmpty()?│
        └────────┘   └─────┬────┘
                           │
                    ┌──────┴──────┐
                    │ YES      NO │
                    ↓             ↓
              ┌──────────┐  ┌──────┐
              │Empty View│  │ListView│
              └──────────┘  └──────┘
```

---

**Esta arquitectura garantiza:**
- ✅ Separación de responsabilidades
- ✅ Código mantenible y escalable
- ✅ Testing simplificado
- ✅ Reutilización de componentes
- ✅ Estado predecible
