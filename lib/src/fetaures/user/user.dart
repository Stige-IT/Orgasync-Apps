import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:orgasync/src/components/circle_avatar_network.dart';
import 'package:orgasync/src/components/empty_widget.dart';
import 'package:orgasync/src/components/error_button.dart';
import 'package:orgasync/src/fetaures/auth/auth.dart';
import 'package:orgasync/src/models/state.dart';
import 'package:orgasync/src/utils/helper/exception_to_message.dart';
import 'package:orgasync/src/utils/helper/layout/media_query_context.dart';
import 'package:orgasync/src/utils/helper/layout/minheight_context.dart';
import 'package:orgasync/src/utils/helper/theme_of_context.dart';

import '../../components/circular_loading.dart';
import '../../config/contants/base_url.dart';
import '../../utils/extensions/page_function.dart';
import '../../utils/helper/http_provider/http_provider.dart';
import '../../utils/helper/local_storage/secure_storage.dart';
import '../../utils/helper/local_storage/secure_storage_client.dart';

part "models/user_data.dart";
part "data/user_api.dart";
part "provider/user_provider.dart";
part 'provider/user_notifier.dart';
part 'ui/profile/profile_screen.dart';
part 'ui/widgets/total_join_widget.dart';
part "ui/profile/appbar_widget.dart";
part "ui/profile/profile_data_widget.dart";
part "ui/profile/setting_widget.dart";
part "ui/form/form_profile_screen.dart";