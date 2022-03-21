import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuardScreen extends StatefulWidget {
  const GuardScreen({Key? key}) : super(key: key);

  @override
  State<GuardScreen> createState() => _GuardScreenState();
}

class _GuardScreenState extends State<GuardScreen> {
  // void isDeviceBeenConfigure

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<dynamic> snap) {
      return Container();
    });
  }
}
