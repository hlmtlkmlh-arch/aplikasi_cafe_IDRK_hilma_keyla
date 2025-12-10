import 'package:flutter/material.dart';
import '../../services/auth_service.dart';


class RegisterScreen extends StatefulWidget {
const RegisterScreen({super.key});


@override
State<RegisterScreen> createState() => _RegisterScreenState();
}


class _RegisterScreenState extends State<RegisterScreen> {
final _email = TextEditingController();
final _pass = TextEditingController();
final AuthService _auth = AuthService();
bool _loading = false;


@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text('Register')),
body: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email')),
const SizedBox(height: 12),
TextField(controller: _pass, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
const SizedBox(height: 20),
ElevatedButton(
onPressed: _loading ? null : () async {
setState(() => _loading = true);
try {
await _auth.register(_email.text.trim(), _pass.text.trim());
Navigator.pop(context);
} catch (e) {
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
  setState(() => _loading = false);
    }
      },
       child: _loading ? const CircularProgressIndicator() : const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}