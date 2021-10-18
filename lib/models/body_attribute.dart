class BodyAttribute {
  final int id;
  final double quantityValue;
  final String textValue;
  final int bodyAttTypeId;
  final int bodyPartId;
  final String bodyAttName;
  final String bodyPartName;
  final String bodyMeasure;

  BodyAttribute(
      {this.id, this.quantityValue,
  this.textValue,
  this.bodyAttTypeId,
  this.bodyPartId,
  this.bodyAttName, this.bodyPartName, this.bodyMeasure});


  factory BodyAttribute.fromJson(Map<String, dynamic> json) {
    return BodyAttribute(
      id: json["id"],
      quantityValue: json["quantityValue"],
      bodyAttTypeId: json["bodyAttTypeId"],
      bodyPartId: json["bodyPartId"],
      bodyAttName: json["bodyAttName"],
      bodyPartName: json["bodyPartName"],
      bodyMeasure: json["measure"],
    );
  }

  factory BodyAttribute.fromJsonDetail(Map<String, dynamic> json) {
    return BodyAttribute(
      id: json["id"],
      quantityValue: json["value"],
      bodyAttTypeId: json["bodyAttTypeId"],
      bodyPartId: json["bodyPartId"],
      bodyAttName: json["bodyAttName"],
      bodyMeasure: json["measure"],
    );
  }

}