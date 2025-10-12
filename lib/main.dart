import 'package:flutter/material.dart';
import 'package:jawara_pintar_kel_5/router.dart';
import 'package:moon_design/moon_design.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Jawara Pintar',
      theme: ThemeData.light().copyWith(
        extensions: <ThemeExtension<dynamic>>[
          MoonTheme(tokens: MoonTokens.light),
        ],
      ),
      // darkTheme: ThemeData.dark().copyWith(
      //   extensions: <ThemeExtension<dynamic>>[
      //     MoonTheme(tokens: MoonTokens.dark),
      //   ],
      // ),
      routerConfig: router,
    );
  }
}
