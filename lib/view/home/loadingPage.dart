import 'package:flutter/material.dart';
import 'package:wallet_manager/shared/main_stances.dart';

import 'home_page.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key, this.id});

  final String? id;

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    if (widget.id != null) {
      MainStances.plugglyService.getAccount(widget.id!);
    } else {
      MainStances.init();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedBuilder(
          animation: MainStances.loading,
          builder: (context, _) {
            if (MainStances.loading.value == false) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              });
            }
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }),
    );
  }
}
