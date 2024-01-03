import 'package:easy_localization/easy_localization.dart';
import 'package:orgasync/src/fetaures/company/company.dart';

extension CompanyJoinedFormat on MyCompany {
  String get joinedFormat {
    DateTime joined = DateTime.parse(this.joined!);
    String joinedFormat = DateFormat("MMMM yyyy").format(joined);
    if (end != null) {
      final end = DateTime.parse(this.end!);
      String endFormat = DateFormat("MMMM yyyy").format(end);
      return "$joinedFormat - $endFormat";
    }
    String now = "present".tr();
    return "$joinedFormat - $now";
  }

  String get typePositionFormat {
    if (position == null && typeEmployee == null) return "-";

    if (position == null) {
      return "${typeEmployee!.name}";
    }
    return "${typeEmployee!.name} | ${position!.name}";
  }
}
