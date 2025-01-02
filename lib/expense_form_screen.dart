import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_expense_tracker/expense_form_screen.dart';
import 'expense_provider.dart';
import 'expense_model.dart';

class ExpenseFormScreen extends StatefulWidget {
  @override
  _ExpenseFormScreenState createState() => _ExpenseFormScreenState();
}

class _ExpenseFormScreenState extends State<ExpenseFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  double _amount = 0;
  DateTime _selectedDate = DateTime.now();
  String _category = '';

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Add Expense')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                onSaved: (value) => _title = value ?? '',
                validator: (value) =>
                value!.isEmpty ? 'Title cannot be empty' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _amount = double.tryParse(value ?? '0') ?? 0,
                validator: (value) =>
                value!.isEmpty ? 'Amount cannot be empty' : null,
              ),
              TextButton(
                child: Text('Select Date'),
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() => _selectedDate = pickedDate);
                  }
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Category'),
                items: ['Food', 'Travel', 'Shopping', 'Other']
                    .map((category) =>
                    DropdownMenuItem(value: category, child: Text(category)))
                    .toList(),
                onChanged: (value) => _category = value ?? '',
                validator: (value) =>
                value == null || value.isEmpty ? 'Select a category' : null,
              ),
              Spacer(),
              ElevatedButton(
                child: Text('Save'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final newExpense = Expense(
                      title: _title,
                      amount: _amount,
                      date: _selectedDate,
                      category: _category,
                    );
                    expenseProvider.addExpense(newExpense);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
