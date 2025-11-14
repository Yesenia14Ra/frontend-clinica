import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/theme/theme.dart';
import 'core/providers/providers.dart';
import 'features/auth/auth.dart';
import 'features/home/home.dart';
import 'features/medico/medico.dart';
import 'features/paciente/paciente.dart';
import 'features/historia_clinica/historia_clinica.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
            ChangeNotifierProvider(create: (_) => MedicoProvider()),
            ChangeNotifierProvider(create: (_) => PacienteProvider()),
            ChangeNotifierProvider(create: (_) => HistoriaClinicaProvider()),
          ],
          child: Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return MaterialApp(
                title: 'Sistema de Historias Clínicas',
                debugShowCheckedModeBanner: false,
                
                // Configuración de localización en español
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('es', 'ES'),
                ],
                locale: const Locale('es', 'ES'),
                
                // Configuración de temas
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeProvider.themeMode,
                
                // Rutas de navegación
                initialRoute: '/login',
                routes: {
                  '/login': (context) => const LoginScreen(),
                  '/home': (context) => const MainNavigationScreen(),
                },
              );
            },
          ),
        );
      },
    );
  }
}
