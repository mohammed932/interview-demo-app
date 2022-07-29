// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i3;
import 'package:base_flutter/landing/details/details.imports.dart' as _i2;
import 'package:base_flutter/landing/home/home.imports.dart' as _i1;
import 'package:base_flutter/landing/home/models/user/user_model.dart' as _i5;
import 'package:flutter/material.dart' as _i4;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    HomeScreenRoute.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData, child: _i1.HomeScreen());
    },
    DetailsScreenRoute.name: (routeData) {
      final args = routeData.argsAs<DetailsScreenRouteArgs>();
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i2.DetailsScreen(userModel: args.userModel));
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(HomeScreenRoute.name, path: '/'),
        _i3.RouteConfig(DetailsScreenRoute.name, path: '/details-screen')
      ];
}

/// generated route for
/// [_i1.HomeScreen]
class HomeScreenRoute extends _i3.PageRouteInfo<void> {
  const HomeScreenRoute() : super(HomeScreenRoute.name, path: '/');

  static const String name = 'HomeScreenRoute';
}

/// generated route for
/// [_i2.DetailsScreen]
class DetailsScreenRoute extends _i3.PageRouteInfo<DetailsScreenRouteArgs> {
  DetailsScreenRoute({required _i5.UserModel userModel})
      : super(DetailsScreenRoute.name,
            path: '/details-screen',
            args: DetailsScreenRouteArgs(userModel: userModel));

  static const String name = 'DetailsScreenRoute';
}

class DetailsScreenRouteArgs {
  const DetailsScreenRouteArgs({required this.userModel});

  final _i5.UserModel userModel;

  @override
  String toString() {
    return 'DetailsScreenRouteArgs{userModel: $userModel}';
  }
}
