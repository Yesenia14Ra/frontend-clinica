# 🚀 Guía de Inicio Rápido

## Prerrequisitos

Antes de ejecutar el proyecto, asegúrate de tener instalado:

1. **Flutter SDK** (versión 3.0.0 o superior)
   ```bash
   flutter --version
   ```

2. **Android Studio** o **Xcode** (para iOS)

3. **VS Code** (recomendado) con extensiones:
   - Flutter
   - Dart

## 📦 Instalación

### 1. Instalar Dependencias

```bash
flutter pub get
```

### 2. Verificar Configuración

```bash
flutter doctor
```

Asegúrate de que todos los checks estén en verde ✓

## ⚙️ Configuración del Backend

### Opción 1: Emulador Android

El proyecto está configurado por defecto para:
```
http://10.0.2.2:8080
```

**No requiere cambios si usas emulador Android.**

### Opción 2: iOS Simulator

Cambiar en cada repositorio (`lib/features/*/data/repositories/*_repository_impl.dart`):

```dart
baseUrl: 'http://localhost:8080'
```

### Opción 3: Dispositivo Físico

1. Obtener IP de tu computadora:
   - Windows: `ipconfig` → buscar "IPv4 Address"
   - Mac/Linux: `ifconfig` → buscar "inet"

2. Cambiar en repositorios:
   ```dart
   baseUrl: 'http://TU_IP:8080'  // ej: http://192.168.1.100:8080
   ```

3. Asegurar que dispositivo y PC estén en la misma red WiFi

## 🏃 Ejecutar la Aplicación

### Opción 1: Con VS Code

1. Abrir el proyecto en VS Code
2. Presionar `F5` o click en "Run" → "Start Debugging"
3. Seleccionar dispositivo/emulador

### Opción 2: Terminal

```bash
# Listar dispositivos disponibles
flutter devices

# Ejecutar en modo debug
flutter run

# Ejecutar en dispositivo específico
flutter run -d <device_id>

# Ejecutar en modo release (más rápido)
flutter run --release
```

## 🔧 Comandos Útiles

### Limpiar Proyecto

```bash
flutter clean
flutter pub get
```

### Ver Logs

```bash
flutter logs
```

### Generar APK (Android)

```bash
flutter build apk --release
```

El APK se generará en: `build/app/outputs/flutter-apk/app-release.apk`

### Generar IPA (iOS)

```bash
flutter build ios --release
```

## 📱 Probar la Aplicación

### 1. Iniciar Backend Spring Boot

Asegúrate de que tu servidor Spring Boot esté corriendo en el puerto 8080:

```bash
# En el directorio del backend
./mvnw spring-boot:run
# o
java -jar target/tu-aplicacion.jar
```

### 2. Verificar Conectividad

Prueba desde el navegador:
- Emulador Android: `http://10.0.2.2:8080/api/medicos`
- iOS/Otros: `http://localhost:8080/api/medicos`

### 3. Usar la Aplicación

1. **Login**: Usuario y contraseña (actualmente sin validación)
2. **Navegación**: 3 tabs principales
   - 📋 Historias Clínicas
   - 👥 Pacientes
   - 👨‍⚕️ Médicos

3. **CRUD**: Botón flotante (+) para crear nuevos registros

## 🐛 Solución de Problemas

### Error: "Unable to connect to the server"

**Causa**: Backend no está corriendo o URL incorrecta

**Solución**:
1. Verificar que Spring Boot esté corriendo
2. Verificar la URL base en los repositorios
3. Verificar firewall

### Error: "Gradle build failed"

**Solución**:
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

### Error: "CocoaPods not installed" (iOS)

**Solución**:
```bash
sudo gem install cocoapods
cd ios
pod install
cd ..
flutter run
```

### Error: "Hot reload not working"

**Solución**:
1. Presionar `r` en terminal para hot reload manual
2. Presionar `R` para hot restart
3. Detener y reiniciar la app

### Error de compilación con intl

**Solución**:
```bash
flutter pub cache repair
flutter clean
flutter pub get
```

## 📊 Estados de la Aplicación

### Conexión Exitosa
- ✅ Lista de entidades visible
- ✅ CRUD funcional
- ✅ Mensajes de éxito en verde

### Sin Datos
- ℹ️ Mensaje "No hay registros"
- ✅ Botón (+) para crear

### Error de Conexión
- ❌ Icono de error rojo
- ❌ Mensaje descriptivo
- 🔄 Botón "Reintentar"

## 🎯 Pruebas Recomendadas

1. **Crear Médico**
   - CMP: 12345
   - Nombre: Juan
   - Apellidos: Pérez García
   - Especialidad: Cardiología

2. **Crear Paciente**
   - DNI: 12345678 (8 dígitos)
   - Nombre: María
   - Apellido Paterno: López
   - Apellido Materno: Rodríguez
   - Teléfono: 987654321
   - Dirección: Av. Principal 123

3. **Crear Historia Clínica**
   - Seleccionar paciente
   - Seleccionar médico
   - Seleccionar fecha
   - Ingresar diagnóstico, análisis y tratamiento

## 📝 Notas Adicionales

- **Hot Reload**: Presiona `r` para ver cambios sin reiniciar
- **DevTools**: Presiona `d` para abrir Flutter DevTools
- **Logs**: Todos los errores HTTP se muestran en consola
- **Estado**: Provider mantiene el estado entre navegaciones

## 🔗 Recursos

- [Documentación Flutter](https://flutter.dev/docs)
- [Flutter Cookbook](https://flutter.dev/docs/cookbook)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Material Design 3](https://m3.material.io/)

## 📞 Soporte

Si encuentras problemas:
1. Revisa el archivo `NOTAS_IMPORTANTES.md`
2. Consulta los logs de Flutter
3. Verifica la consola del backend Spring Boot
4. Revisa la documentación de las dependencias

---

**¡Listo para desarrollar!** 🎉
