import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:emotiovent/models/cute_animal_img.dart';

Future<List<AnimalPicture>> fetchAnimalPictures() async {
  List<String> links = ['https://some-random-api.ml/img/dog',
                        'https://some-random-api.ml/img/cat',
                        'https://some-random-api.ml/img/panda',
                        'https://some-random-api.ml/img/birb',
                        'https://some-random-api.ml/img/fox'];

  Random random = new Random();
  List<AnimalPicture> animalPictures = [];

  for(int x=0; x< 30;x++){
    final response =
      await http.get(links[random.nextInt(links.length)]);

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.

        animalPictures.add(AnimalPicture.fromJSON(jsonDecode(response.body)));
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
  }
  
  return animalPictures;
}
