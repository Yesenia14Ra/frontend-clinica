# Sistema de Gestión de Historias Clínicas

Aplicación móvil Flutter para la gestión de historias clínicas médicas con arquitectura limpia, conectada a un backend Spring Boot.

## 🏗️ Arquitectura

El proyecto sigue el patrón de **Clean Architecture** con las siguientes capas:

- **Domain**: Modelos de datos y entidades del negocio
- **Data**: Implementación de repositorios y fuentes de datos
- **Presentation**: UI, pantallas, providers y lógica de presentación

## 📁 Estructura del Proyecto

```
lib/
├── core/
│   ├── theme/           # Temas Material Design 3
│   ├── providers/       # Providers globales (Theme)
│   └── utils/           # Utilidades responsivas
├── features/
│   ├── auth/            # Autenticación
│   ├── home/            # Navegación principal
│   ├── medico/          # Gestión de médicos
│   ├── paciente/        # Gestión de pacientes
│   └── historia_clinica/ # Gestión de historias clínicas
└── main.dart
```

## 🚀 Características

### Gestión de Médicos
- Crear, leer, actualizar y eliminar médicos
- Campos: CMP, nombre, apellidos, especialidad

### Gestión de Pacientes
- CRUD completo de pacientes
- Campos: DNI, nombre, apellido paterno, apellido materno, teléfono, dirección

### Historias Clínicas
- Registro completo de atenciones médicas
- Relación con pacientes y médicos
- Campos: fecha de atención, diagnóstico, análisis, tratamiento
- Visualización expandible de detalles

## 🔧 Configuración

### Backend

Por defecto, la aplicación se conecta a:
- **URL Base**: `http://10.0.2.2:8080` (emulador Android)
- Para iOS/Web: cambiar a `http://localhost:8080`

### Endpoints

```
GET    /api/medicos
POST   /api/medicos
PUT    /api/medicos/{cmp}
DELETE /api/medicos/{cmp}

GET    /api/pacientes
POST   /api/pacientes
PUT    /api/pacientes/{dni}
DELETE /api/pacientes/{dni}

GET    /api/historias-clinicas
POST   /api/historias-clinicas
PUT    /api/historias-clinicas/{id}
DELETE /api/historias-clinicas/{id}
```

## 📦 Dependencias

- **provider**: State management
- **dio**: Cliente HTTP
- **google_fonts**: Fuentes personalizadas
- **flutter_screenutil**: Responsividad
- **shared_preferences**: Almacenamiento local
- **intl**: Internacionalización y formateo de fechas

## 🎨 UI/UX

- Material Design 3
- Tema claro y oscuro
- Internacionalización en español
- Diseño responsivo
- Navegación por tabs

## ⚙️ Instalación

1. Clonar el repositorio
2. Instalar dependencias:
   ```bash
   flutter pub get
   ```
3. Verificar configuración:
   ```bash
   flutter doctor
   ```
4. Ejecutar la aplicación:
   ```bash
   flutter run
   ```

## 🔑 Características Técnicas

### Modelos de Datos

Los modelos siguen la estructura del backend:

- **Médico**: `medCmp`, `medNombre`, `medApellidos`, `espeNombre`
- **Paciente**: `pacDni`, `pacNombre`, `pacApellidoPaterno`, `pacApellidoMaterno`, `pacTelefono`, `pacDireccion`
- **Historia Clínica**: `histId`, `pacDni`, `medCmp`, `histFechaAtencion`, `histDiagnostico`, `histAnalisis`, `histTratamiento`

### Formato de Fechas

Las fechas se envían al backend en formato `yyyy-MM-dd` (sin hora) para compatibilidad con `LocalDate` de Java.

### Campos Calculados

El backend calcula automáticamente:
- `nombreCompletoConEspecialidad` (Médico)
- `nombreCompleto` (Paciente)
- `pacNombreCompleto`, `pacTelefono`, `medNombreCompleto`, `medEspecialidad` (Historia Clínica)

Estos campos NO se envían en las peticiones POST/PUT.

## 📱 Pantallas

1. **Login**: Pantalla de inicio de sesión
2. **Home**: Navegación principal con 3 tabs
3. **Médicos**: Lista y formulario de médicos
4. **Pacientes**: Lista y formulario de pacientes
5. **Historias Clínicas**: Lista expandible y formulario con dropdowns

## 🛠️ Desarrollo

### Providers (State Management)

Cada feature tiene su provider:
- `MedicoProvider`
- `PacienteProvider`
- `HistoriaClinicaProvider`
- `ThemeProvider`

### Repositorios

Implementan la comunicación con el backend usando Dio:
- `MedicoRepositoryImpl`
- `PacienteRepositoryImpl`
- `HistoriaClinicaRepositoryImpl`

### Manejo de Errores

Todos los repositorios incluyen manejo de errores:
- Timeout de conexión
- Errores del servidor (400, 404, 500)
- Errores de red

## 📄 Licencia

Este proyecto es parte de un sistema académico de gestión hospitalaria.

## 👥 Autor

Desarrollado como proyecto académico de la Universidad Peruana Unión.
