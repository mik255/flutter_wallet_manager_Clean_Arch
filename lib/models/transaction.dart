class Transaction{
  String name;
  String date;
  String amount;
  String installments;
  String bankName;

  Transaction({
    required this.name,
    required this.date,
    required this.amount,
    required this.installments,
    required this.bankName,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date,
      'amount': amount,
      'installments': installments,
      'bankName': bankName,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      name: map['name'] as String,
      date: map['date'] as String,
      amount: map['amount'] as String,
      installments: map['installments'] as String,
      bankName: map['bankName'] as String,
    );
  }
}