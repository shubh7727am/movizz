import 'dart:ui';

import 'package:flutter/material.dart';

class ColorResources{

  static const Color themeColor = Color(0xFF011627);


  static Color getRatingColor(double rating) {
    if (rating >= 7) {
      return const Color(0xFF1B5E20); // Dark green for good rating
    } else if (rating >= 4 && rating < 7) {
      return const Color(0xFFEF6C00); // Dark orange for average rating
    } else if (rating > 0 && rating < 4) {
      return const Color(0xFFB71C1C); // Dark red for poor rating
    } else {
      return const Color(0xFF616161); // Dark grey for unrated or invalid ratings
    }
  }




}