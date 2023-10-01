import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sub_space/src/constants/constants.dart';

class BlogProvider extends ChangeNotifier {
  List<Map<String, dynamic>> blogList = [];
  Set<String> favoriteBlogs = {};

  Future<void> fetchBlogs() async {
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });

      if (response.statusCode == 200) {
        var decoded = json.decode(response.body);
        blogList = List.from(decoded['blogs']);
        notifyListeners();
      } else {
        debugPrint('Request failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void isBlogFavorite(String id) {
    if (favoriteBlogs.contains(id)) {
      favoriteBlogs.remove(id);
    } else {
      favoriteBlogs.add(id);
    }
    notifyListeners();
  }
}
