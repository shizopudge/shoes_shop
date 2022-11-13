import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shoes_app_ui_training/auth/auth_controller.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({super.key});

  void logOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logOut();
  }

  // void navigateToUserProfile(BuildContext context, String uid) {
  //   Routemaster.of(context).push('/u/$uid');
  // }
  void navigateToShoeScreen(BuildContext context) {
    Routemaster.of(context).push('/purchases-history');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.avatar),
              radius: 70,
            ),
            const Gap(10),
            Text(
              user.name,
              style: const TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 255, 191, 0),
                fontWeight: FontWeight.w500,
              ),
            ),
            const Gap(10),
            const Divider(),
            ListTile(
              title: const Text('Purchases'),
              leading: const Icon(
                Icons.attach_money_outlined,
                color: Colors.green,
              ),
              onTap: () => navigateToShoeScreen(context),
            ),
            ListTile(
              title: const Text('Log out'),
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              onTap: () => logOut(ref),
            ),
            // Switch.adaptive(
            //   value: ref.watch(themeNotifierProvider.notifier).mode ==
            //       ThemeMode.dark,
            //   onChanged: (value) => toggleTheme(ref),
            // ),
          ],
        ),
      ),
    );
  }
}
