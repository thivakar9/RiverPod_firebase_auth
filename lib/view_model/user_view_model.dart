import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication/local_data/hive_user_model.dart';
import 'package:firebase_authentication/local_data/local_storage.dart';
import 'package:firebase_authentication/model/authentication.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = Provider<Authentication>((ref) => Authentication());

final authStateProvider = StateProvider((ref) => null);

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final userProvider = Provider<LocalStorage>((ref) => LocalStorageImple());

class UserController extends StateNotifier<Profile> {
  UserController() : super(Profile());

  Future<List<Profile>> getAll(WidgetRef ref) async {
    final res = await ref.watch(userProvider).getUser();
    return res;
  }

  Future<bool> deleteUser(WidgetRef ref, int id) async {
    await ref.watch(userProvider).deleteUser(id);
    return true;
  }

  Future<bool> addUser(WidgetRef ref, Profile profile) async {
    await ref.watch(userProvider).addUser(profile);
    return true;
  }

  Future<bool> editUser(WidgetRef ref, Profile profile) async {
    await ref.watch(userProvider).editUser(profile);
    return true;
  }
}

final user =
    StateNotifierProvider<UserController, Profile>((ref) => UserController());
