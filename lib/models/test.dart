class ImageCollectionTest {
  int id;
  String name;
  String description;
  int brandId;
  int modelId;
  int collectionId;

  ImageCollectionTest(
      {this.id,
        this.name,
        this.description,
        this.brandId,
        this.modelId,
        this.collectionId});

  ImageCollectionTest.fromJson(Map<String, dynamic> json) {
    print(json['product'][0]['name']);
    id = json['id'];
    name = json['name'];
    description = json['description'];
    brandId = json['brandId'];
    modelId = json['modelId'];
    collectionId = json['collectionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['brandId'] = this.brandId;
    data['modelId'] = this.modelId;
    data['collectionId'] = this.collectionId;
    return data;
  }
}