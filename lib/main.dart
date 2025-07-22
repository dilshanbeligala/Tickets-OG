import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sizer/sizer.dart';

import 'package:tickets_og/features/presentation/views/main/base.dart';
import 'core/services/dependency_injection.dart';
import 'core/utils/navigation_routes.dart';
import 'core/utils/themes/theme_bloc.dart';
import 'core/utils/themes/theme_event.dart';
import 'core/utils/themes/theme_state.dart';
import 'features/data/datasources/data_source_barrel.dart';
import 'features/data/repository/repository_impl_barrel.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
  ));
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
  @override
  void initState() {
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
        theme: state.themeData,
        home: Base(),
        routes: const {},
      ),
    );
  }
}
