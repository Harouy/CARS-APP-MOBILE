import 'package:flutter/material.dart';
import 'package:project/models/VoitureDTO.dart';

class VoituresDetails extends StatelessWidget {
  VoituresDetails(this.voituredto);
  final VoitureDTO voituredto;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voiture Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Marque: ${voituredto.marque}'),
            Text('Année: ${voituredto.anneeenregistrement}'),
            Text('Prix: \$${voituredto.prix}'),
            // Add more details here as needed
          ],
        ),
      ),
    );
  }
}
