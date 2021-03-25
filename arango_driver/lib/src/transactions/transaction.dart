import 'package:arango_driver/src/transactions/transaction_status.dart';

class Transaction {
  final String id;
  final TransactionStatuses state;

  const Transaction({
    required this.id,
    required this.state,
  });
}
