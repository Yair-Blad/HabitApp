import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/habit_provider.dart';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  String selectedIcon = "🏃‍♂️";
  Color selectedColor = Colors.deepPurple;

  final List<String> icons = ["🏃‍♂️", "💧", "📖", "🧘", "🍎", "🎸", "🌱", "💻", "🙏", "🎨", "🏋️", "🧠"];
  final List<Color> colors = [Colors.deepPurple, Colors.blue, Colors.green, Colors.orange, Colors.pink, Colors.red, Colors.teal, Colors.indigo, Colors.amber];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Hábito')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: '¿Qué hábito quieres crear?',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.trim().isEmpty ? 'Este campo es obligatorio' : null,
              ),
              const SizedBox(height: 30),
              const Text("Icono", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Wrap(spacing: 15, children: icons.map((icon) {
                return GestureDetector(
                  onTap: () => setState(() => selectedIcon = icon),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: selectedIcon == icon ? Colors.grey[300] : null,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(icon, style: const TextStyle(fontSize: 40)),
                  ),
                );
              }).toList()),
              const SizedBox(height: 30),
              const Text("Color", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Wrap(spacing: 12, children: colors.map((color) {
                return GestureDetector(
                  onTap: () => setState(() => selectedColor = color),
                  child: Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(color: selectedColor == color ? Colors.white : Colors.transparent, width: 4),
                    ),
                  ),
                );
              }).toList()),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Provider.of<HabitProvider>(context, listen: false).addHabit(
                        _nameController.text,
                        selectedIcon,
                        selectedColor,
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Crear Hábito', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}