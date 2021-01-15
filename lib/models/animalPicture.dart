// For retrieving Animal Picture JSON
// just retrieves the hash map from some-random-api.ml website

class AnimalPicture{
  final String link;

  AnimalPicture({this.link});

  factory AnimalPicture.fromJSON(Map<String, dynamic> json){
    return AnimalPicture(
      link: json['link'],
    );
  }
}