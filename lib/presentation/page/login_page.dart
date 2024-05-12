import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialpreneur/presentation/bloc/profile_module/profile_event.dart';
import 'package:socialpreneur/presentation/injector.dart';
import 'package:socialpreneur/presentation/page/home_page.dart';
import 'package:socialpreneur/presentation/page/signup_page.dart';
import 'package:socialpreneur/presentation/util/desktop_padding.dart';
import 'package:socialpreneur/presentation/util/snackbar_util.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        // title: Text(
        //   appName.toUpperCase(),
        //   style: Theme.of(context).textTheme.labelLarge?.copyWith(
        //         color: Theme.of(context).colorScheme.primary,
        //         fontWeight: FontWeight.bold,
        //         letterSpacing: 7,
        //       ),
        // ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 250,
              width: double.infinity,
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Opacity(
                opacity: 0.85,
                child: SvgPicture.asset(
                  "assets/images/newsletter-model.svg",
                  height: 200,
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            DesktopPadding(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Welcome back to\nThe Future of Development",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "it's time to be a force for change",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.outline),
                    ),
                    const SizedBox(
                      height: 32,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextField(
                          obscureText: true,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14)),
                            labelText: 'Password',
                          ),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot Password',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: <Widget>[
                        FilledButton(
                          onPressed: () async {
                            //Implement login
                            showSnackbar(context, "Logging in...");
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text);
                              //Navigate forward
                              if (context.mounted) {
                                Injector.profileBloc.add(FetchProfileEvent(
                                    uid: FirebaseAuth
                                        .instance.currentUser!.uid));
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
                                case 'user-disabled':
                                  showSnackbar(
                                      context, 'Oops! User has been disabled.');
                                  break;
                                case 'user-not-found':
                                  showSnackbar(
                                      context, 'Oops! User not found.');
                                  break;
                                case 'wrong-password':
                                  showSnackbar(context,
                                      'Oops! Wrong password. Please try again.');
                                  break;
                                default:
                                  showSnackbar(context, e.message.toString());
                              }
                            }
                          },
                          child: Text(
                            'Log in',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SignUpPage()));
                          },
                          child: Text(
                            "Sign up",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
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
            ),
          ],
        ),
      ),
    );
  }
}

class OAuthLoginButton extends StatelessWidget {
  final String url;
  final double iconHeight;
  final Function() onTap;
  const OAuthLoginButton({
    super.key,
    required this.url,
    this.iconHeight = 22,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 100,
          height: 48,
          decoration: BoxDecoration(
              color:
                  Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.4),
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: SvgPicture.network(
              url,
              height: iconHeight,
            ),
          ),
        ),
      ),
    );
  }
}
