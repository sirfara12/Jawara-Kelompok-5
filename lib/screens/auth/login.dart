import 'dart:math' show max;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jawara_pintar_kel_5/constants/constant_colors.dart';
import 'package:jawara_pintar_kel_5/widget/login_button.dart';
import 'package:jawara_pintar_kel_5/widget/text_input_login.dart';
import 'package:moon_design/moon_design.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showLoginForm = false;

  final _loginFormHeight = 350.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final heightPercentage =
              constraints.maxHeight / MediaQuery.of(context).size.height;
          final mascoutHeight =
              MediaQuery.of(context).size.height * 0.4 * heightPercentage;
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text("Art from Bilibili"),
                  ),
                  AnimatedContainer(
                    duration: heightPercentage != 1.0
                        ? Duration.zero
                        : const Duration(milliseconds: 700),
                    curve: Curves.fastOutSlowIn,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    alignment: Alignment.center,
                    height: _showLoginForm
                        ? max(mascoutHeight - _loginFormHeight / 2, 50)
                        : mascoutHeight,
                    child: GestureDetector(
                      onTap: () => setState(() => _showLoginForm = false),
                      child: Image.asset("assets/bilibili_jawara.webp"),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 24,
                          right: 24,
                          bottom: 24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LayoutBuilder(
                              builder: (context, constraints) {
                                final textStyle =
                                    MediaQuery.of(context).size.height > 600
                                    ? MoonTokens.light.typography.heading.text48
                                    : MoonTokens
                                          .light
                                          .typography
                                          .heading
                                          .text24;
                                final children = [
                                  Text(
                                    "Jawara ",
                                    style: textStyle.copyWith(
                                      color: MoonTokens.light.colors.piccolo,
                                    ),
                                  ),
                                  Text("Pintar", style: textStyle),
                                ];
                                if (constraints.maxWidth < 300) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: children,
                                  );
                                }
                                return Row(children: children);
                              },
                            ),
                            const SizedBox(height: 4),
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 150),
                              opacity: _showLoginForm ? 0 : 1,
                              child: AnimatedContainer(
                                duration: heightPercentage != 1.0
                                    ? Duration.zero
                                    : const Duration(milliseconds: 300),
                                curve: Curves.easeInExpo,
                                height: _showLoginForm ? 0 : 145,
                                child: SingleChildScrollView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    spacing: 14,
                                    children: [
                                      loginUntukMengakses(),
                                      LoginButton(
                                        text: "Login",
                                        onTap: () => setState(() {
                                          _showLoginForm = !_showLoginForm;
                                        }),
                                      ),
                                      LoginButton(
                                        text: "Daftar",
                                        onTap: () => context.go("/register"),
                                        withColor: false,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      AnimatedContainer(
                        duration: heightPercentage != 1.0
                            ? Duration.zero
                            : const Duration(milliseconds: 300),
                        curve: Curves.easeInExpo,
                        height: _showLoginForm ? _loginFormHeight : 0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: MoonTokens.light.colors.goku,
                        ),
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 24.0,
                              left: 24,
                              bottom: 24,
                            ),
                            child: Column(
                              spacing: 14,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text(
                                  "Login",
                                  style: MoonTokens
                                      .light
                                      .typography
                                      .heading
                                      .text32
                                      .copyWith(
                                        color: MoonTokens.light.colors.piccolo,
                                      ),
                                ),
                                loginUntukMengakses(),
                                TextInputLogin(hint: 'Email'),
                                TextInputLogin(
                                  hint: 'Password',
                                  isPassword: true,
                                  trailing: Center(
                                    child: Text(
                                      'Show',
                                      style: MoonTokens
                                          .light
                                          .typography
                                          .body
                                          .text14
                                          .copyWith(
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                    ),
                                  ),
                                ),
                                LoginButton(
                                  text: "Login",
                                  onTap: () => setState(() {
                                    context.go('/admin/dashboard');
                                  }),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Belum terdaftar? ',
                                      style: MoonTokens
                                          .light
                                          .typography
                                          .body
                                          .text12
                                          .copyWith(
                                            color:
                                                ConstantColors.separatorColor,
                                          ),
                                    ),
                                    InkWell(
                                      onTap: () => context.go('/register'),
                                      child: Text(
                                        'Buat Akun',
                                        style: MoonTokens
                                            .light
                                            .typography
                                            .body
                                            .text12
                                            .copyWith(
                                              color:
                                                  MoonTokens.light.colors.whis,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Align loginUntukMengakses() {
    return Align(
      alignment: AlignmentGeometry.centerLeft,
      child: Text(
        'Login untuk mengakses sistem Jawara Pintar.',
        style: MoonTokens.light.typography.body.text14,
      ),
    );
  }
}
