import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:orgasync/src/fetaures/auth/auth.dart';
import 'package:orgasync/src/models/state.dart';
import 'package:orgasync/src/utils/helper/exception_to_message.dart';

import '../../config/contants/base_url.dart';
import '../../utils/helper/http_provider/http_provider.dart';
import '../../utils/helper/local_storage/secure_storage.dart';
import '../../utils/helper/local_storage/secure_storage_client.dart';

part "models/user_data.dart";
part "data/user_api.dart";
part "provider/user_provider.dart";
part 'provider/user_notifier.dart';