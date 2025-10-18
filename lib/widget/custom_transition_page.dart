import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A small helper that returns a [CustomTransitionPage] with a Play Store-like
/// animation: fade + slight upward slide + subtle scale.
///
/// Usage:
///   playStoreTransitionPage(key: state.pageKey, child: MyPage());
CustomTransitionPage<T> customTransitionPage<T>({
  required LocalKey key,
  required Widget child,
  Duration? transitionDuration,
}) {
  return CustomTransitionPage<T>(
    key: key,
    child: child,
    transitionDuration: transitionDuration ?? const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.04),
            end: Offset.zero,
          ).animate(curved),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.97, end: 1.0).animate(curved),
            child: child,
          ),
        ),
      );
    },
  );
}
