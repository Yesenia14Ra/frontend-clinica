# 🔌 Ejemplos de Peticiones HTTP - API REST

## Base URL

```
http://10.0.2.2:8080/api  (Emulador Android)
http://localhost:8080/api  (iOS/Web/Desktop)
```

---

## 👨‍⚕️ Médicos

### GET - Listar todos los médicos

**Request:**
```http
GET /api/medicos
```

**Response (200 OK):**
```json
[
  {
    "medCmp": "12345",
    "medNombre": "Juan",
    "medApellidos": "Pérez García",
    "espeNombre": "Cardiología",
    "nombreCompletoConEspecialidad": "Juan Pérez García - Cardiología"
  },
  {
    "medCmp": "67890",
    "medNombre": "María",
    "medApellidos": "López Rodríguez",
    "espeNombre": "Pediatría",
    "nombreCompletoConEspecialidad": "María López Rodríguez - Pediatría"
  }
]
```

### GET - Obtener médico por CMP

**Request:**
```http
GET /api/medicos/12345
```

**Response (200 OK):**
```json
{
  "medCmp": "12345",
  "medNombre": "Juan",
  "medApellidos": "Pérez García",
  "espeNombre": "Cardiología",
  "nombreCompletoConEspecialidad": "Juan Pérez García - Cardiología"
}
```

**Response (404 Not Found):**
```json
{
  "timestamp": "2024-11-13T10:30:00",
  "status": 404,
  "error": "Not Found",
  "message": "Médico no encontrado",
  "path": "/api/medicos/99999"
}
```

### POST - Crear médico

**Request:**
```http
POST /api/medicos
Content-Type: application/json

{
  "medCmp": "54321",
  "medNombre": "Carlos",
  "medApellidos": "Ramírez Torres",
  "espeNombre": "Traumatología"
}
```

**Response (201 Created):**
```json
{
  "medCmp": "54321",
  "medNombre": "Carlos",
  "medApellidos": "Ramírez Torres",
  "espeNombre": "Traumatología",
  "nombreCompletoConEspecialidad": "Carlos Ramírez Torres - Traumatología"
}
```

**Response (400 Bad Request):**
```json
{
  "timestamp": "2024-11-13T10:30:00",
  "status": 400,
  "error": "Bad Request",
  "message": "CMP ya existe",
  "path": "/api/medicos"
}
```

### PUT - Actualizar médico

**Request:**
```http
PUT /api/medicos/54321
Content-Type: application/json

{
  "medCmp": "54321",
  "medNombre": "Carlos Alberto",
  "medApellidos": "Ramírez Torres",
  "espeNombre": "Traumatología y Ortopedia"
}
```

**Response (200 OK):**
```json
{
  "medCmp": "54321",
  "medNombre": "Carlos Alberto",
  "medApellidos": "Ramírez Torres",
  "espeNombre": "Traumatología y Ortopedia",
  "nombreCompletoConEspecialidad": "Carlos Alberto Ramírez Torres - Traumatología y Ortopedia"
}
```

### DELETE - Eliminar médico

**Request:**
```http
DELETE /api/medicos/54321
```

**Response (204 No Content):**
```
(Sin contenido)
```

**Response (404 Not Found):**
```json
{
  "timestamp": "2024-11-13T10:30:00",
  "status": 404,
  "error": "Not Found",
  "message": "Médico no encontrado",
  "path": "/api/medicos/54321"
}
```

---

## 👥 Pacientes

### GET - Listar todos los pacientes

**Request:**
```http
GET /api/pacientes
```

**Response (200 OK):**
```json
[
  {
    "pacDni": "12345678",
    "pacNombre": "Ana",
    "pacApellidoPaterno": "García",
    "pacApellidoMaterno": "Flores",
    "pacTelefono": "987654321",
    "pacDireccion": "Av. Principal 123",
    "nombreCompleto": "Ana García Flores"
  },
  {
    "pacDni": "87654321",
    "pacNombre": "Luis",
    "pacApellidoPaterno": "Martínez",
    "pacApellidoMaterno": "Sánchez",
    "pacTelefono": "912345678",
    "pacDireccion": "Jr. Secundaria 456",
    "nombreCompleto": "Luis Martínez Sánchez"
  }
]
```

### GET - Obtener paciente por DNI

**Request:**
```http
GET /api/pacientes/12345678
```

**Response (200 OK):**
```json
{
  "pacDni": "12345678",
  "pacNombre": "Ana",
  "pacApellidoPaterno": "García",
  "pacApellidoMaterno": "Flores",
  "pacTelefono": "987654321",
  "pacDireccion": "Av. Principal 123",
  "nombreCompleto": "Ana García Flores"
}
```

### POST - Crear paciente

**Request:**
```http
POST /api/pacientes
Content-Type: application/json

{
  "pacDni": "11223344",
  "pacNombre": "Pedro",
  "pacApellidoPaterno": "Hernández",
  "pacApellidoMaterno": "Cruz",
  "pacTelefono": "998877665",
  "pacDireccion": "Calle Terciaria 789"
}
```

**Response (201 Created):**
```json
{
  "pacDni": "11223344",
  "pacNombre": "Pedro",
  "pacApellidoPaterno": "Hernández",
  "pacApellidoMaterno": "Cruz",
  "pacTelefono": "998877665",
  "pacDireccion": "Calle Terciaria 789",
  "nombreCompleto": "Pedro Hernández Cruz"
}
```

### PUT - Actualizar paciente

**Request:**
```http
PUT /api/pacientes/11223344
Content-Type: application/json

{
  "pacDni": "11223344",
  "pacNombre": "Pedro Antonio",
  "pacApellidoPaterno": "Hernández",
  "pacApellidoMaterno": "Cruz",
  "pacTelefono": "998877666",
  "pacDireccion": "Calle Terciaria 789 - Dpto 2B"
}
```

**Response (200 OK):**
```json
{
  "pacDni": "11223344",
  "pacNombre": "Pedro Antonio",
  "pacApellidoPaterno": "Hernández",
  "pacApellidoMaterno": "Cruz",
  "pacTelefono": "998877666",
  "pacDireccion": "Calle Terciaria 789 - Dpto 2B",
  "nombreCompleto": "Pedro Antonio Hernández Cruz"
}
```

### DELETE - Eliminar paciente

**Request:**
```http
DELETE /api/pacientes/11223344
```

**Response (204 No Content):**
```
(Sin contenido)
```

---

## 📋 Historias Clínicas

### GET - Listar todas las historias

**Request:**
```http
GET /api/historias-clinicas
```

**Response (200 OK):**
```json
[
  {
    "histId": 1,
    "pacDni": "12345678",
    "pacNombreCompleto": "Ana García Flores",
    "pacTelefono": "987654321",
    "medCmp": "12345",
    "medNombreCompleto": "Juan Pérez García",
    "medEspecialidad": "Cardiología",
    "histFechaAtencion": "2024-11-13",
    "histDiagnostico": "Hipertensión arterial",
    "histAnalisis": "Presión arterial elevada, 140/90 mmHg",
    "histTratamiento": "Enalapril 10mg cada 12 horas"
  },
  {
    "histId": 2,
    "pacDni": "87654321",
    "pacNombreCompleto": "Luis Martínez Sánchez",
    "pacTelefono": "912345678",
    "medCmp": "67890",
    "medNombreCompleto": "María López Rodríguez",
    "medEspecialidad": "Pediatría",
    "histFechaAtencion": "2024-11-14",
    "histDiagnostico": "Faringitis aguda",
    "histAnalisis": "Inflamación de faringe, fiebre 38.5°C",
    "histTratamiento": "Amoxicilina 500mg cada 8 horas por 7 días"
  }
]
```

### GET - Obtener historia por ID

**Request:**
```http
GET /api/historias-clinicas/1
```

**Response (200 OK):**
```json
{
  "histId": 1,
  "pacDni": "12345678",
  "pacNombreCompleto": "Ana García Flores",
  "pacTelefono": "987654321",
  "medCmp": "12345",
  "medNombreCompleto": "Juan Pérez García",
  "medEspecialidad": "Cardiología",
  "histFechaAtencion": "2024-11-13",
  "histDiagnostico": "Hipertensión arterial",
  "histAnalisis": "Presión arterial elevada, 140/90 mmHg",
  "histTratamiento": "Enalapril 10mg cada 12 horas"
}
```

### POST - Crear historia clínica

**Request:**
```http
POST /api/historias-clinicas
Content-Type: application/json

{
  "pacDni": "12345678",
  "medCmp": "12345",
  "histFechaAtencion": "2024-11-15",
  "histDiagnostico": "Control rutinario",
  "histAnalisis": "Presión arterial normal, 120/80 mmHg",
  "histTratamiento": "Continuar con tratamiento actual"
}
```

**IMPORTANTE:** 
- **NO** incluir: `histId`, `pacNombreCompleto`, `pacTelefono`, `medNombreCompleto`, `medEspecialidad`
- Fecha en formato: `yyyy-MM-dd` (sin hora)

**Response (201 Created):**
```json
{
  "histId": 3,
  "pacDni": "12345678",
  "pacNombreCompleto": "Ana García Flores",
  "pacTelefono": "987654321",
  "medCmp": "12345",
  "medNombreCompleto": "Juan Pérez García",
  "medEspecialidad": "Cardiología",
  "histFechaAtencion": "2024-11-15",
  "histDiagnostico": "Control rutinario",
  "histAnalisis": "Presión arterial normal, 120/80 mmHg",
  "histTratamiento": "Continuar con tratamiento actual"
}
```

**Response (400 Bad Request):**
```json
{
  "timestamp": "2024-11-13T10:30:00",
  "status": 400,
  "error": "Bad Request",
  "message": "Paciente con DNI 99999999 no encontrado",
  "path": "/api/historias-clinicas"
}
```

### PUT - Actualizar historia clínica

**Request:**
```http
PUT /api/historias-clinicas/3
Content-Type: application/json

{
  "pacDni": "12345678",
  "medCmp": "12345",
  "histFechaAtencion": "2024-11-15",
  "histDiagnostico": "Control rutinario - Buena evolución",
  "histAnalisis": "Presión arterial normal, 120/80 mmHg. Peso estable.",
  "histTratamiento": "Continuar con tratamiento actual. Próximo control en 3 meses."
}
```

**Response (200 OK):**
```json
{
  "histId": 3,
  "pacDni": "12345678",
  "pacNombreCompleto": "Ana García Flores",
  "pacTelefono": "987654321",
  "medCmp": "12345",
  "medNombreCompleto": "Juan Pérez García",
  "medEspecialidad": "Cardiología",
  "histFechaAtencion": "2024-11-15",
  "histDiagnostico": "Control rutinario - Buena evolución",
  "histAnalisis": "Presión arterial normal, 120/80 mmHg. Peso estable.",
  "histTratamiento": "Continuar con tratamiento actual. Próximo control en 3 meses."
}
```

### DELETE - Eliminar historia clínica

**Request:**
```http
DELETE /api/historias-clinicas/3
```

**Response (204 No Content):**
```
(Sin contenido)
```

---

## 🔧 Códigos de Estado HTTP

| Código | Significado | Uso |
|--------|-------------|-----|
| **200** | OK | GET/PUT exitoso |
| **201** | Created | POST exitoso |
| **204** | No Content | DELETE exitoso |
| **400** | Bad Request | Datos inválidos o violación de reglas |
| **404** | Not Found | Recurso no existe |
| **500** | Internal Server Error | Error del servidor |

---

## 🧪 Probar con cURL

### Listar médicos
```bash
curl http://localhost:8080/api/medicos
```

### Crear médico
```bash
curl -X POST http://localhost:8080/api/medicos \
  -H "Content-Type: application/json" \
  -d '{
    "medCmp": "99999",
    "medNombre": "Test",
    "medApellidos": "Usuario",
    "espeNombre": "Medicina General"
  }'
```

### Actualizar médico
```bash
curl -X PUT http://localhost:8080/api/medicos/99999 \
  -H "Content-Type: application/json" \
  -d '{
    "medCmp": "99999",
    "medNombre": "Test Actualizado",
    "medApellidos": "Usuario",
    "espeNombre": "Medicina General"
  }'
```

### Eliminar médico
```bash
curl -X DELETE http://localhost:8080/api/medicos/99999
```

---

## 📝 Notas Importantes

### Campos Calculados (NO enviar en POST/PUT)

**Médico:**
- ❌ `nombreCompletoConEspecialidad`

**Paciente:**
- ❌ `nombreCompleto`

**Historia Clínica:**
- ❌ `histId` (en POST)
- ❌ `pacNombreCompleto`
- ❌ `pacTelefono`
- ❌ `medNombreCompleto`
- ❌ `medEspecialidad`

### Formato de Fecha

**Backend espera:** `yyyy-MM-dd` (sin hora)

✅ Correcto: `"2024-11-13"`  
❌ Incorrecto: `"2024-11-13T10:30:00"`  
❌ Incorrecto: `"13/11/2024"`

### Validaciones

**Médico:**
- `medCmp`: Único, obligatorio
- `medNombre`: Obligatorio
- `medApellidos`: Obligatorio
- `espeNombre`: Obligatorio

**Paciente:**
- `pacDni`: 8 dígitos, único, obligatorio
- `pacNombre`: Obligatorio
- `pacApellidoPaterno`: Obligatorio
- `pacApellidoMaterno`: Obligatorio
- `pacTelefono`: Obligatorio
- `pacDireccion`: Obligatorio

**Historia Clínica:**
- `pacDni`: Debe existir en tabla Pacientes
- `medCmp`: Debe existir en tabla Medicos
- `histFechaAtencion`: Obligatorio
- `histDiagnostico`: Obligatorio
- `histAnalisis`: Obligatorio
- `histTratamiento`: Obligatorio

---

## 🔍 Debugging

### Verificar servidor
```bash
curl http://localhost:8080/actuator/health
```

### Ver logs del backend
```bash
tail -f logs/spring-boot-application.log
```

### Verificar conectividad desde emulador Android
```bash
# Desde el emulador
curl http://10.0.2.2:8080/api/medicos
```

---

**¡API REST lista para integrarse con Flutter!** 🚀
