import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:regapp/firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Demo',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: const RegApp(),
  ));
}

class RegApp extends StatefulWidget {
  const RegApp({Key? key}) : super(key: key);

  @override
  State<RegApp> createState() => _RegAppState();
}

class _RegAppState extends State<RegApp> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            return Column(
              children: [
                TextField(
                  decoration:
                      const InputDecoration(hintText: 'Enter email here'),
                  controller: _email,
                  enableSuggestions: false, //önerileri kaldırır
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(
                  obscureText: true, //şifreli gösterir
                  enableSuggestions: false, //önerileri kaldırır
                  autocorrect: false, // otomatik doldurma yok
                  decoration: const InputDecoration(
                      hintText: 'Enter password here'), //yönlendirici alt metin
                  controller: _password,
                ),
                TextButton(
                  onPressed: () async {
                    final email = _email.text;
                    final password = _password.text;
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: email, password: password);
                  },
                  child: const Text('Register'),
                ),
              ],
            );
          }),
    );
  }
}
