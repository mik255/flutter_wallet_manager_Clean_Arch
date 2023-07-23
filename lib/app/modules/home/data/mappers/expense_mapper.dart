import 'package:wallet_manager/app/modules/home/domain/models/expense.dart';

class ExpenseMapper {


  Expense fromMapToEntity(Map<String, dynamic> map) {
    return Expense(
      name: map['name'],
      category: map['category'],
      value: map['value'],
      date: map['date'],
      isPaid: map['isPaid'],
    );
  }
  Map<String,dynamic> toMap(Expense expense) {
    return {
      'name': expense.name,
      'category': expense.category,
      'value': expense.value,
      'date': expense.date,
      'isPaid': expense.isPaid,
    };
  }
  List<Expense> getList(List<dynamic> list) {
    return list.map((e) => fromMapToEntity(e)).toList();
  }
  List<Map<String,dynamic>> toMapList(List<Expense> list) {
    return list.map((e) => toMap(e)).toList();
  }
}
