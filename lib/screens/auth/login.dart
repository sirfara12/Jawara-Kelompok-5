import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jawara_pintar_kel_5/widget/login_button.dart';
import 'package:moon_design/moon_design.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Art from Bilibili"),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Image.asset("assets/bilibili_jawara.webp"),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 350,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Jawara ",
                            style: MoonTokens.light.typography.heading.text48
                                .copyWith(
                                  color: MoonTokens.light.colors.piccolo,
                                ),
                          ),
                          Text(
                            "Pintar",
                            style: MoonTokens.light.typography.heading.text48,
                          ),
                        ],
                      ),
                      Text(
                        'Login untuk mengakses sistem Jawara Pintar.',
                        style: MoonTokens.light.typography.body.text14,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  spacing: 14,
                  children: [
                    LoginButton(text: "Login", onTap: () {}),
                    LoginButton(
                      text: "Daftar",
                      onTap: () => context.go("/register"),
                      withColor: false,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
