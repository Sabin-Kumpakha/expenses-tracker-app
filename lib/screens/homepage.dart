// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:expensestracker/expenses.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController categoryController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Add Expense"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: categoryController,
                        decoration: const InputDecoration(
                          hintText: "Enter Category",
                        ),
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: amountController,
                        decoration: const InputDecoration(
                          hintText: "Enter Amount",
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        if (amountController.text.isEmpty ||
                            categoryController.text.isEmpty) {
                          return;
                        }
                        setState(() {
                          expenses.add(Expenses(
                              getId(),
                              categoryController.text,
                              double.parse(amountController.text),
                              DateTime.now()));
                          categoryController.clear();
                          amountController.clear();
                          Navigator.of(context).pop();
                        });
                      },
                      child: const Text("Add"),
                    ),
                  ],
                );
              },
            );
          });
        },
        child: Icon(Icons.add),
      ),

      //APPBAR
      appBar: AppBar(
        title: const Text("Expenses App"),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Total Expenses"),
                    content: Text("Total Expenses: Rs ${getTotalExpenses()}"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Ok"),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.attach_money),
          ),
        ],
      ),

      //Body
      body: expenses.isEmpty
          ? const Center(
              child: Text(
                "No expenses found, Click on + to add expenses",
                style: TextStyle(fontSize: 16.0),
              ),
            )
          : ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text((index + 1).toString()),
                    // child: Text(expenses[index].id.toString()),
                  ),
                  title: Text(expenses[index].category),
                  subtitle: Text("Rs ${expenses[index].amount}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          String category = categoryController.text;
                          double amount = double.parse(amountController.text);
                          DateTime date = DateTime.now();
                          Expenses ex = Expenses(
                              expenses[index].id, category, amount, date);
                          setState(() {
                            expenses[index] = ex;
                          });
                        },
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            expenses.removeAt(index);
                          });
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              }),
    );
  }
}
