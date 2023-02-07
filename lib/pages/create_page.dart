import 'package:flutter/material.dart';
import 'package:test_flutter_app/pages/login.dart';
import '../db/database.dart';
import '../models/db_model.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  late List<DatabaseModel> allInformations;

  Future addInfo() async {
    final info = DatabaseModel(
      userName: userName.text,
      passWord: password.text,
    );

    await MainDataBase.instance.sendData(info);
  }

  @override
  void initState() {
    MainDataBase.instance.getAll().then((value) => allInformations = value);
    super.initState();
  }

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        backgroundColor: Colors.green.shade900,
        title: const Text(
          "Create page",
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "can't be empty";
                    }
                    return null;
                  },
                  controller: userName,
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
                    labelText: "new username",
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "can't be empty";
                    }
                    return null;
                  },
                  controller: password,
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
                    labelText: "new password",
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
                onPressed: () async {
                  final navigator = Navigator.of(context);
                  if (_formkey.currentState!.validate()) {
                    await addInfo();

                    navigator.push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const MyPage();
                        },
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(
                height: 30.0,
              ),
              FutureBuilder(
                future: MainDataBase.instance.getAll(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<DatabaseModel>> snapshot) {
                  if (!(snapshot.hasData)) {
                    return const CircularProgressIndicator(
                      backgroundColor: Colors.blueAccent,
                    );
                  }
                  return allInformations.isEmpty
                      ? const Text(
                          "Don't have info!",
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.white,
                          ),
                        )
                      : SizedBox(
                          height: 100.0,
                          child: ListView.builder(
                            itemCount: allInformations.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                color: Colors.green.shade800,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                      "id: ${allInformations[index].id}",
                                      style: const TextStyle(
                                        fontSize: 25.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "user: ${allInformations[index].userName}",
                                      style: const TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "pass: ${allInformations[index].passWord}",
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
