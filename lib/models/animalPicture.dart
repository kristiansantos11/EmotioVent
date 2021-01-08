class AnimalPicture{
  final String link;

  AnimalPicture({this.link});

  factory AnimalPicture.fromJSON(Map<String, dynamic> json){
    return AnimalPicture(
      link: json['link'],
    );
  }
}