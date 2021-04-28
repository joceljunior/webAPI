import 'dart:convert';
import 'package:bytebank/http/interceptors/logging_interceptor.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

Client client = HttpClientWithInterceptor.build(interceptors: [
  LoggingInterceptor()
]); // implementacao de client para obter log

const String baseUrl = 'http://172.26.192.1:8080/transactions';
