import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/models/login.dart';
import 'package:project/pages/Hompage.dart';
import 'package:project/pages/Register.dart';
import 'package:project/sidebar/sidebar_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Login();
  }
}

class _Login extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  var isloading = false;
  String email = "";
  String password = "";
  void save() async {
    print(email);
    print(password);
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      setState(() {
        isloading = true;
      });

      authRequest request = new authRequest(email, password);

      final url = Uri.parse("http://10.0.2.2:8080/authentication/authenticate");

      try {
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'email': request.email.toString(),
            'password': request.password.toString(),
          }), // Convert the 'Calculrequest' object to JSON format
        );

        if (response.statusCode == 200) {
          // Request successful, handle the response data
          setState(() {
            isloading = false;
          });
          Map<String, dynamic> responseData = jsonDecode(response.body);
          String token = responseData['token'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('token', token);
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => SideBarLayout())));

          print('Response: ${responseData}');
        } else {
          // Request failed, handle the error
          print('Request failed with status: ${response.statusCode}');
        }
      } catch (e) {
        // Error occurred while making the request
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (isloading) {
      return Theme(
        data: Theme.of(context).copyWith(
          textSelectionTheme: TextSelectionThemeData(
            cursorColor:
                Colors.white, // Change this to your desired cursor color
          ),
        ),
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 10, 10, 10),
          appBar: AppBar(backgroundColor: Color.fromARGB(255, 122, 6, 6)),
          body: const Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.white, // Change this to your desired cursor color
        ),
      ),
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 2, 2, 2),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 92, 6, 6),
          title: const Text('Login',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .white), // Change the border color when not focused
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 121, 8,
                                  14)), // Change the underline color when focused
                        ),
                        label: Text(
                          "Email",
                          style: TextStyle(color: Colors.white),
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez remplire tous les champs possbile';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      email = value!;
                    },
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .white), // Change the border color when not focused
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 121, 8,
                                14)), // Change the underline color when focused
                      ),
                      label: Text("password",
                          style: TextStyle(color: Colors.white)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez remplire tous les champs possbile';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      password = value!;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          _formkey.currentState!.reset();
                        },
                        child: Text('Reset',
                            style: TextStyle(color: Colors.white)),
                      ),
                      ElevatedButton(
                        onPressed: save,
                        child: Text('Login'),
                        style: ElevatedButton.styleFrom(
                            elevation: 5,
                            backgroundColor: Color.fromARGB(
                                255, 99, 3, 3) // Add the shadow elevation here
                            ),
                      )
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => Register())));
                      ;
                    },
                    child: Text(
                      'Pas encore inscrit?Inscrivez-vous ici',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
