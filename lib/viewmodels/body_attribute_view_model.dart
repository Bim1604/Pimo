import 'package:pimo/models/body_attribute.dart';

class ModelAttributeViewModel {
  BodyAttribute _bodyAttribute;

  ModelAttributeViewModel({BodyAttribute bodyAttribute})
      : _bodyAttribute = bodyAttribute;

  int get id {
    return _bodyAttribute.id;
  }

  double get quantityValue {
    return _bodyAttribute.quantityValue;
  }

  int get bodyAttTypeId {
    return _bodyAttribute.bodyAttTypeId;
  }

  int get bodyPartId {
    return _bodyAttribute.bodyPartId;
  }

  String get bodyAttName {
    return _bodyAttribute.bodyAttName;
  }

  String get bodyPartName {
    return _bodyAttribute.bodyPartName;
  }

  String get measure {
    return _bodyAttribute.bodyMeasure;
  }

}