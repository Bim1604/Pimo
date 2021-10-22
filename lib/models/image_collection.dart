class ImageCollection {
  final int id;
  final String name;
  ImageCollection({this.id, this.name});

  factory ImageCollection.fromJson(Map<String, dynamic> json) {
    print(json['product']['id']);
    return ImageCollection(
      //Hien tai dang set cung
        id: json['product']['id'],
        name: json['product']['name'],
    );
  }
}