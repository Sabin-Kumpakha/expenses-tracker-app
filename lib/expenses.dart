class Expenses {
  int id;
  String category;
  double amount;
  DateTime date;

  Expenses(this.id, this.category, this.amount, this.date);
}

List<Expenses> expenses = [
  Expenses(1, 'Food', 100, DateTime.parse("2023-01-01")),
  Expenses(2, 'Transport', 200, DateTime.parse("2023-01-02")),
  Expenses(3, 'Books', 300, DateTime.parse("2023-01-03")),
  Expenses(4, 'Medicines', 400, DateTime.parse("2023-01-04")),
  Expenses(5, 'Water', 500, DateTime.parse("2023-01-05")),
  Expenses(6, 'Electricity', 600, DateTime.parse("2023-01-06")),
  Expenses(7, 'Fruits', 700, DateTime.parse("2023-01-07")),
  Expenses(8, 'Clothes', 800, DateTime.parse("2023-01-08")),
  Expenses(9, 'Internet', 900, DateTime.parse("2023-01-09")),
  Expenses(10, 'Travel', 1000, DateTime.now()),
];

getId() {
  if (expenses.isEmpty) {
    return 1;
  } else {
    return expenses.length + 1;
  }
}

getTotalExpenses() {
  double total = 0;
  for (Expenses i in expenses) {
    total += i.amount;
  }
  return total;
}

deleteExpenses(int id) {
  if (expenses.isEmpty) {
    return;
  } else {
    expenses.removeWhere((element) => element.id == id);
  }
}

editExpenses(int id, Expenses ex) {
  if (expenses.isEmpty) {
    return;
  } else {
    for (Expenses i in expenses) {
      if (i.id == id) {
        i.category = ex.category;
        i.amount = ex.amount;
        i.date = ex.date;
      }
    }
  }
}
