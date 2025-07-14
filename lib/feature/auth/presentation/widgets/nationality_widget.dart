import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CountryDropdown extends StatefulWidget {
  const CountryDropdown({super.key});

  @override
  State<CountryDropdown> createState() => _CountryDropdownState();
}

class _CountryDropdownState extends State<CountryDropdown> {
  List<dynamic> countries = [];
  String? selectedCountry;

  @override
  void initState() {
    super.initState();
    loadCountries();
  }

  Future<void> loadCountries() async {
    final String response = await rootBundle.loadString('assets/countries.json');
    final List<dynamic> data = jsonDecode(response);
    setState(() {
      countries = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Nationality',
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            children: const [
              TextSpan(
                text: ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          isExpanded: true,
          value: selectedCountry,
          items: countries.map<DropdownMenuItem<String>>((country) {
            return DropdownMenuItem<String>(
              value: country["name"],
              child: Text('${country["emoji"] ?? ''} ${country["name"]}'),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedCountry = value;
            });
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF4F4F4),
            hintText: 'Select your nationality',
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
        ),
      ],
    );
  }
}
