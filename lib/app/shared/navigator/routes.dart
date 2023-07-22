class Route {
  final String name;
  final List<Route> subRoutes;

  Route({required this.name, required this.subRoutes});
}

abstract class Routes {
  List<Route> routes = [Route(name: 'home', subRoutes: [])];
  navigateTo(String name);
}
