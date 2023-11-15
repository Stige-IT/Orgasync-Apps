import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orgasync/src/components/circular_loading.dart';
import 'package:orgasync/src/components/error_button.dart';
import 'package:orgasync/src/components/field_input.dart';
import 'package:orgasync/src/components/show_snackbar.dart';
import 'package:orgasync/src/fetaures/company/company.dart';
import 'package:orgasync/src/fetaures/user/user.dart';
import 'package:orgasync/src/utils/helper/layout/media_query_context.dart';
import 'package:orgasync/src/utils/helper/theme_of_context.dart';

import '../../utils/extensions/page_function.dart';
import '../../utils/helper/local_storage/secure_storage_client.dart';


part "ui/home_screen.dart";
part "ui/companies_widget.dart";
part "widgets/card_company.dart";