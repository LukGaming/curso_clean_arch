import 'package:curso_clean_arch/core/di/injector_container.dart';
import 'package:curso_clean_arch/feature/habits/presentation/cubit/habits_cubit.dart';
import 'package:flutter/material.dart';

class HabitsFormDialog extends StatefulWidget {
  const HabitsFormDialog({super.key});

  @override
  State<HabitsFormDialog> createState() => _HabitsFormDialogState();
}

class _HabitsFormDialogState extends State<HabitsFormDialog> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final habitsCubit = sl<HabitsCubit>();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final title = _controller.text.trim();

    await habitsCubit.insertHabit(title);

    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Novo Hábito"),
      content: Form(
        key: _formKey,
        child: TextFormField(
          decoration: InputDecoration(labelText: "Título"),
          controller: _controller,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "Digite um título";
            }
            return null;
          },
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancelar"),
        ),
        ElevatedButton(onPressed: _submit, child: Text("Salvar")),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
