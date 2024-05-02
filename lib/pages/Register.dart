import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project/models/Registermodel.dart';
import 'package:project/pages/Hompage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formkey = GlobalKey<FormState>();
  var isloading = false;
  String email = "";
  String password = "";
  String lastname = "";
  String age = "";
  String name = "";
  void save() async {
    print(email);
    print(password);
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      setState(() {
        isloading = true;
      });

      RegisterRequest request =
          new RegisterRequest(name, lastname, age, email, password);

      final url = Uri.parse("http://10.0.2.2:8080/authentication/register");

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
          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => HomePage())));

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
          title: const Text("S'inscrire",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
          child: Padding(
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
                            "Prénom",
                            style: TextStyle(color: Colors.white),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez remplire tous les champs possbile';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        name = value!;
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
                          label: Text(
                            "Nom",
                            style: TextStyle(color: Colors.white),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez remplire tous les champs possbile';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        lastname = value!;
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
                      keyboardType: TextInputType.number,
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
                            "Age",
                            style: TextStyle(color: Colors.white),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez remplire tous les champs possbile';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        age = value!;
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
                          child: Text("S'inscrire"),
                          style: ElevatedButton.styleFrom(
                              elevation: 5,
                              backgroundColor: Color.fromARGB(255, 99, 3,
                                  3) // Add the shadow elevation here
                              ),
                        )
                      ],
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
