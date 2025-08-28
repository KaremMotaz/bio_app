import 'package:bio_app/core/widgets/no_internet_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NoInternetRouter {
  static RouterConfig<Object> createRouter({
    required bool isConnected,
  }) {
    return GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) =>
              NoInternetView(isConnected: isConnected),
        ),
      ],
    );
  }
}
