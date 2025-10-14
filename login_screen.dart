import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'habit_tracker_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final String defaultUsername = 'testuser';
  final String defaultPassword = 'password123';

  Future<void> _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    // Vérification des champs vides
    if (username.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(
        msg: "Veuillez remplir tous les champs",
        backgroundColor: Colors.orange,
        textColor: Colors.white,
      );
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Vérifie les identifiants par défaut
    if (username == defaultUsername && password == defaultPassword) {
      await prefs.setString('name', 'Test User');
      await prefs.setString('username', username);
      await prefs.setInt('age', 25);
      await prefs.setString('country', 'United States');

      Fluttertoast.showToast(
        msg: "Connexion réussie 🎉",
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      // Redirige vers la page principale
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HabitTrackerScreen(username: username),
        ),
      );
    } else {
      await prefs.clear();
      Fluttertoast.showToast(
        msg: "Nom d'utilisateur ou mot de passe incorrect",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade700, Colors.blue.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Habitt',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 40),

                // Username Field
                _buildTextField(
                  controller: _usernameController,
                  hint: 'Enter Username',
                  icon: Icons.person,
                ),
                const SizedBox(height: 20),

                // Password Field
                _buildTextField(
                  controller: _passwordController,
                  hint: 'Enter Password',
                  icon: Icons.lock,
                  isPassword: true,
                ),
                const SizedBox(height: 20),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Fluttertoast.showToast(
                        msg: "Fonctionnalité non encore disponible",
                        backgroundColor: Colors.blueGrey,
                        textColor: Colors.white,
                      );
                    },
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Login Button
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  ),
                  child: const Text(
                    'Log in',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                const Text(
                  'or',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 10),

                // Sign Up Button
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  ),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 🔹 Widget réutilisable pour les TextFields
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.blue.shade700),
          hintText: hint,
          border: InputBorder.none,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }
}
