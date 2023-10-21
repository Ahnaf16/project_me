import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:project_me/route/route_config.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  usePathUrlStrategy();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const FlexScheme usedScheme = FlexScheme.mallardGreen;
    final routes = ref.watch(routesProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: routes,
      theme: FlexThemeData.light(
        scheme: usedScheme,
        appBarElevation: 0.5,
        useMaterial3: true,
        textTheme: GoogleFonts.sourceCodeProTextTheme(),
        typography: Typography.material2021(platform: defaultTargetPlatform),
      ),
      darkTheme: FlexThemeData.dark(
        scheme: usedScheme,
        appBarElevation: 2,
        useMaterial3: true,
        textTheme: GoogleFonts.sourceCodeProTextTheme(),
        typography: Typography.material2021(platform: defaultTargetPlatform),
      ),
      themeMode: ThemeMode.light,
    );
  }
}
