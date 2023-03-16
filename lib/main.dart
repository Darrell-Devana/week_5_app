import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'transaction.dart';
import 'new_transaction.dart';
import 'transaction_list.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Expense App',
      theme: CupertinoThemeData(),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _addNewTransition(String txTitle, int txAmount, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        amount: txAmount,
        date: chosenDate,
        title: txTitle);

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  // ignore: non_constant_identifier_names
  void _InputWindow(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return NewTransaction(_addNewTransition);
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  final List<Transaction> _userTransaction = [];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final navBar = CupertinoNavigationBar(
      middle: Text('Expense App'),
    );

    return Column(
      children: [
        CupertinoPageScaffold(
          navigationBar: navBar,
          child: SingleChildScrollView(
            child: SizedBox(
              height: mediaQuery.size.height -
                  navBar.preferredSize.height -
                  mediaQuery.padding.top,
              child: TransactionList(_userTransaction, _deleteTransaction),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 70),
          child: FloatingActionButton(
            onPressed: () => _InputWindow(context),
          ),
        )
      ],
    );
  }
}
