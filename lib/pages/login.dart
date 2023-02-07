import 'package:flutter/material.dart';
import 'package:test_flutter_app/db/database.dart';
import 'package:test_flutter_app/models/db_model.dart';
import 'package:test_flutter_app/pages/confirm_page.dart';
import 'package:test_flutter_app/pages/create_page.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final _formkey = GlobalKey<FormState>();

  bool unlock = false;
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  late String? databaseUserName;
  late String? databasePassword;
  late Future<DatabaseModel> info;

  @override
  void initState() {
    //get id to this method
    info = MainDataBase.instance.getOne(1);

    //username in database
    info.then((value) => databaseUserName = value.userName);
    //password in database
    info.then((value) => databasePassword = value.passWord);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        backgroundColor: Colors.green.shade900,
        title: const Text(
          "Login page",
          style: TextStyle(
            fontSize: 25.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 350.0,
                child: TextFormField(
                  controller: userName,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "can't be empty";
                    }
                    return null;
                  },
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.green.shade800,
                    labelText: "username",
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      color: Colors.white70,
                    ),
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              //
              const SizedBox(
                height: 30.0,
              ),
              //

              SizedBox(
                width: 350.0,
                child: TextFormField(
                  controller: password,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "can't be empty";
                    }
                    return null;
                  },
                  obscureText: true,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.green.shade800,
                    labelText: "password",
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      color: Colors.white70,
                    ),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 45.0,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    if (userName.text == databaseUserName &&
                        password.text == databasePassword) {
                      setState(
                        () {
                          unlock = false;
                        },
                      );
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return const ConfirmPage();
                          },
                        ),
                      );
                    } else {
                      setState(
                        () {
                          unlock = true;
                        },
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),

              unlock
                  ? const Text(
                      "Wrong user or pass",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    )
                  : const Visibility(
                      visible: true,
                      child: Text(''),
                    ),
              const SizedBox(
                height: 15.0,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const CreatePage();
                      },
                    ),
                  );
                },
                child: const Text(
                  "Don't have an account?click here",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
