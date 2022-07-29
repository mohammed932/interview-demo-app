part of 'router.imports.dart';

@AdaptiveAutoRouter(
  routes: <AutoRoute>[
    AdaptiveRoute(
      initial: true,
      page: HomeScreen,
    ),
    AdaptiveRoute(
      page: DetailsScreen,
    ),
  ],
)
class $AppRouter {}
