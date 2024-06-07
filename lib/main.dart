import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl_browser.dart';
import 'firebase_options.dart';
import 'view/cadastrar_view.dart';
import 'view/login_view.dart';
import 'view/principal_view.dart';
import 'view/reserva_detalhes_view.dart';
import 'view/perfil_usuario_view.dart';
import 'view/sobre_view.dart';
import 'view/reservas_view.dart';


Future<void> main() async {
  // Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Inicialização das localizações
  await initializeDateFormatting('pt_BR', null);

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reservas',
      initialRoute: 'login',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt', 'BR'), // Definindo o idioma para português do Brasil
      ],
      routes: {
        'login': (context) => LoginView(),
        'cadastrar': (context) => CadastrarView(),
        'principal': (context) => PrincipalView(),
        'reservaDetalhes': (context) => ReservaDetalhesView(nomeReserva: ''),
        'perfilUsuario': (context) => PerfilUsuarioView(),
        'sobre': (context) => SobreView(),
        'reservas': (context) => ReservasView(),
      },
    );
  }
}
