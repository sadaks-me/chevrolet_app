import 'package:flutter/material.dart';
import 'package:chevrolet/model/car.dart';

List<CarModel> carsData = [
  new CarModel('Chevrolet', 'Corvette X1', 'The first generation corvette','1991-2010','1991', car1),
  new CarModel('Chevrolet', 'Corvette X2', 'The second generation corvette','1992-2011','1992', car2),
  new CarModel('Chevrolet', 'Corvette C1', 'The first generation corvette','1993-2016','1993', car3),
  new CarModel('Chevrolet', 'Corvette C2', 'The second generation corvette','1994-2000','1994', car4),
  new CarModel('Chevrolet', 'Corvette C3', 'The third generation corvette','1995-2017','1995', car5)
];

ImageProvider car1 = new ExactAssetImage('assets/cars/car1.png');
ImageProvider car2 = new ExactAssetImage('assets/cars/car2.png');
ImageProvider car3 = new ExactAssetImage('assets/cars/car3.png');
ImageProvider car4 = new ExactAssetImage('assets/cars/car4.png');
ImageProvider car5 = new ExactAssetImage('assets/cars/car5.png');
