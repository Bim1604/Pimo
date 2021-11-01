import 'package:pimo/models/body.dart';
import 'package:pimo/models/body_value.dart';

class BodyPartViewModel {
  BodyPart _bodyPart;
  BodyPartViewModel({BodyPart bodyPart}) : _bodyPart = bodyPart;

  String get name {
    return _bodyPart.text;
  }

  String get measure {
    return _bodyPart.value.measure;
  }

  String get textValue {
    return _bodyPart.value.textValue;
  }

  int get quantity {
    return _bodyPart.value.quantityValue;
  }

}