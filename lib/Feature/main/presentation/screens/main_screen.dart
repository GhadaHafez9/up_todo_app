import 'package:flutter/material.dart';
import 'package:up_todo/Feature/main/presentation/widgets/nav_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
          child: PresBottomnav()),
    );
  }
}
