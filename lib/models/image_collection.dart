class ImageCollection {
  final int id;
  final String name;

  ImageCollection({this.id, this.name});

  factory ImageCollection.fromJson(Map<String, dynamic> json) {
    return ImageCollection(
      //Hien tai dang set cung
        id: json['listCollectionProject'][0]['collection']['id'],
        name: json['listCollectionProject'][0]['collection']['name'],
    );
  }
}