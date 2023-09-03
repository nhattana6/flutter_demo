import 'package:new_first_demo/Models/Category.dart';
import 'package:flutter/material.dart';

import 'food.dart';

List<Category> FAKE_CATEGORIES = [
  Category(color: Colors.teal, id: 1, content: "Phở"),
  Category(color: Colors.black, id: 2, content: "bánh mì"),
  Category(color: Colors.red, id: 3, content: "bánh bèo"),
  Category(color: Colors.black, id: 4, content: "bánh bèo 1"),
  Category(color: Colors.cyan, id: 5, content: "bánh bèo 2"),
  Category(color: Colors.brown, id: 6, content: "bánh bèo 3"),
  Category(color: Colors.green, id: 7, content: "bánh bèo 4"),
  Category(color: Colors.greenAccent, id: 8, content: "bánh bèo 5"),
  Category(color: Colors.lightGreenAccent, id: 9, content: "bánh bèo 6"),
  Category(color: Colors.deepOrange, id: 9, content: "bánh bèo 7"),
  Category(color: Colors.indigo, id: 9, content: "bánh bèo 8"),
  Category(color: Colors.indigoAccent, id: 9, content: "bánh bèo 9"),
  Category(color: Colors.orangeAccent, id: 9, content: "bánh bèo 10"),
  Category(color: Colors.cyanAccent, id: 9, content: "bánh bèo 11"),
];

var FAKE_FOODS = [
  //array of food's objects
  Food(
      name: "sushi - 寿司",
      urlImage: "https://upload.wikimedia.org/wikipedia/commons/c/cf/Salmon_Sushi.jpg",
      duration: Duration(minutes:25),
      complexity: Complexity.Medium,
      ingredients: ['Sushi-meshi', 'Nori', 'Condiments'],
      categoryId: 1),
  Food(
      name: "Pizza tonda",
      urlImage: "https://www.angelopo.com/filestore/images/pizza-tonda.jpg",
      duration: Duration(minutes:15),
      complexity: Complexity.Hard,
      ingredients: ['Tomato sauce','Fontina cheese','Pepperoni','Onions','Mushrooms','pepperoncini'],
      categoryId: 2),
  Food(
      name: "Makizushi",
      urlImage: "https://upload.wikimedia.org/wikipedia/commons/0/0b/KansaiSushi.jpg",
      complexity: Complexity.Simple,
      duration: Duration(minutes:20),
      categoryId: 1, ingredients: []),
  Food(
      name: "Tempura",
      urlImage: "https://upload.wikimedia.org/wikipedia/commons/a/ac/Peixinhos_da_horta.jpg",
      duration: Duration(minutes: 15),
      complexity: Complexity.Simple,
      categoryId: 1, ingredients: []),
  Food(
      name: "Neapolitan pizza",
      urlImage: "https://img-global.cpcdn.com/recipes/7f1a5380090f6300/1280x1280sq70/photo.jpg",
      duration: Duration(minutes:20),
      complexity: Complexity.Medium,
      ingredients: ['Fontina cheese','Tomato sauce','Onions','Mushrooms'],
      categoryId: 2),
  Food(
      name: "Sashimi",
      urlImage: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Sashimi_-_Tokyo_-_Japan.jpg/2880px-Sashimi_-_Tokyo_-_Japan.jpg",
      duration: Duration(hours: 1, minutes: 5),
      complexity: Complexity.Medium,
      categoryId: 1, ingredients: []),
  Food(
      name: "Homemade Humburger",
      urlImage: "https://upload.wikimedia.org/wikipedia/commons/5/58/Homemade_hamburger.jpg",
      duration: Duration(minutes: 20),
      complexity: Complexity.Hard,
      categoryId: 3, ingredients: []),
];