class Transaction {
  final String id;
  final int amount;
  final DateTime date;
  final String title;

  Transaction({
    required this.id,
    required this.amount,
    required this.date,
    required this.title,
  });
}
