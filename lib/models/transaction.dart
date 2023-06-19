import 'package:intl/intl.dart';

class Transaction {
  Transaction({
    required this.status,
    required this.message,
    required this.total,
    required this.data,
  });

  late final String status;
  late final String message;
  late final String total;
  late final List<TransactionData> data;

  Transaction.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    total = json['total'];
    data = List.from(json['data']).map((e) => TransactionData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final itemData = <String, dynamic>{};
    itemData['status'] = status;
    itemData['message'] = message;
    itemData['total'] = total;
    itemData['data'] = data.map((e) => e.toJson()).toList();
    return itemData;
  }
}

class TransactionData {
  TransactionData({
    required this.id,
    required this.transactionType,
    required this.txnId,
    required this.type,
    required this.amount,
    required this.status,
    required this.message,
    required this.createdAt,
  });

  late final String id;
  late final String transactionType;
  late final String txnId;
  late final String type;
  late final String amount;
  late final String status;
  late final String message;
  late final String createdAt;

  TransactionData.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    transactionType = json['transaction_type'].toString();
    txnId = json['txn_id'].toString();
    type = json['type'].toString();
    amount = json['amount'].toString();
    status = json['status'].toString();
    message = json['message'].toString();
    DateTime dateTime = DateTime.parse(json['created_at'].toString());
    createdAt = DateFormat('dd-MMM-yyyy').format(dateTime);
  }

  Map<String, dynamic> toJson() {
    final itemData = <String, dynamic>{};
    itemData['id'] = id;
    itemData['transaction_type'] = transactionType;
    itemData['txn_id'] = txnId;
    itemData['type'] = type;
    itemData['amount'] = amount;
    itemData['status'] = status;
    itemData['message'] = message;
    itemData['created_at'] = createdAt;
    return itemData;
  }
}
