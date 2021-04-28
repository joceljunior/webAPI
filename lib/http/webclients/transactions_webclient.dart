import 'dart:convert';

import 'package:bytebank/http/webClient.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';

class TransactionsWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response = await client
        .get(Uri.parse(baseUrl))
        .timeout(Duration(
          seconds: 5,
        )); // primeiro parametro é o caminho da api + end point API  // importante utilizar HTTPS e alterar o androidManifest

    List<Transaction> transactions = _toTransactions(response);
    return transactions;
  }

  Future<Transaction> save(Transaction transaction) async {
    // transforma esse map em json com Encode
    final String transactionJson = jsonEncode(transaction.toJson());

    //executa post
    final Response response = await client.post(Uri.parse(baseUrl),
        headers: {'Content-type': 'application/json', 'password': '1000'},
        body: transactionJson);

    return Transaction.fromJson(jsonDecode(response.body));
  }

  List<Transaction> _toTransactions(Response response) {
    final List<dynamic> decodedJson = jsonDecode(response.body);
    final List<Transaction> transactions = List();
    for (Map<String, dynamic> transactionJson in decodedJson) {
      // conversao antiga
      // final Map<String, dynamic> contactJson =
      //     transactionJson['contact']; //cria map dos contatos

      // final Transaction transaction = Transaction(
      //   transactionJson['value'],
      //   Contact(
      //     0,
      //     contactJson['name'],
      //     contactJson['accountNumber'],
      //   ),
      // );
      transactions.add(Transaction.fromJson(transactionJson));
    }
    return transactions;
  }

  // FORMA RESUMIDA DA _toTransactions
  // List<Transaction> _toTransactions(Response response) {
  //   final List<dynamic> decodedJson = jsonDecode(response.body);
  //   return decodedJson
  //       .map((dynamic json) => Transaction.fromJson(json))
  //       .toList();
  // }
}
