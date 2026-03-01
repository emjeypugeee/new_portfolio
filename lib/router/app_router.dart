import 'package:go_router/go_router.dart';
import 'package:portfolio_v2/pages/home_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [GoRoute(path: '/', builder: (context, state) => HomePage())],
  );
}
