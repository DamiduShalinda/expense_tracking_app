
import 'package:expense_tracker/inputdata.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_field/date_field.dart';
import 'package:expense_tracker/cashflow.dart';


void main() {
  runApp(const Expensee());
}

class Expensee extends StatefulWidget {
  const Expensee({Key? key}) : super(key: key);

  @override
  State<Expensee> createState() => _ExpenseeState();
}

class _ExpenseeState extends State<Expensee> {

  double cashAmount = 0;
  double bankAmount = 0;
  late double? spendAmount;
  late String? reason;
  late DateTime date;

  final reasonController = TextEditingController();
  final amountController = TextEditingController();
  String cDate = DateFormat("yyyy-MM-dd").format(DateTime.now());

  List<CashFlow> cashFlow = [];
  late List<Widget> itemsListWidgets = [];

  void updateData(double cash, bank) {
    setState(() {
      cashAmount += cash;
      bankAmount += bank;
    });
  }

  void setControllerValue() {
    String enteredText = reasonController.text;
    String amountEntered = amountController.text;
    String reasonDefaultValue = "";
    String amountDefaultValue = "0";
    reasonController.text =
    enteredText.isNotEmpty ? enteredText : reasonDefaultValue;
    amountController.text =
    amountEntered.isNotEmpty ? amountEntered : amountDefaultValue;
  }


  void setListValues() {
        spendAmount = double.parse(amountController.text);
        reason = reasonController.text;
        date = DateTime.parse(cDate);
        cashFlow.add(CashFlow(reason!, date, spendAmount!));
  }

  void addToString() {

    for (CashFlow item in cashFlow) {
      itemsListWidgets.add(
        Row(
          children: [
            Text("Reason : ${item.reason} "),
            Text("Amount : ${item.amount.toString()} "),
          ],
        )
      );
    }

  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xff222831),
        appBar: AppBar(
          elevation: 4,
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xff00adb5),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          title: const Text(
            "Expense Tracker",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              fontSize: 20,
              color: Color(0xffeeeeee),
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Card(
              margin: const EdgeInsets.all(15),
              color: const Color(0xffe0e0e0),
              shadowColor: const Color(0xff000000),
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0),
                side: const BorderSide(color: Color(0x4d9e9e9e), width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(7),
                        child: Text(
                          "Cash:",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 20,
                            color: Color(0xff000000),
                          ),
                        ),
                      ), //cash label
                      Padding(
                        padding: EdgeInsets.all(7),
                        child: Text(
                          "Bank:",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 20,
                            color: Color(0xff000000),
                          ),
                        ),
                      ), //bank label
                    ],
                  ), //label
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(7),
                        child: Text(
                          "$cashAmount",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 20,
                            color: Color(0xff000000),
                          ),
                        ),
                      ), //cash amount
                      Padding(
                        padding: const EdgeInsets.all(7),
                        child: Text(
                          "$bankAmount",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 20,
                            color: Color(0xff000000),
                          ),
                        ),
                      ), //bank amount
                    ],
                  ),
                  const Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 16,
                      width: 16,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: InputAmounts(callback: updateData),
                  ), // + icon
                ],
              ),
            ), // amount displaying card
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: DateTimeFormField(
                          dateTextStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 20,
                            color: Color(0xff909090),
                          ),
                          decoration: const InputDecoration(
                            contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            disabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorStyle: TextStyle(color: Colors.redAccent),
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(
                              Icons.calendar_today_sharp,
                              color: Color(0xffeeeeee),),
                          ),
                          mode: DateTimeFieldPickerMode.date,
                          autovalidateMode: AutovalidateMode.always,
                          validator: (e) =>
                          (e?.day ?? 0) == 1
                              ? 'Please not the first day'
                              : null,
                        )
                    ), // dateText
                  ),

                ],
              ),
            ), //Date input field
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: TextField(
                        controller: reasonController,
                        obscureText: false,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 20,
                          color: Color(0xffffffff),
                        ),
                        decoration: const InputDecoration(
                          disabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: "Reason",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 20,
                            color: Color(0xff909090),
                          ),
                          filled: true,
                          fillColor: Color(0x00eeeeee),
                          isDense: true,
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        ),
                      ),
                    ),
                  ), // reason text field
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: amountController,
                        obscureText: false,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 20,
                          color: Color(0xffffffff),
                        ),
                        decoration: const InputDecoration(
                          disabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: "Amount",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.normal,
                            fontSize: 20,
                            color: Color(0xff909090),
                          ),
                          filled: true,
                          fillColor: Color(0x00f2f2f3),
                          isDense: true,
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        ),
                      ),
                    ),
                  ), // amount text field
                  IconButton(
                    icon: const Icon(Icons.done),
                    onPressed: () {
                      setControllerValue();
                      setListValues();
                      setState(() {
                        addToString();
                      });
                    },
                    color: const Color(0xffeeeeee),
                    iconSize: 30,
                    padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                  ), // ok icon button
                ],
              ),
            ), // reason and amount input field
           Column(children: itemsListWidgets,)
          ],
        ),

      ),
    );
  }

}
  
