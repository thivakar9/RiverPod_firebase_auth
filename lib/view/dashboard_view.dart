import 'package:firebase_authentication/view/home_page.dart';
import 'package:firebase_authentication/view/profile_view.dart';
import 'package:firebase_authentication/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final index = StateProvider.autoDispose<int>((ref) => 0);

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentIndex = ref.watch(index);
    final res = ref.watch(user.notifier).getAll(ref);

    return Scaffold(
      appBar: AppBar(
        title:
            currentIndex == 0 ? const Text("Dashboard") : const Text("Profile"),
        centerTitle: true,
      
      ),
      body: currentIndex == 0
          ? FutureBuilder(
              future: res,
              builder: (_, s) {
                // res.when(data: (profile) {
                if (s.hasData) {
                  return s.data!.isNotEmpty
                      ? ListView.builder(
                          itemBuilder: (_, index) {
                            return ListTile(
                              leading: CircleAvatar(child:Text(s.data![index].name!.substring(0,1))) ,
                              onTap: () {
                                var route = MaterialPageRoute(
                                    builder: (_) => HomePage(
                                          profile: s.data![index],
                                        ));
                                Navigator.push(context, route).whenComplete(() {
                                  ref.invalidate(userProvider);
                                  ref.invalidate(userProvider);
                                  ref.watch(user.notifier);
                                });
                              },
                              title: Text(s.data![index].name ?? ''),
                              trailing: InkWell(
                                onTap: () async {
                                  var res = await ref
                                      .watch(user.notifier)
                                      .deleteUser(ref, s.data![index].id!);
                                  if (context.mounted) {
                                    if (res == true) {
                                      ref.invalidate(userProvider);
                                      ref.watch(user.notifier);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "SuccessFully Delete!!!")));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text("Somethinng wrong")));
                                    }
                                  }
                                },
                                child:
                                    const Icon(Icons.delete, color: Colors.red),
                              ),
                              subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(s.data![index].emailId ?? ''),
                                    Text(s.data![index].mobileNumber ?? ''),
                                    Text(s.data![index].lang ?? ''),
                                  ]),
                            );
                          },
                          itemCount: s.data!.length,
                        )
                      : const Center(
                          child: Text("No record Found"),
                        );
                  // }, error: (_, e) {
                  //   return Center(
                  //     child: Text(e.toString()),
                  //   );
                  // }, loading: () {
                  //   return const Center(
                  //     child: CircularProgressIndicator(),
                  //   );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              })
          : const ProfilePage(),
      floatingActionButton: currentIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                var route = MaterialPageRoute(builder: (_) => const HomePage());
                Navigator.push(context, route).whenComplete(() {
                  ref.invalidate(userProvider);
                  ref.watch(user.notifier);
                });
              },
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            currentIndex = value;
            ref.watch(index.notifier).state = currentIndex;
          },
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
          ]),
    );
  }
}
