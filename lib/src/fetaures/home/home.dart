import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:orgasync/src/components/circular_loading.dart';
import 'package:orgasync/src/components/error_button.dart';
import 'package:orgasync/src/components/field_input.dart';
import 'package:orgasync/src/components/profile_with_name.dart';
import 'package:orgasync/src/components/show_snackbar.dart';
import 'package:orgasync/src/fetaures/company/company.dart';
import 'package:orgasync/src/fetaures/user/user.dart';
import 'package:orgasync/src/utils/extensions/company_joined_format.dart';
import 'package:orgasync/src/utils/helper/layout/media_query_context.dart';
import 'package:orgasync/src/utils/helper/layout/minheight_context.dart';
import 'package:orgasync/src/utils/helper/theme_of_context.dart';

import '../../components/circle_avatar_network.dart';
import '../../components/empty_widget.dart';
import '../../utils/extensions/page_function.dart';

part "ui/home_screen.dart";
part "ui/companies_widget.dart";
part "widgets/card_company.dart";
