import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:orgasync/src/models/address.dart';
import 'package:orgasync/src/utils/helper/http_provider/http_provider.dart';

import '../../config/contants/base_url.dart';
import '../../models/country.dart';
import '../../models/state.dart';
import '../../utils/helper/exception_to_message.dart';

part 'data/address_api.dart';
part 'provider/address_notifier.dart';
part 'provider/address_provider.dart';
