import 'package:flutter/material.dart';

class SearchStatueBar extends StatelessWidget {
  final Function() searchAction;
  const SearchStatueBar({
    super.key,
    required this.searchAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      alignment: Alignment.center,
      height: 55,
      child: TextField(
        onSubmitted: (s) => searchAction,
        decoration: InputDecoration(
          hintText: 'Search for Statue ...',
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 17,
            fontStyle: FontStyle.italic,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          suffixIcon: IconButton(
            onPressed: searchAction,
            icon: const Icon((Icons.search_outlined)),
          ),
        ),
      ),
    );
  }
}
