import 'dart:convert';

class KindergartenModel {
  final int? first;
  late final int? prev;
  final int? next;
  final int? last;
  final int? pages;
  final int? items;
  final List<KindergartenDataModel>? data;

  KindergartenModel({
    this.first,
    this.prev,
    this.next,
    this.last,
    this.pages,
    this.items,
    this.data,
  });

  factory KindergartenModel.fromRawJson(String str) =>
      KindergartenModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory KindergartenModel.fromJson(Map<String, dynamic> json) =>
      KindergartenModel(
        first: json["first"],
        prev: json["prev"],
        next: json["next"],
        last: json["last"],
        pages: json["pages"],
        items: json["items"],
        data: json["data"] == null
            ? []
            : List<KindergartenDataModel>.from(
                json["data"]!.map((x) => KindergartenDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "prev": prev,
        "next": next,
        "last": last,
        "pages": pages,
        "items": items,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class KindergartenDataModel {
  final String? id;
  final String? name;
  final String? description;
  final String? imageUrl;
  final String? city;
  String? state;
  final String? contactPerson;
  final String? contactNo;
  bool? value;

  KindergartenDataModel({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.city,
    this.state,
    this.contactPerson,
    this.contactNo,
    this.value,
  });

  factory KindergartenDataModel.fromRawJson(String str) =>
      KindergartenDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory KindergartenDataModel.fromJson(Map<String, dynamic> json) =>
      KindergartenDataModel(
          id: json["id"],
          name: json["name"],
          description: json["description"],
          imageUrl: json["imageUrl"],
          city: json["city"],
          state: json["state"],
          contactPerson: json["contact_person"],
          contactNo: json["contact_no"],
          value: json['value']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "imageUrl": imageUrl,
        "city": city,
        "state": state,
        "contact_person": contactPerson,
        "contact_no": contactNo,
        "value": value
      };
}
