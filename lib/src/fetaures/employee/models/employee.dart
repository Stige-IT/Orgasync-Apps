import 'package:orgasync/src/fetaures/user/user.dart';

import '../../../models/position.dart';
import '../../../models/type_employee.dart';

class Employee {
  String? id;
  String? joined;
  String? end;
  TypeEmployee? type;
  Position? position;
  UserData? user;

  Employee(
      {this.id, this.joined, this.end, this.type, this.position, this.user});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    joined = json['joined'];
    end = json['end'];
    type = json['type'] != null ? TypeEmployee.fromJson(json['type']) : null;
    position =
        json['position'] != null ? Position.fromJson(json['position']) : null;
    user = json['user'] != null ? UserData.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['joined'] = joined;
    data['end'] = end;
    if (type != null) {
      data['type'] = type!.toJson();
    }
    if (position != null) {
      data['position'] = position!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
