

import 'package:flutter/material.dart';

Widget tile(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: 140,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(title,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }