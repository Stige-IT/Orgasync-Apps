import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:orgasync/src/config/contants/base_url.dart';
import 'package:orgasync/src/models/response_data.dart';
import 'package:orgasync/src/models/state.dart';
import 'package:orgasync/src/utils/extensions/formatted_date.dart';
import 'package:orgasync/src/utils/helper/exception_to_message.dart';
import 'package:orgasync/src/utils/helper/http_provider/http_provider.dart';
import 'package:orgasync/src/utils/helper/local_storage/secure_storage.dart';
import 'package:orgasync/src/utils/helper/local_storage/secure_storage_client.dart';
import 'package:orgasync/src/utils/helper/theme_of_context.dart';

import '../../components/circular_loading.dart';
import '../../components/empty_widget.dart';
import '../../components/error_button.dart';

part 'company_project/data/company_project_api.dart';
part "models/company_project.dart";
part "company_project/provider/company_project_notifier.dart";
part "company_project/provider/company_project_provider.dart";

part "company_project/ui/company_project_screen.dart";
