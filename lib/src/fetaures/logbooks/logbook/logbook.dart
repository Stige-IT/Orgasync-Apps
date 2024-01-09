import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orgasync/src/components/avatar_profile.dart';
import 'package:orgasync/src/components/field_input.dart';
import 'package:orgasync/src/config/contants/base_url.dart';
import 'package:orgasync/src/fetaures/company/company.dart';
import 'package:orgasync/src/fetaures/logbooks/logbook_employee/logbook_employee.dart';
import 'package:orgasync/src/models/response_data.dart';
import 'package:orgasync/src/models/state.dart';
import 'package:orgasync/src/utils/extensions/formatted_date.dart';
import 'package:orgasync/src/utils/extensions/page_function.dart';
import 'package:orgasync/src/utils/helper/datetime_picker.dart';
import 'package:orgasync/src/utils/helper/exception_to_message.dart';
import 'package:orgasync/src/utils/helper/http_provider/http_request_client.dart';
import 'package:orgasync/src/utils/helper/local_storage/secure_storage.dart';
import 'package:orgasync/src/utils/helper/local_storage/secure_storage_client.dart';
import 'package:orgasync/src/utils/helper/theme_of_context.dart';

import '../../../components/circular_loading.dart';
import '../../../components/empty_widget.dart';
import '../../../components/error_button.dart';
import '../../../components/show_snackbar.dart';
import 'models/logbook.dart';

part "data/logbook_api.dart";
part "provider/logbook_notifier.dart";
part "provider/logbook_provider.dart";
part "ui/logbook_screen.dart";
part "ui/form/form_logbook.dart";
part "ui/detail/detail_logbook_screen.dart";
