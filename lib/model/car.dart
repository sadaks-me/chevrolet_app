import 'package:flutter/material.dart';

class CarModel {
  final String brand;
  final String model;
  final String year;
  final String description;
  final String production;
  final ImageProvider image;

  CarModel(
    this.brand,
    this.model,
    this.description,
    this.production,
    this.year,
    this.image,
  );
}
