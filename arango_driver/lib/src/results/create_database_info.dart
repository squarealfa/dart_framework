import 'database_user.dart';

class CreateDatabaseInfo {
  final String name;
  final List<DatabaseUser> databaseUsers;

  const CreateDatabaseInfo(this.name,
      [List<DatabaseUser> databaseUsers = const []])
      : databaseUsers = databaseUsers;
}
