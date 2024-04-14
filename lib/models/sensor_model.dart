import 'dart:convert';

Sensor sensorFromJson(String str) => Sensor.fromJson(json.decode(str));

String sensorToJson(Sensor data) => json.encode(data.toJson());

class Sensor {
  bool success;
  int statusCode;
  List<Datum> data;

  Sensor({
    required this.success,
    required this.statusCode,
    required this.data,
  });

  factory Sensor.fromJson(Map<String, dynamic> json) => Sensor(
        success: json["success"],
        statusCode: json["statusCode"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "statusCode": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String id;
  num suhu;
  num ph;
  num turbidity;
  num tds;
  DateTime waktu;
  int v;

  Datum({
    required this.id,
    required this.suhu,
    required this.ph,
    required this.turbidity,
    required this.tds,
    required this.waktu,
    required this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        suhu: json["suhu"],
        ph: json["ph"],
        turbidity: json["turbidity"],
        tds: json["tds"],
        waktu: DateTime.parse(json["waktu"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "suhu": suhu,
        "ph": ph,
        "turbidity": turbidity,
        "tds": tds,
        "waktu": waktu.toIso8601String(),
        "__v": v,
      };
}
