class VoitureDTO {
  VoitureDTO(
      {required this.Horsepower,
      required this.anneeenregistrement,
      required this.marque,
      required this.fueltype,
      required this.kilometrage,
      required this.idvoiture,
      required this.prix,
      required this.proprietaire});
  factory VoitureDTO.fromJson(Map<String, dynamic> json) {
    return VoitureDTO(
      idvoiture: json['idvoiture'],
      anneeenregistrement: json['anneeenregistrement'],
      marque: json['marque'],
      kilometrage: json['kilometrage'],
      fueltype: json['fueltype'],
      prix: json['prix'],
      proprietaire: json['proprietaire'],
      Horsepower: json['horsepower'],
    );
  }
  final idvoiture;
  final int anneeenregistrement;
  final String marque;
  final double Horsepower;
  final int kilometrage;
  final String fueltype;
  final int prix;
  final String proprietaire;
}
