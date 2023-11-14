import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orgasync/src/utils/helper/local_storage/secure_storage.dart';

final storageProvider = Provider<SecureStorage>((ref) {
  return SecureStorage() ;
});
