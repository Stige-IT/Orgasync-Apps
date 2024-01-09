part of "../logbook_activity.dart";

class LogBookActivity {
  String? month;
  List<Activities>? activities;

  LogBookActivity({this.month, this.activities});

  LogBookActivity.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    if (json['activities'] != null) {
      activities = <Activities>[];
      json['activities'].forEach((v) {
        activities!.add(Activities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month'] = month;
    if (activities != null) {
      data['activities'] = activities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Activities {
  String? idLogbook;
  String? id;
  String? description;
  String? image;
  String? createdAt;
  String? idLogbookEmployee;
  int? rating;

  Activities(
      {this.idLogbook,
      this.id,
      this.description,
      this.image,
      this.createdAt,
      this.idLogbookEmployee,
      this.rating});

  Activities.fromJson(Map<String, dynamic> json) {
    idLogbook = json['id_logbook'];
    id = json['id'];
    description = json['description'];
    image = json['image'];
    createdAt = json['created_at'];
    idLogbookEmployee = json['id_logbook_employee'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_logbook'] = idLogbook;
    data['id'] = id;
    data['description'] = description;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['id_logbook_employee'] = idLogbookEmployee;
    data['rating'] = rating;
    return data;
  }
}
