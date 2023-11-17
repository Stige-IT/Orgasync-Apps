import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:orgasync/src/fetaures/company/ui/widgets/stacked_widget.dart';
import 'package:orgasync/src/models/state.dart';
import 'package:orgasync/src/utils/helper/exception_to_message.dart';
import 'package:orgasync/src/utils/helper/http_provider/http_provider.dart';
import 'package:orgasync/src/utils/helper/local_storage/secure_storage.dart';
import 'package:orgasync/src/utils/helper/local_storage/secure_storage_client.dart';
import 'package:orgasync/src/utils/helper/theme_of_context.dart';

import '../../config/contants/base_url.dart';
import '../../models/address.dart';
import '../../models/position.dart';
import '../../models/response_data.dart';

part "models/my_company.dart";
part "models/company.dart";
part "models/type_employee.dart";
part 'data/company_api.dart';
part 'provider/company_notifier.dart';
part "provider/company_provider.dart";
part 'ui/dasboard/dashboard_screen.dart';