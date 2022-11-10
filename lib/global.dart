import 'dart:ui';

import 'modals/animal.dart';

class Global {
  static Color color = const Color(0xffC19E82);
  static String category = "";

  static List<Subscription> subscriptionData = [
    Subscription(time: "Week", price: "1.99"),
    Subscription(time: "1 Month", price: "4.39"),
    Subscription(time: "3 Month", price: "9.99"),
    Subscription(time: "6 Month", price: "13"),
  ];

  static List<Animal> animalData = [
    Animal(
      name: "African elephant",
      description: "Loxodonta",
      category: "Elephant",
    ),
    Animal(
      name: "Elephant",
      description: "Large Rounded Ears",
      category: "Elephant",
    ),
    Animal(
      name: "Lion",
      description: "Panthera leo",
      category: "Lion",
    ),
    Animal(
      name: "Python family",
      description: "Pythonidae",
      category: "Snake",
    ),
    Animal(
      name: "Cobras",
      description: "Naja",
      category: "Snake",
    ),
    Animal(
      name: "German Shepherd",
      description: "German Shepherd",
      category: "Dog",
    ),
    Animal(
      name: "Siberian Husky",
      description: "Husky; Sibe",
      category: "Dog",
    ),
  ];
}
