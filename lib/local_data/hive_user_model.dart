import 'package:firebase_authentication/model/user_model.dart';
import 'package:hive/hive.dart';
part 'hive_user_model.g.dart';

@HiveType(typeId: 0)
class Profile {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? lang;
  @HiveField(2)
  String? emailId;
  @HiveField(3)
  String? mobileNumber;
  @HiveField(4)
  String? state;
  @HiveField(5)
  String? city;
  @HiveField(6)
  String? district;
  @HiveField(7)
  String? pinCode;
  @HiveField(8)
  int? id;

  Profile({
    this.name,
    this.lang,
    this.emailId,
    this.mobileNumber,
    this.district,
    this.state,
    this.city,
    this.pinCode,
    this.id
  });

  factory Profile.fromJson(UserModel userModel) {
    return Profile(
      name: userModel.name,
      lang: userModel.lang,
      emailId: userModel.emailId,
      mobileNumber: userModel.mobileNumber,
      district: userModel.district,
      state: userModel.state,
      city: userModel.city,
      pinCode: userModel.pinCode,
      id:userModel.id
    );
  }
}
