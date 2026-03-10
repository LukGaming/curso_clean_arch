import 'package:flutter/widgets.dart';

class ErrorHabitsViewWidget extends StatelessWidget {
  final String error;
  const ErrorHabitsViewWidget({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return  Center(child: Text(error));
  }
}