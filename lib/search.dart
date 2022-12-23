import 'package:flutter/material.dart';

class searchPage extends SearchDelegate {
  List<String> searchResults = [
    'Caffe wibu',
    'Starbuck',
    'Conatto',
    'Mbo karep',
  ];
  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => close(context, null), icon: Icon(Icons.arrow_back));
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              if (query.isEmpty) {
                FocusScope.of(context).unfocus();
              } else {
                query = '';
              }
            },
            icon: Icon(Icons.clear))
      ];
  @override
  Widget buildResults(BuildContext context) => Center(
        child: Text(
          '${query.length}',
          style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
        ),
      );
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = searchResults.where((searchResults) {
      final result = searchResults.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];

        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }
}
