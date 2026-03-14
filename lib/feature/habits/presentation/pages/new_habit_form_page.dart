import 'package:curso_clean_arch/core/di/injector_container.dart';
import 'package:curso_clean_arch/feature/habits/presentation/cubit/habits_cubit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewHabitFormPage extends StatefulWidget {
  const NewHabitFormPage({super.key});

  @override
  State<NewHabitFormPage> createState() => _NewHabitFormPageState();
}

class _NewHabitFormPageState extends State<NewHabitFormPage> {
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
    return Scaffold(
      appBar: AppBar(title: Text("Novo hábito")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Título"),
                controller: _controller,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Digite um título";
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: Text("Cancelar"),
                  ),
                  ElevatedButton(onPressed: _submit, child: Text("Salvar")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
