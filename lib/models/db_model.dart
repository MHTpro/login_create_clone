const String tableName = "login";

class DatabaseModel {
  int? id;
  String? userName;
  String? passWord;

  DatabaseModel({this.id, this.passWord, this.userName});

  Map<String, Object?> toJson() {
    return {
      DatabaseField.id: id,
      DatabaseField.username: userName,
      DatabaseField.password: passWord,
    };
  }

  static DatabaseModel fromJson(Map<String, Object?> json) {
    return DatabaseModel(
      id: json[DatabaseField.id] as int,
      userName: json[DatabaseField.username] as String,
      passWord: json[DatabaseField.password] as String,
    );
  }

  DatabaseModel copy({
    int? newId,
    String? newUsername,
    String? newPassword,
  }) {
    return DatabaseModel(
      id: newId ?? id,
      userName: newUsername ?? userName,
      passWord: newPassword ?? passWord,
    );
  }
}

class DatabaseField {
  static const id = '_id';
  static const username = '_username';
  static const password = '_password';

  static List<String> values = [id, username, password];
}
