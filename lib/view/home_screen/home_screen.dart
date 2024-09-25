import 'package:api_session2/controller/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<HomeScreenController>().fetchData();
        },
      ),
      body: Center(
        child: Text(context.watch<HomeScreenController>().fact.toString()),
      ),
    );
  }
}
