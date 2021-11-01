import 'body_value.dart';

class BodyPart {
  String text;
  BodyValue value;

  BodyPart({this.text, this.value});

  BodyPart.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    value = json['value'] != null ? new BodyValue.fromJson(json['value']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    if (this.value != null) {
      data['value'] = this.value.toJson();
    }
    return data;
  }
}

