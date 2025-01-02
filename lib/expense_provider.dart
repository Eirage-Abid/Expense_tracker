import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'expense_model.dart';

class ExpenseProvider extends ChangeNotifier {
  final Box _expenseBox = Hive.box('expenses');

  List<Expense> get expenses => _expenseBox.values.cast<Expense>().toList();

  void addExpense(Expense expense) {
    _expenseBox.add(expense);
    notifyListeners();
  }

  void updateExpense(int index, Expense updatedExpense) {
    _expenseBox.putAt(index, updatedExpense);
    notifyListeners();
  }

  void deleteExpense(int index) {
    _expenseBox.deleteAt(index);
    notifyListeners();
  }

  double get totalExpenses =>
      expenses.fold(0, (sum, expense) => sum + expense.amount);

  double getMonthlyExpenses(DateTime month) {
    return expenses
        .where((expense) =>
    expense.date.year == month.year && expense.date.month == month.month)
        .fold(0, (sum, expense) => sum + expense.amount);
  }

  Map<String, double> getCategoryWiseExpenses() {
    Map<String, double> categoryTotals = {};
    for (var expense in expenses) {
      categoryTotals[expense.category] =
          (categoryTotals[expense.category] ?? 0) + expense.amount;
    }
    return categoryTotals;
  }
}
