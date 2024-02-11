import 'package:firebase_authentication/local_data/hive_user_model.dart';
import 'package:firebase_authentication/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

abstract class LocalStorage {
  Future<bool> addUser(Profile userModel);
  Future<List<Profile>> getUser();
  Future<bool> editUser(Profile profile);
  Future<bool> deleteUser(int id);
}

class LocalStorageImple extends LocalStorage {
  @override
  Future<bool> addUser(Profile userModel) async {
    final res = await Hive.openBox<Profile>("user");
    final result = res.put(userModel.id, userModel);
    debugPrint("result is $result");
    return true;
  }

  @override
  Future<bool> deleteUser(int id) async {
    final res = await Hive.openBox<Profile>("user");
    final result = res.delete(
      id,
    );
    debugPrint("result is $result");
    return true;
  }

  @override
  Future<bool> editUser(Profile profile) async {
    final res = await Hive.openBox<Profile>("user");
    final result = res.put(profile.emailId, profile);
    debugPrint("result is $result");
    return true;
  }

  @override
  Future<List<Profile>> getUser() async {
    final res = await Hive.openBox<Profile>("user");
    final result = res.values.toList();
    debugPrint("result is $result");
    List<Profile> profile = [];
    for (var element in result) {
      UserModel userModel = UserModel();
      userModel.name = element.name;
      userModel.lang = element.lang;
      userModel.emailId = element.emailId;
      userModel.mobileNumber = element.mobileNumber;
      userModel.district = element.district;
      userModel.state = element.state;
      userModel.pinCode = element.pinCode;
      userModel.city = element.city;
      userModel.id = element.id;
      profile.add(Profile.fromJson(userModel));
    }
    return profile;
  }
}
