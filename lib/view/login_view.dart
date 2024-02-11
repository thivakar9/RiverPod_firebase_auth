import 'package:firebase_authentication/view/dashboard_view.dart';
import 'package:firebase_authentication/view_model/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(child: Consumer(builder: (_, ref, child) {
        final authRef = ref.watch(authProvider);
        Future<void> onPressedFunction() async {
          final box = await Hive.openBox("auth");
          if (context.mounted) {
            if (!loginKey.currentState!.validate()) {
              return;
            }
            final res = await authRef.signinWithEmailAndPassword(
                emailController.text, passwordController.text, context);

            if (res?.user?.email != null) {
              debugPrint("authcredential is${res!.user!.email}");
              await box.put("email", res.user?.email);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("SuccessFully login")));
                var name =
                    MaterialPageRoute(builder: (_) => const DashboardView());
                // ignore: use_build_context_synchronously
                Navigator.pushAndRemoveUntil(context, name, (route) => false);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("user credential is wrong!!!")));
              }
            }
          }
          return;
        }

        return Form(
            key: loginKey,
            child: Column(children: [
              Expanded(
                  flex: 3,
                  child: Container(
                      margin: const EdgeInsets.only(top: 248),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(child: FlutterLogo(size: 81)),
                            // const Spacer(flex: 1),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 26),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 4),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25)),
                              child: TextFormField(
                                controller: emailController,
                                autocorrect: true,
                                enableSuggestions: true,
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (value) {},
                                decoration: InputDecoration(
                                  hintText: 'Email address',
                                  hintStyle:
                                      const TextStyle(color: Colors.black54),
                                  icon: Icon(Icons.email_outlined,
                                      color: Colors.blue.shade700, size: 24),
                                  alignLabelWithHint: true,
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty || !value.contains('@')) {
                                    return 'Invalid email!';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 8),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 4),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25)),
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 8) {
                                    return 'Password is too short!';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle:
                                      const TextStyle(color: Colors.black54),
                                  icon: Icon(CupertinoIcons.lock_circle,
                                      color: Colors.blue.shade700, size: 24),
                                  alignLabelWithHint: true,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: Container(
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                        color: Colors.white),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                top: 12.0),
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            width: double.infinity,
                                            child: MaterialButton(
                                              onPressed: onPressedFunction,
                                              textColor: Colors.blue.shade700,
                                              textTheme:
                                                  ButtonTextTheme.primary,
                                              minWidth: 100,
                                              padding: const EdgeInsets.all(18),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                side: BorderSide(
                                                    color:
                                                        Colors.blue.shade700),
                                              ),
                                              child: const Text(
                                                'Log in',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ])))
                          ])))
            ]));
      })),
    );
  }
}
