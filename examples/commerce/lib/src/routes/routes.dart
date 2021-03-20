import 'package:auto_route/auto_route.dart';
import 'package:commerce/src/ui/screens/splash_screen.dart';

@MaterialAutoRouter(
  routes: [MaterialRoute<SplashScreen>(page: SplashScreen, initial: true)],
  routesClassName: "Routes",
)
class $AppRouter {}
