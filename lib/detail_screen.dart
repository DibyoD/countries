import 'package:countries/models.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Country country;

  const DetailScreen({Key? key, required this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[50],
        centerTitle: true,
        title: const Text(
          'Country Details',
          style: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Center(
              child: Material(
                elevation: 10.0,
                borderRadius: BorderRadiusDirectional.circular(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(country.flagUrl),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Name: ${country.name}',
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Text(
              'Capital: ${country.capitals.join(', ')}',
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Text(
              'Population: ${country.population}',
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Text(
              'Region: ${country.region}',
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Text(
              'Subregion: ${country.subregion}',
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: const Text(
          "Developed by Dibyo Dhara",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
