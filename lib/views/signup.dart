import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  // Unieke sleutel om de Form te beheren
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  // Controllers om de waarden van de velden te lezen
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Signup"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formkey,
          child: ListView(
            children: [
              const Text(
                "Create account",
                style: TextStyle(fontFamily: 'Momo'),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              // Name field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your name';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
