import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/app/app_cubit.dart';
import 'package:todo_app/auth/authentication_repository.dart';
import 'package:todo_app/auth/firebase_auth_service.dart';
import 'package:todo_app/ui/login/login_page.dart';
import 'package:todo_app/ui/main/main_page.dart';
import 'package:todo_app/ui/splash/splash.dart';
import 'package:todo_app/utils/enums/authentication_status.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale("vi"), Locale("en")],
      path: "assets/translations",
      child: const App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthenticationRepository _authenticationRepository;
  late final FirebaseAuthService _firebaseAuthService;

  @override
  void initState() {
    super.initState();
    // Initialize the services
    _firebaseAuthService = FirebaseAuthService();
    _authenticationRepository = AuthenticationRepositoryImpl(
      firebaseAuthService: _firebaseAuthService,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => _authenticationRepository),
      ],
      child: BlocProvider(
        create: (BuildContext context) {
          return AppCubit(authenticationRepository: _authenticationRepository);
        },
        child: const TodoApp(),
      ),
    );
  }
}

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      navigatorKey: _navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: GoogleFonts.lato().fontFamily,
      ),
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return BlocListener<AppCubit, AppState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigatorKey.currentState!.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const MainPage()),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigatorKey.currentState!.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unknown:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) {
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      },
      //home: const LoginPage(),
    );
  }
}
