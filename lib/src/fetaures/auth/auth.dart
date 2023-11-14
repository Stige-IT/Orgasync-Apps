

import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:orgasync/src/components/dropdown_container.dart';
import 'package:orgasync/src/components/field_input.dart';
import 'package:orgasync/src/components/show_snackbar.dart';
import 'package:orgasync/src/config/contants/base_url.dart';
import 'package:orgasync/src/models/state.dart';
import 'package:orgasync/src/utils/helper/exception_to_message.dart';
import 'package:orgasync/src/utils/helper/layout/minheight_context.dart';
import 'package:orgasync/src/utils/helper/local_storage/secure_storage_client.dart';

import '../../components/button_switch_language.dart';
import '../../components/circular_loading.dart';
import '../../utils/extensions/page_function.dart';
import 'package:dartz/dartz.dart';

import '../../utils/helper/http_provider/http_provider.dart';
import '../../utils/helper/local_storage/secure_storage.dart';
import 'models/error_account_response.dart';

part "models/company_request.dart";
part "data/auth_api.dart";
part "enum/type_user.dart";
part "provider/auth_notifier.dart";
part "ui/verification_screen.dart";
part 'ui/register/role_screen.dart';
part 'ui/login/login_screen.dart';
part 'ui/register/register_screen.dart';
part 'ui/register/register_employee_widget.dart';
part "ui/register/register_company_widget.dart";
part 'provider/auth_provider.dart';