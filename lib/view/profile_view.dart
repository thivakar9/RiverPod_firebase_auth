import 'package:firebase_authentication/view/login_view.dart';
import 'package:firebase_authentication/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(authProvider);
    final box = Hive.box("auth");
    final value = box.get("email");
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            width: double.infinity,
            padding: const EdgeInsets.all(6.0),
            color: Colors.blue[200],
            child: const Text(
              "General",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
         Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "$value",
            style:const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
          ),
        ),
        const Divider(),
        InkWell(
          onTap: () async {
            await result.signOut();
            var name = MaterialPageRoute(builder: (_) => const LoginView());
            if (context.mounted) {
              Navigator.pushAndRemoveUntil(context, name, (route) => false);
            }
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(6.0),
            child: const Text(
              "Logout",
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
            ),
          ),
        ),
        const Divider(),
      ]),
    ));
  }
}
