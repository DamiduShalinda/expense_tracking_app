import 'package:flutter/material.dart';

class InputAmounts extends StatefulWidget {
  const InputAmounts({Key? key, required this.callback}) : super(key: key);

  final Function(double , double ) callback;

  @override
  State<InputAmounts> createState() => _InputAmountsState();
}

class _InputAmountsState extends State<InputAmounts> {

  final myController = TextEditingController();
  String? moneyType = "cash";
  double cashAmount  = 0 ;
  double bankAmount = 0;
  late final Function(String) callback;


  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void clearText() {
    myController.clear();
  }

  void addingAmount () {
    if ( moneyType == "cash"){
      cashAmount = double.parse(myController.text);
      widget.callback(cashAmount , 0 );

    } else if(moneyType == "bank") {
      bankAmount = double.parse(myController.text);
      widget.callback(0 , bankAmount);

    } else {
      Navigator.pop(context , 'cancel');
    }
  }

  void setControllerValue() {
    String enteredText = myController.text;
    String defaultValue = "0";

    myController.text = enteredText.isNotEmpty ? enteredText : defaultValue;
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
                     keyboardType: TextInputType.number,
                    autofocus: true,
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
                  setControllerValue();
                  addingAmount();
                  Navigator.pop(context, 'OK');
                  clearText();
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

}

