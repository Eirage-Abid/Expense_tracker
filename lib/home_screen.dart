import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'expense_provider.dart';
import 'expense_form_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Expense Tracker')),
      body: ListView.builder(
        itemCount: expenseProvider.expenses.length,
        itemBuilder: (context, index) {
          final expense = expenseProvider.expenses[index];
          return ListTile(
            title: Text(expense.title),
            subtitle: Text(
              '${expense.category} - \$${expense.amount.toStringAsFixed(2)}',
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => expenseProvider.deleteExpense(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ExpenseFormScreen()),
          );
        },
      ),
    );
  }
}
