import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socialpreneur/data/static/app_data.dart';
import 'package:socialpreneur/presentation/util/column_extension.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: const Color(0xFF042B67),
        // title: Text(
        //   appName.toUpperCase(),
        //   style: Theme.of(context).textTheme.labelLarge?.copyWith(
        //         color: Theme.of(context).colorScheme.primary,
        //         fontWeight: FontWeight.bold,
        //         letterSpacing: 7,
        //       ),
        // ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 250,
            width: double.infinity,
            color: const Color(0xFF042B67),
            child: Opacity(
              opacity: 0.7,
              child: SvgPicture.asset(
                "assets/images/newsletter-model.svg",
                height: 200,
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
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
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Theme.of(context).colorScheme.outline),
                ),
                const SizedBox(
                  height: 32,
                ),
                TextField(
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
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                      onPressed: () {
                        // Add login logic here
                      },
                      child: Text(
                        'Log in',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    OutlinedButton(
                      onPressed: () {},
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
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Not implemented. Coming soon!')));
                      },
                    ),
                    const SizedBox(width: 36),
                    OAuthLoginButton(
                      url:
                          "https://upload.wikimedia.org/wikipedia/commons/4/44/Microsoft_logo.svg",
                      iconHeight: 20,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Not implemented. Coming soon!')));
                      },
                    ),
                    const SizedBox(width: 36),
                    OAuthLoginButton(
                      url:
                          "https://upload.wikimedia.org/wikipedia/commons/5/53/X_logo_2023_original.svg",
                      iconHeight: 16,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Not implemented. Coming soon!')));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
