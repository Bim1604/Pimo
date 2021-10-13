class Event {
  Casting casting;

  Event({this.casting});

  Event.fromJson(Map<String, dynamic> json) {
    casting =
    json['casting'] != null ? new Casting.fromJson(json['casting']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.casting != null) {
      data['casting'] = this.casting.toJson();
    }
    return data;
  }
}

class Casting {
  int id;
  String name;
  String description;
  bool status;
  int monopolyTime;
  String openTime;
  String closeTime;
  int brandId;
  String address;
  bool tatoo;

  Casting(
      {this.id,
        this.name,
        this.description,
        this.status,
        this.monopolyTime,
        this.openTime,
        this.closeTime,
        this.brandId,
        this.address,
        this.tatoo});

  Casting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    monopolyTime = json['monopolyTime'];
    openTime = json['openTime'];
    closeTime = json['closeTime'];
    brandId = json['brandId'];
    address = json['address'];
    tatoo = json['tatoo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['status'] = this.status;
    data['monopolyTime'] = this.monopolyTime;
    data['openTime'] = this.openTime;
    data['closeTime'] = this.closeTime;
    data['brandId'] = this.brandId;
    data['address'] = this.address;
    data['tatoo'] = this.tatoo;
    return data;
  }
}
