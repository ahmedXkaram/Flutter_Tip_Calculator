import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BillSplitter extends StatefulWidget {
  const BillSplitter({Key? key}) : super(key: key);

  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  int tipPercentage = 0;
  int personCounter = 1;
  double billAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.purpleAccent.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Total Per Person',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19.0,
                      color: Colors.purple.shade700,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      '\$ ${calculateTotalPerPerson(billAmount, personCounter, tipPercentage)}',
                      style: TextStyle(
                        fontSize: 34.9,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border:
                      Border.all(width: 1.3, color: Colors.blueGrey.shade100),
                  borderRadius: BorderRadius.circular(15.0)),
              child: Column(
                children: <Widget>[
                  TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: Colors.grey),
                    decoration: InputDecoration(
                      prefixText: "Bill Amount",
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                    onChanged: (String value) {
                      try {
                        setState(() {
                          billAmount = double.parse(value);
                        });
                      } catch (e) {
                        print(e);
                        setState(() {
                          billAmount = 0.0;
                        });
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Split',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (personCounter > 1) {
                                  personCounter--;
                                }
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: Colors.purple.withOpacity(0.1),
                              ),
                              child: Center(
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                      color: Colors.purple,
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            '$personCounter',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                              color: Colors.purple,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                personCounter++;
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: Colors.purple.withOpacity(0.1),
                              ),
                              child: Center(
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                      color: Colors.purple,
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Tip',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 40.0),
                        child: Text(
                          "\$ ${calculateTotalTip(billAmount, personCounter, tipPercentage)}",
                          style: TextStyle(
                            color: Colors.purple.shade600,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "$tipPercentage %",
                        style: TextStyle(
                          color: Colors.purple.shade600,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Slider(
                        min: 0,
                        max: 100,
                        activeColor: Colors.purple.shade400,
                        inactiveColor: Colors.grey.shade300,
                        divisions: 10,
                        value: tipPercentage.toDouble(),
                        onChanged: (double value) {
                          setState(() {
                            tipPercentage = value.round();
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  calculateTotalPerPerson(double billAmount, int splitBy, int tipPercentage) =>
      ((calculateTotalTip(billAmount, splitBy, tipPercentage) + billAmount) /
              splitBy)
          .toStringAsFixed(2);

  calculateTotalTip(double billAmount, int splitBy, int tipPercentage) {
    double totalTip = 0.0;
    if (billAmount < 0 || billAmount.toString().isEmpty) {
    } else {
      setState(() {
        totalTip = (billAmount * tipPercentage) / 100;
      });
    }
    return totalTip;
  }
}
