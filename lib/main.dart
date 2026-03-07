import 'package:curso_clean_arch/core/di/injector_container.dart';
import 'package:curso_clean_arch/my_app_widget.dart';
import 'package:flutter/material.dart';

void main() async {
  await initDependencies();
  runApp(const MyApp());
}
