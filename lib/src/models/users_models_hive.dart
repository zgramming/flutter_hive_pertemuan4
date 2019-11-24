import 'package:hive/hive.dart';

part 'users_models_hive.g.dart';

@HiveType()
class UsersModelsHive extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String username;

  @HiveField(2)
  String email;

  @HiveField(3)
  String password;

  @HiveField(4)
  String avatar;
}
