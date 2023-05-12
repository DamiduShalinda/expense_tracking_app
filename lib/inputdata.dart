import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class InputAmounts extends StatefulWidget {
  const InputAmounts({Key? key}) : super(key: key);

  @override
  State<InputAmounts> createState() => _InputAmountsState();
}

class _InputAmountsState extends State<InputAmounts> {

  final myController = TextEditingController();
  String? moneyType = "cash";
  double? cashAmount , bankAmount;

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: const Color(0xff00adb5),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(45.0),
      ),
      padding: const EdgeInsets.all(16),
      textColor: const Color(0xffeeeeee),
      height: 60,
      minWidth: 60,
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => LimitedBox(
          maxHeight: 100,
          maxWidth: 100,
          child: AlertDialog(
            title: const Text('Add amount'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          title: const Text("Cash"),
                          value: "Cash",
                          groupValue: moneyType,
                          onChanged: (value) {
                            setState(() {
                              moneyType = "cash";
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          title: const Text("Bank Account"),
                          value: "Bank",
                          groupValue: moneyType,
                          onChanged: (value) {
                            setState(() {
                              moneyType = "bank";
                            });
                          },
                        ),
                      ),
                    ],
                  ), // radio buttons
                   TextField(
                    controller: myController,
                    decoration: const InputDecoration(
                      hintText: "Enter Amount",
                      isDense: true,
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  addingAmount();
                  Navigator.pop(context, 'OK');
                },
                child: const Text('ADD'),
              ),
            ],
          ),
        ),
      ), //method
      child: const Text(
        "+",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
  }

  void addingAmount () {
    if ( moneyType == "cash"){
        cashAmount = double.parse(myController.text);
        if (kDebugMode) {
          print(cashAmount);
        }
    } else if(moneyType == "bank") {
        bankAmount = double.parse(myController.text);
        if (kDebugMode) {
          print(bankAmount);
        }
    } else {
      Navigator.pop(context , 'cancel');
    }
  }
}

