import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:orgasync/src/components/dialog_loading.dart';
import 'package:orgasync/src/components/field_input.dart';
import 'package:orgasync/src/components/show_snackbar.dart';
import 'package:orgasync/src/config/contants/base_url.dart';
import 'package:orgasync/src/fetaures/company/company.dart';
import 'package:orgasync/src/fetaures/employee/employee.dart';
import 'package:orgasync/src/fetaures/employee/models/employee.dart';
import 'package:orgasync/src/models/response_data.dart';
import 'package:orgasync/src/models/state.dart';
import 'package:orgasync/src/utils/extensions/first_name_formatted.dart';
import 'package:orgasync/src/utils/extensions/formatted_date.dart';
import 'package:orgasync/src/utils/extensions/page_function.dart';
import 'package:orgasync/src/utils/helper/exception_to_message.dart';
import 'package:orgasync/src/utils/helper/http_provider/http_provider.dart';
import 'package:orgasync/src/utils/helper/http_provider/http_request_client.dart';
import 'package:orgasync/src/utils/helper/layout/minheight_context.dart';
import 'package:orgasync/src/utils/helper/local_storage/secure_storage.dart';
import 'package:orgasync/src/utils/helper/local_storage/secure_storage_client.dart';
import 'package:orgasync/src/utils/helper/theme_of_context.dart';

import '../../components/circle_avatar_network.dart';
import '../../components/circular_loading.dart';
import '../../components/dropdown_container.dart';
import '../../components/empty_widget.dart';
import '../../components/error_button.dart';
import '../../components/profile_with_name.dart';
import '../../config/contants/constant_app.dart';

part 'company_project/data/company_project_api.dart';
part "models/company_project.dart";
part "models/project.dart";
part "models/employee_company_project.dart";
part "status/model/status.dart";
part "task/model/task.dart";
part "task/model/task_data.dart";
part "widgets/project_item.dart";
part "widgets/card_project.dart";
part "project/ui/detail/widget/header_widget.dart";
part "project/ui/detail/widget/section_task_widget.dart";
part "company_project/provider/company_project_notifier.dart";
part "company_project/provider/company_project_provider.dart";

part "company_project/ui/company_project_screen.dart";
part "company_project/ui/form/form_company_project.dart";
part 'company_project/ui/employee_project/add_employee_project_screen.dart';
part "company_project/ui/employee_project/dialog_candidate_employee_project_widget.dart";
part "company_project/ui/detail/detail_company_project_screen.dart";
part "company_project/ui/employee_project/list_employe_project_screen.dart";

// project
part "project/data/project_api.dart";
part "project/ui/detail/widget/dialog_form_task_widget.dart";
part "task/data/task_api.dart";
part "status/data/status_api.dart";

part "project/provider/project_provider.dart";
part "project/provider/project_notifier.dart";

part "task/provider/task_notifier.dart";
part "task/provider/task_provider.dart";
part "task/ui/detail/detail_task_screen.dart";

part "status/provider/status_provider.dart";
part "status/provider/status_notifier.dart";

part "priority/data/priority_api.dart";
part "priority/provider/priority_notifier.dart";
part "priority/provider/priority_provider.dart";
part "priority/model/priority.dart";

part "project/ui/project_screen.dart";
part "project/ui/form/form_project_screen.dart";
part "project/ui/detail/detail_project_screen.dart";
