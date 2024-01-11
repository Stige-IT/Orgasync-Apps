import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orgasync/src/components/circle_avatar_network.dart';
import 'package:orgasync/src/components/empty_widget.dart';
import 'package:orgasync/src/components/error_button.dart';
import 'package:orgasync/src/components/profile_with_name.dart';
import 'package:orgasync/src/fetaures/company/ui/widgets/stacked_widget.dart';
import 'package:orgasync/src/fetaures/logbooks/logbook/logbook.dart';
import 'package:orgasync/src/fetaures/projects/project.dart';
import 'package:orgasync/src/fetaures/user/user.dart';
import 'package:orgasync/src/models/state.dart';
import 'package:orgasync/src/utils/extensions/formatted_date.dart';
import 'package:orgasync/src/utils/extensions/page_function.dart';
import 'package:orgasync/src/utils/helper/exception_to_message.dart';
import 'package:orgasync/src/utils/helper/http_provider/http_provider.dart';
import 'package:orgasync/src/utils/helper/layout/minheight_context.dart';
import 'package:orgasync/src/utils/helper/local_storage/secure_storage.dart';
import 'package:orgasync/src/utils/helper/local_storage/secure_storage_client.dart';
import 'package:orgasync/src/utils/helper/theme_of_context.dart';
import 'package:string_to_color/string_to_color.dart';

import '../../components/circular_loading.dart';
import '../../components/dropdown_container.dart';
import '../../components/field_input.dart';
import '../../components/show_snackbar.dart';
import '../../config/contants/base_url.dart';
import '../../models/address.dart';
import '../../models/response_data.dart';
import '../../utils/helper/http_provider/http_request_client.dart';
import '../employee/employee.dart';

part "models/company_request.dart";
part "models/my_company.dart";
part "models/company.dart";
part "models/type_employee.dart";
part "models/type_company.dart";
part "models/position.dart";
part "models/company_detail.dart";
part "models/employee_company.dart";

part 'data/company_api.dart';
part "data/type_company_api.dart";

part "enums/role.dart";

part 'provider/company_notifier.dart';
part "provider/company_provider.dart";
part "provider/type_company_notifier.dart";
part 'provider/type_company_provider.dart';

part "ui/widgets/tile_menu.dart";
part 'ui/dasboard/dashboard_screen.dart';
part 'ui/dasboard/home/dashboard_home_widget.dart';
part 'ui/dasboard/task/dashboard_task_widget.dart';
part 'ui/dasboard/more/dashboard_more_widget.dart';
part "ui/form/create_company_screen.dart";
part "ui/form/dialog_edit_company.dart";
