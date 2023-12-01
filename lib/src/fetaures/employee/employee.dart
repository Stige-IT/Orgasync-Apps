import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:orgasync/src/components/circle_avatar_network.dart';
import 'package:orgasync/src/components/profile_with_name.dart';
import 'package:orgasync/src/fetaures/employee/models/employee.dart';
import 'package:orgasync/src/models/response_data.dart';
import 'package:orgasync/src/utils/helper/http_provider/http_provider.dart';
import 'package:orgasync/src/utils/helper/local_storage/secure_storage_client.dart';
import 'package:orgasync/src/utils/helper/theme_of_context.dart';

import '../../components/circular_loading.dart';
import '../../components/empty_widget.dart';
import '../../components/error_button.dart';
import '../../config/contants/base_url.dart';
import '../../models/state.dart';
import '../../utils/helper/exception_to_message.dart';
import '../../utils/helper/local_storage/secure_storage.dart';

part "data/employee_api.dart";

part "provider/employee_notifier.dart";
part "provider/employee_provider.dart";

part "ui/employee_screen.dart";
part "ui/widgets/employee_item.dart";
