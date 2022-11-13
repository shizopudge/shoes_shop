import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:shoes_app_ui_training/auth/auth_controller.dart';
import 'package:shoes_app_ui_training/common/loader.dart';
import 'package:shoes_app_ui_training/utils/styles.dart';

class LoginScreen extends ConsumerWidget {
  final bool isFromLogin;
  const LoginScreen({
    super.key,
    this.isFromLogin = true,
  });

  void signInWithGoogle(BuildContext context, WidgetRef ref) {
    ref
        .read(authControllerProvider.notifier)
        .signInWithGoogle(context, isFromLogin);
  }

  void signInAsGuest(WidgetRef ref, BuildContext context) {
    ref.read(authControllerProvider.notifier).signInAsGuest(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: isLoading
              ? const Loader()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/loginLogo.png',
                      height: 300,
                    ),
                    const Gap(25),
                    Text(
                      'Shoes Shop',
                      style: textstyle1.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                        color: Colors.blueGrey[400],
                      ),
                    ),
                    const Gap(25),
                    ElevatedButton(
                      onPressed: () => signInWithGoogle(context, ref),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(21),
                        ),
                        minimumSize: const Size(double.infinity, 80),
                      ),
                      child: Text(
                        'Sign in with Google',
                        style: textstyle1.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    const Gap(25),
                    TextButton(
                      onPressed: () => signInAsGuest(ref, context),
                      child: Text(
                        'Skip',
                        style: textstyle1.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
