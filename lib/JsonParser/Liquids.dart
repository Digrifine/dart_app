// To parse this JSON data, do
//
//     final liquid = liquidFromJson(jsonString);

import 'dart:convert';

List<Liquid> liquidFromJson(String str) =>
    List<Liquid>.from(json.decode(str).map((x) => Liquid.fromJson(x)));

String liquidToJson(List<Liquid> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Liquid {
  Liquid({
    this.name,
    this.url,
    this.zhitkostCost,
    this.zhidkostImg,
    this.zhidkostImgUrl,
  });

  String name;
  String url;
  String zhitkostCost;
  String zhidkostImg;
  String zhidkostImgUrl;

  factory Liquid.fromJson(Map<String, dynamic> json) => Liquid(
        name: json["name"],
        url: json["url"],
        zhitkostCost: json["zhitkost_cost"],
        zhidkostImg: json["zhidkost_img"],
        zhidkostImgUrl: json["zhidkost_img_url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
        "zhitkost_cost": zhitkostCost,
        "zhidkost_img": zhidkostImg,
        "zhidkost_img_url": zhidkostImgUrl,
      };
}
