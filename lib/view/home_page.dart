import 'dart:math';

import 'package:firebase_authentication/local_data/hive_user_model.dart';
import 'package:firebase_authentication/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key, this.profile});
  final Profile? profile;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GlobalKey<FormState> homeKey = GlobalKey<FormState>();
    final name =
        StateProvider<TextEditingController>((ref) => TextEditingController(text: profile?.name??""));
    final emailId =
        StateProvider<TextEditingController>((ref) => TextEditingController(text: profile?.emailId??""));
    final mobileNo =
        StateProvider<TextEditingController>((ref) => TextEditingController(text: profile?.mobileNumber??""));
    final state =
        StateProvider<TextEditingController>((ref) => TextEditingController(text: profile?.state??""));
    // final district =
    //     StateProvider<TextEditingController>((ref) => TextEditingController());
    final pincode =
        StateProvider<TextEditingController>((ref) => TextEditingController(text: profile?.pinCode??""));
    final city =
        StateProvider<TextEditingController>((ref) => TextEditingController(text: profile?.city??""));
    final lang =
        StateProvider<TextEditingController>((ref) => TextEditingController(text: profile?.lang??""));
    final authRef = ref.watch(user.notifier);
    void onPressedFunction() async {
      if (!homeKey.currentState!.validate()) {
        return;
      }
      Profile userModel = Profile()
        ..name = ref.watch(name).text
        ..lang = ref.watch(lang).text
        ..emailId = ref.watch(emailId).text
        ..mobileNumber = ref.watch(mobileNo).text
        ..state = ref.watch(state).text
        ..city = ref.watch(city).text
        ..id =profile?.id?? Random().nextInt(100)
        ..pinCode = ref.watch(pincode).text;
      final res = await authRef.addUser(ref, userModel);
      if (context.mounted) {
        if (res == true) {
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Somethinng wrong")));
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home page"),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: homeKey,
            child: Column(
              children: [
                TextFormWidget(
                  name: ref.watch(name),
                  hintText: "Name",
                  icon: Icons.person,
                ),
                TextFormWidget(
                  name: ref.watch(lang),
                  hintText: "language",
                  icon: Icons.language,
                ),
                TextFormWidget(
                  name: ref.watch(emailId),
                  hintText: "EmailId",
                  icon: Icons.email,
                ),
                TextFormWidget(
                  name: ref.watch(mobileNo),
                  hintText: "MobileNo",
                  icon: Icons.phone,
                ),
                TextFormWidget(
                  name: ref.watch(state),
                  hintText: "State",
                  icon: Icons.place,
                ),
                TextFormWidget(
                  name: ref.watch(city),
                  hintText: "City",
                  icon: Icons.place,
                ),
                TextFormWidget(
                  name: ref.watch(pincode),
                  hintText: "Pincode",
                  icon: Icons.place,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 12.0, bottom: 12),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: onPressedFunction,
                    textColor: Colors.blue.shade700,
                    textTheme: ButtonTextTheme.primary,
                    minWidth: 100,
                    padding: const EdgeInsets.all(18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: BorderSide(color: Colors.blue.shade700),
                    ),
                    child:  Text(
                     profile==null? 'Add User':"Edit User",
                      style:const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class TextFormWidget extends StatelessWidget {
  const TextFormWidget(
      {super.key, required this.name, required this.hintText, this.icon});

  final TextEditingController name;
  final String hintText;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25)),
      child: TextFormField(
        controller: name,
        autocorrect: true,
        enableSuggestions: true,
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) {},
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black54),
          icon: Icon(icon, color: Colors.blue.shade700, size: 24),
          alignLabelWithHint: true,
          border: InputBorder.none,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return '$hintText required';
          }
          return null;
        },
      ),
    );
  }
}
