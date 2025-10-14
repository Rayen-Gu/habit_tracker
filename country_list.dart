import 'dart:convert';
import 'package:http/http.dart' as http;

/// Service class for fetching country data from REST Countries API
class CountryService {
  static const String _baseUrl = 'https://restcountries.com/v3.1';

  /// Fetches all countries from the API and returns a sorted list of country names
  static Future<List<String>> fetchCountries() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/all?fields=name'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> countriesJson = json.decode(response.body);

        // Extract country names and handle potential null values
        final List<String> countryList = countriesJson
            .map((country) => country['name']['common']?.toString() ?? 'Unknown Country')
            .where((name) => name != 'Unknown Country') // Filter out null values
            .toList();

        // Sort alphabetically for better UX
        countryList.sort((a, b) => a.compareTo(b));

        return countryList;
      } else {
        throw Exception('Failed to load countries: HTTP ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load countries: $e');
    }
  }

  /// Fetches detailed information for a specific country by its 2-letter code
  static Future<Map<String, dynamic>> fetchCountryDetails(String countryCode) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/alpha/$countryCode'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> countryData = json.decode(response.body);
        return countryData[0]; // Return the first country in the list
      } else {
        throw Exception('Failed to load country details: HTTP ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load country details: $e');
    }
  }

  /// Fetches countries by region
  static Future<List<String>> fetchCountriesByRegion(String region) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/region/$region?fields=name'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> countriesJson = json.decode(response.body);

        final List<String> countryList = countriesJson
            .map((country) => country['name']['common'] as String)
            .toList();

        countryList.sort((a, b) => a.compareTo(b));
        return countryList;
      } else {
        throw Exception('Failed to load countries by region: HTTP ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load countries by region: $e');
    }
  }

  /// Fetches countries that use a specific currency
  static Future<List<String>> fetchCountriesByCurrency(String currencyCode) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/currency/$currencyCode?fields=name'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> countriesJson = json.decode(response.body);

        final List<String> countryList = countriesJson
            .map((country) => country['name']['common'] as String)
            .toList();

        countryList.sort((a, b) => a.compareTo(b));
        return countryList;
      } else {
        throw Exception('Failed to load countries by currency: HTTP ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load countries by currency: $e');
    }
  }

  /// Fetches countries that speak a specific language
  static Future<List<String>> fetchCountriesByLanguage(String language) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/lang/$language?fields=name'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> countriesJson = json.decode(response.body);

        final List<String> countryList = countriesJson
            .map((country) => country['name']['common'] as String)
            .toList();

        countryList.sort((a, b) => a.compareTo(b));
        return countryList;
      } else {
        throw Exception('Failed to load countries by language: HTTP ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load countries by language: $e');
    }
  }
}

/// Data model for Country information
class Country {
  final String name;
  final String officialName;
  final String countryCode2;
  final String countryCode3;
  final List<String> capital;
  final String region;
  final String subregion;
  final int population;
  final Map<String, String> languages;
  final Map<String, dynamic> currencies;
  final String flagUrl;

  Country({
    required this.name,
    required this.officialName,
    required this.countryCode2,
    required this.countryCode3,
    required this.capital,
    required this.region,
    required this.subregion,
    required this.population,
    required this.languages,
    required this.currencies,
    required this.flagUrl,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'] ?? 'Unknown',
      officialName: json['name']['official'] ?? 'Unknown',
      countryCode2: json['cca2'] ?? '',
      countryCode3: json['cca3'] ?? '',
      capital: json['capital'] != null ? List<String>.from(json['capital']) : ['No capital'],
      region: json['region'] ?? 'Unknown',
      subregion: json['subregion'] ?? 'Unknown',
      population: json['population'] ?? 0,
      languages: json['languages'] != null ? Map<String, String>.from(json['languages']) : {},
      currencies: json['currencies'] != null ? Map<String, dynamic>.from(json['currencies']) : {},
      flagUrl: json['flags']?['png'] ?? '',
    );
  }
}

/// Simplified function for backward compatibility
Future<List<String>> fetchCountries() async {
  return await CountryService.fetchCountries();
}