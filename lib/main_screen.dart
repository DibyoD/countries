// ignore_for_file: use_build_context_synchronously

import "package:countries/country_search.dart";
import "package:countries/detail_screen.dart";
import "package:countries/models.dart";
import "package:countries/services.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  late Future<List<Country>> _countriesFuture;
  late Map<String, List<Country>> _countriesByContinent;

  @override
  void initState() {
    super.initState();
    _countriesFuture = ApiService().getCountries();
    _countriesByContinent = {};
  }

  void _categorizeCountriesByContinent(List<Country> countries) {
    for (var country in countries) {
      if (_countriesByContinent.containsKey(country.region)) {
        _countriesByContinent[country.region]!.add(country);
      } else {
        _countriesByContinent[country.region] = [country];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[50],
        elevation: 0.0,
        title: const Text(
          'Country Info',
          style: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final countries =
                  await ApiService().getCountries(); // Fetch countries here
              _categorizeCountriesByContinent(countries);
              final query = await showSearch<String>(
                context: context,
                delegate: CountrySearchDelegate(countries: countries),
              );
              if (query != null) {
                setState(() {});
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Country>>(
        future: _countriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            _categorizeCountriesByContinent(snapshot.data!);
            return ListView.builder(
              itemCount: _countriesByContinent.length,
              itemBuilder: (context, index) {
                String continent = _countriesByContinent.keys.elementAt(index);
                List<Country> countries = _countriesByContinent[continent]!;
                return Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ExpansionTile(
                    leading: const Icon(CupertinoIcons.compass),
                    // tilePadding: EdgeInsets.all(5.0),
                    title: Text(continent),
                    children: countries.map((country) {
                      return ListTile(
                        title: Text(country.name),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(country: country),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                );
              },
            );
          }
        },
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
