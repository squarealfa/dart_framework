import 'package:arango_driver/src/transactions/transaction_states.dart';

class Transaction {
  final String id;
  final TransactionStates state;

  const Transaction({
    required this.id,
    required this.state,
  });
}
