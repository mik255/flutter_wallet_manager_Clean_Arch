import 'package:flutter/cupertino.dart';


class StateBindListenerWithListenable extends StatelessWidget {
  const StateBindListenerWithListenable({
    super.key,
    required this.child,
    required this.states,
  });

  final Widget child;
  final List<Listenable> states;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(states),
      builder: (context, _) => child,
    );
  }
}
