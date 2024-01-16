part of "../logbook_employee.dart";

class LogBookEmployee {
  String? id;
  String? idLogbook;
  int? totalActivity;
  Employee? employee;

  LogBookEmployee({this.id, this.idLogbook, this.totalActivity, this.employee});

  LogBookEmployee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idLogbook = json['id_logbook'];
    totalActivity = json['total_activity'];
    employee =
        json['employee'] != null ? Employee.fromJson(json['employee']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_logbook'] = idLogbook;
    data['total_activity'] = totalActivity;
    if (employee != null) {
      data['employee'] = employee!.toJson();
    }
    return data;
  }
}
