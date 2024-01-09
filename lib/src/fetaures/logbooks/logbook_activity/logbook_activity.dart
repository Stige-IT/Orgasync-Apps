import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:orgasync/src/components/dialog_loading.dart';
import 'package:orgasync/src/components/field_input.dart';
import 'package:orgasync/src/fetaures/company/company.dart';
import 'package:orgasync/src/fetaures/logbooks/logbook/logbook.dart';
import 'package:orgasync/src/models/state.dart';
import 'package:orgasync/src/utils/extensions/formatted_date.dart';
import 'package:orgasync/src/utils/helper/theme_of_context.dart';
import 'package:photo_view/photo_view.dart';

import '../../../components/circular_loading.dart';
import '../../../components/empty_widget.dart';
import '../../../components/error_button.dart';
import '../../../components/show_snackbar.dart';
import '../../../config/contants/base_url.dart';
import '../../../utils/helper/exception_to_message.dart';
import '../../../utils/helper/http_provider/http_request_client.dart';

part "models/logbook_activity.dart";
part "data/logbook_activity_api.dart";
part "provider/logbook_activity_notifier.dart";
part "provider/logbook_activity_provider.dart";
part "ui/logbook_activity_screen.dart";
part "ui/form/form_logbook_activity_screen.dart";
