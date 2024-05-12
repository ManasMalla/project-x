import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialpreneur/presentation/bloc/profile_module/profile_event.dart';
import 'package:socialpreneur/presentation/injector.dart';
import 'package:socialpreneur/presentation/page/home_page.dart';
import 'package:socialpreneur/presentation/page/login_page.dart';
import 'package:socialpreneur/presentation/util/snackbar_util.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Set<String> _role = {"Innovator"};
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String? pronoun;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Get Started with\nThe Future of Development",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "it's time to be a force for change",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.outline),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      SegmentedButton<String>(
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14)))),
                        segments: [
                          ButtonSegment(
                            value: 'Investor',
                            label: Text("Investor"),
                            icon: Icon(Icons.monetization_on_outlined),
                          ),
                          ButtonSegment(
                            value: 'Innovator',
                            label: Text("Innovator"),
                            icon: Icon(Icons.science_outlined),
                          ),
                        ],
                        showSelectedIcon: false,
                        selected: _role,
                        onSelectionChanged: (_) {
                          setState(() {
                            _role = _;
                          });
                        },
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Divider(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14)),
                      labelText: 'Name',
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: pronoun,
                          items: ["he/him", "she/her", "they/them"]
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              pronoun = value;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14)),
                            labelText: 'Pronoun',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _locationController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14)),
                            labelText: 'Location',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14)),
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          obscureText: true,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14)),
                            labelText: 'Password',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: TextField(
                          obscureText: true,
                          controller: _confirmPasswordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14)),
                            labelText: 'Confirm Password',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  FilledButton(
                    onPressed: () async {
                      if (_nameController.text.isEmpty ||
                          _emailController.text.isEmpty ||
                          _locationController.text.isEmpty ||
                          _passwordController.text.isEmpty ||
                          pronoun == null) {
                        showSnackbar(context, "Please fill all fields");
                        return;
                      }
                      if (_confirmPasswordController.text !=
                          _passwordController.text) {
                        showSnackbar(context, "Passwords do not match");
                        return;
                      }

                      //Implement sign up
                      showSnackbar(context, "Signing you up...");
                      try {
                        //Create the user on Firebase Auth
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text);
                        final userId = FirebaseAuth.instance.currentUser?.uid;
                        //Add the details to the firestore database with userid
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(userId)
                            .set({
                          'name': _nameController.text,
                          'email': _emailController.text,
                          'location': _locationController.text,
                          'pronoun': pronoun,
                          'role': _role.toList(),
                          'profilePic': 0,
                        });
                        //Navigate forward
                        if (context.mounted) {
                          Injector.profileBloc.add(FetchProfileEvent(
                              uid: FirebaseAuth.instance.currentUser!.uid));
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        }
                      } on FirebaseAuthException catch (e) {
                        switch (e.code) {
                          case 'invalid-email':
                            showSnackbar(context,
                                'Oops! We couldn\'t find the email address.');
                            break;
                          case 'operation-not-allowed':
                            showSnackbar(context,
                                'Oops! Unable to sign up at the moment.');
                            break;
                          case 'email-already-in-use':
                            showSnackbar(context,
                                'Oops! Email already in use. Please sign in.');
                            Navigator.of(context).pop();
                            break;
                          case 'weak-password':
                            showSnackbar(context,
                                'Oops! Weak password. Please try again with a more secure password.');
                            break;
                          default:
                            showSnackbar(context, e.message.toString());
                        }
                      }
                    },
                    child: Text(
                      'Sign up',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Row(
                    children: <Widget>[
                      Text("Or continue with"),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      OAuthLoginButton(
                        url:
                            "https://upload.wikimedia.org/wikipedia/commons/c/c1/Google_%22G%22_logo.svg",
                        onTap: () {
                          showSnackbar(
                              context, 'Not implemented. Coming soon!');
                        },
                      ),
                      const SizedBox(width: 36),
                      OAuthLoginButton(
                        url:
                            "https://upload.wikimedia.org/wikipedia/commons/4/44/Microsoft_logo.svg",
                        iconHeight: 20,
                        onTap: () {
                          showSnackbar(
                              context, 'Not implemented. Coming soon!');
                        },
                      ),
                      const SizedBox(width: 36),
                      OAuthLoginButton(
                        url:
                            "https://upload.wikimedia.org/wikipedia/commons/5/53/X_logo_2023_original.svg",
                        iconHeight: 16,
                        onTap: () {
                          showSnackbar(
                              context, 'Not implemented. Coming soon!');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
