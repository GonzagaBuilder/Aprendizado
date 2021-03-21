import 'dart:math';

import 'package:annual_financial_planning/models/expense_transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'expense_form.dart';

//                                         Tarefas:

//Formatar a linha principal
//Criar um botão para maximizar a janela dessas despesas em uma página que se sobreponha a tudo
//Resolver o datePicker
//Adicionar as possibilidades de edição para qualquer célula
//Criar uma chave para agrupar a despesa ou não
//Criar chave para modificar a despesa para "Constante" ou "Variável"
//Formatar a linha dos dados
//colorir uma linha sim outra nao

class ExpenseTable extends StatefulWidget {
  @override
  _ExpenseTableState createState() => _ExpenseTableState();
}

class _ExpenseTableState extends State<ExpenseTable> {
  // DateTime _selectedDate = DateTime.now();

  final List<ExpenseTransaction> expenseTransactions = [];

  _addExpenseTransaction(
      String title,
      double expectedValue,
      double value,
      DateTime date,
      String recurrence,
      String paymentMethod,
      String creditCardName) {
    final newExpenseTransaction = ExpenseTransaction(
      id: Random().nextDouble().toString(),
      title: title,
      expectedValue: expectedValue,
      value: value,
      date: date,
      recurrence: recurrence,
      paymentMethod: paymentMethod,
      creditCardName: creditCardName,
    );

    setState(() {
      expenseTransactions.add(newExpenseTransaction);
    });

    Navigator.of(context).pop();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ExpenseForm(_addExpenseTransaction);
      },
    );
  }

  // _showDatePicker() {
  //   showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(DateTime.now().year),
  //     lastDate: DateTime.now(),
  //   ).then((pickedDate) {
  //     if (pickedDate == null) {
  //       return;
  //     }
  //     setState(() {
  //       _selectedDate = pickedDate;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('Day'),
          Text('Title'),
          Text('Expected'),
          Text('Value'),
        ],
      ),
      Expanded(
        flex: 1,
        child: SingleChildScrollView(
          child: DataTable(
            columnSpacing: 0,
            headingRowHeight: 0,
            dataRowHeight: 24,
            columns: [
              DataColumn(label: Text(' ')),
              DataColumn(label: Text(' ')),
              DataColumn(label: Text(' ')),
              DataColumn(label: Text(' ')),
            ],
            rows: expenseTransactions.map((row) {
              return DataRow(cells: [
                DataCell(
                  Text(
                    DateFormat('d').format(row.date).toString(),
                  ),
                  // onTap: _showDatePicker,
                ),
                DataCell(
                  Text(row.title),
                ),
                DataCell(
                  Text(
                    NumberFormat.simpleCurrency().format(row.expectedValue),
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    NumberFormat.simpleCurrency().format(row.value),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                ),
              ]);
            }).toList(),
          ),
        ),
      ),
      ElevatedButton(
        onPressed: () => _openTransactionFormModal(context),
        child: Icon(Icons.add),
      ),
    ]);
  }
}
