import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/models/VoitureDTO.dart';
import 'package:project/pages/Voituredetail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var isloading = false;
  List<VoitureDTO> voituresDTOList =
      []; // Replace VoitureDTO with your data model
  int displayedItemCount = 5;
  void fetch() async {
    isloading = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    final url = Uri.parse("http://10.0.2.2:8080/Voiture");
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(url, headers: headers

          // Convert the 'Calculrequest' object to JSON format
          );

      if (response.statusCode == 200) {
        // Request successful, handle the response data
        setState(() {
          isloading = false;
        });
        final jsonData = json.decode(response.body);
        final List<dynamic> voituresListJson = jsonData['voituresDTO'];
        voituresDTOList =
            voituresListJson.map((json) => VoitureDTO.fromJson(json)).toList();
        print('Response: ${response.body}');
      } else {
        // Request failed, handle the error
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Error occurred while making the request
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
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
    // TODO: implement build
    return ListView(
      children: [
        const SizedBox(
          height: 40,
        ),
        const Center(
          child: Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              'Découvrez les nouveautés',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
          ),
        ),
        Divider(
          color:
              Colors.black, // You can specify the color you want for the line
          thickness: 2, // You can adjust the thickness of the line
        ),
        ListView.builder(
          itemCount: displayedItemCount <= voituresDTOList.length
              ? displayedItemCount
              : voituresDTOList.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            final VoitureDTO voiture = voituresDTOList[index];
            return GestureDetector(
              onTap: () {
                // Navigate to VoitureDetailsPage when an item is clicked
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => VoituresDetails(voiture),
                  ),
                );
              },
              child: Card(
                color: Color.fromARGB(
                    255, 97, 10, 4), // Set the card background color to red
                elevation: 4,
                margin: EdgeInsets.all(8),
                child: Row(
                  children: [
                    // Left side with car information
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Marque: ${voiture.marque}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                            Text(
                              'Année: ${voiture.anneeenregistrement}',
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              'Prix: \$${voiture.prix}',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Right side with the image
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/car.png', // Replace with the path to your image
                        width: 80, // Adjust the image width as needed
                        height: 80, // Adjust the image height as needed
                        fit: BoxFit.cover, // Adjust the fit mode as needed
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        if (displayedItemCount < voituresDTOList.length)
          ElevatedButton(
            onPressed: () {
              setState(() {
                displayedItemCount += 5; // Load the next 5 items
              });
            },
            child: Text('Load More'),
          )
      ],
    );
  }
}
