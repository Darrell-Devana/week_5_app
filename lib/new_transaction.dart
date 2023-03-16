import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  const NewTransaction(this.addTx, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = int.parse(_amountController.text);

    if (_amountController.text.isEmpty ||
        enteredTitle.isEmpty ||
        enteredAmount <= 0) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    CupertinoDatePicker(onDateTimeChanged: (DateTime value) {  },

    )
        .then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _selectedDate = pickedDate;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(labelText: 'Title'),
          controller: _titleController,
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Amount'),
          controller: _amountController,
          keyboardType: TextInputType.number,
        ),
        Row(
          children: [
            Expanded(
              // ignore: unnecessary_null_comparison
              child: Text(_selectedDate == null
                  ? 'No date chosen'
                  : 'Picked date: ${DateFormat.yMMMEd().format(_selectedDate)}'),
            ),
            TextButton(
              onPressed: _presentDatePicker,
              child: const Text('Choose Date'),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () => _submitData(),
          child: const Text('Add Transaction'),
        ),
      ],
    );
  }
}
