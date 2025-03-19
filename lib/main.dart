
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:sizer/sizer.dart';
import 'core/services/dependency_injection.dart';
import 'core/utils/locales/locales.dart';
import 'core/utils/navigation_routes.dart';
import 'core/utils/themes/theme_bloc.dart';
import 'core/utils/themes/theme_event.dart';
import 'core/utils/themes/theme_state.dart';
import 'features/data/datasources/data_source_barrel.dart';
import 'features/data/repository/repository_impl_barrel.dart';
import 'features/presentation/views/auth/auth_barrel.dart';


void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  await setupLocator();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(
            RepositoryImpl(
              localDataSource: LocalDataSource(),
              remoteDataSource: null,
              networkInfo: null,
            ),
          )..add(FetchThemeEvent()),
        ),
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Sizer(
            builder: (context, orientation, deviceType) {
              return const MyApp();
            },
          );
        },
      ),
    ),
  );
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalization localization = FlutterLocalization.instance;

  @override
  void initState() {
    configureLocalization();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder(
      bloc: BlocProvider.of<ThemeBloc>(context),
      builder: (BuildContext context, ThemeState state) => MaterialApp(
        onGenerateRoute: Routes.generateRoute,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        supportedLocales: localization.supportedLocales,
        localizationsDelegates: localization.localizationsDelegates,
        theme: state.themeData,
        home: const Splash(),
        routes: const {},
      ),
    );
  }

  void configureLocalization() {
    localization.init(mapLocales: LOCALES, initLanguageCode: "en");
    localization.onTranslatedLanguage = onTranslateLanguage;
  }

  void onTranslateLanguage(Locale? locale) {
    setState(() {});
  }
}
