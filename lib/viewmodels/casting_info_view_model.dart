
import 'dart:core';

import 'package:pimo/models/brand.dart';
import 'package:pimo/models/casting.dart';
import 'package:pimo/models/casting_info.dart';
import 'package:pimo/utils/common.dart';

class CastingInfoViewModel {
  CastingInfo _castingInfo;
  CastingInfoViewModel({CastingInfo castingInfo}) : _castingInfo = castingInfo;

  Casting get castingDetail {
    return _castingInfo.casting;
  }

  Brand get brandDetail {
    return _castingInfo.brand;
  }

  // String get nameCasting {
  //   return _castingInfo.casting.name;
  // }
  //
  // int get salary {
  //   return _castingInfo.casting.salary;
  // }
  // int get castingId {
  //   return    _castingInfo.casting.id;
  // }
  //
  // String get castingPoster {
  //   return     _castingInfo.casting.poster;
  // }
  // String get castingDescription {
  //   return _castingInfo.casting.description;
  // }
  DateTime get openTimeDateTime {
    return parseDatetime(_castingInfo.casting.openTime);
  }

  String get closeTime {
    return _castingInfo.casting.closeTime != null ? formatTime(_castingInfo.casting.closeTime) : 'null';
  }

  String get closeDate {
    return _castingInfo.casting.closeTime != null ? formatDate(_castingInfo.casting.closeTime) : 'null';
  }

  DateTime get closeTimeDateTime {
    return parseDatetime(_castingInfo.casting.closeTime);
  }
  // String get address {
  //   return _castingInfo.casting.address;
  // }
  // String get request {
  //   return _castingInfo.casting.request;
  // }
  // int get brandID {
  //   return _castingInfo.casting.brandId;
  // }
  // String get nameBrand {
  //   return _castingInfo.brand.name;
  // }
  // String
}