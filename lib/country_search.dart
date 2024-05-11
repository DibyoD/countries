import "package:countries/detail_screen.dart";
import "package:countries/models.dart";
import "package:flutter/material.dart";

class CountrySearchDelegate extends SearchDelegate<String> {
  final List<Country> countries;

  CountrySearchDelegate({required this.countries});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredCountries = countries.where((country) {
      final nameLower = country.name.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();

    return ListView.builder(
      itemCount: filteredCountries.length,
      itemBuilder: (context, index) {
        final country = filteredCountries[index];
        return ListTile(
          title: Text(country.name),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(country: country),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context); 
  }
}
