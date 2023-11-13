import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final httpProvider = Provider<Client>((ref) {
  return Client() ;
});
