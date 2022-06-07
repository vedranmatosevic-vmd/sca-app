import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sca_app/common/style.dart';
import 'package:sca_app/match/new_match.dart';
import 'package:sca_app/models/match.dart';

late String _setTime, _setDate;

late Match newMatch = Match.emptyMatch();

class DialogNewMatch extends StatefulWidget {
  const DialogNewMatch({Key? key}) : super(key: key);

  @override
  State<DialogNewMatch> createState() => _DialogNewMatchState();
}

class _DialogNewMatchState extends State<DialogNewMatch> {
  TimeOfDay selectedTime = const TimeOfDay(hour: 11, minute: 00);
  DateTime selectedDate = DateTime.now();

  late String _hour, _minute, _time;

  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void didChangeDependencies() {
    _timeController.text = selectedTime.format(context);
    _dateController.text = DateFormat('dd.MM.yyyy').format(selectedDate);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat('dd.MM.yyyy').format(selectedDate);
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('New match'),
      children: <Widget>[
        _simpleDialogOption('Home', teams, Type.home),
        _simpleDialogOption('Away', teams, Type.away),
        DateTimeRow(selectDate: _selectDate, selectTime: _selectTime, dateController: _dateController, timeController: _timeController),
        _simpleDialogOption('Duration', duration, Type.duration, inOneLine: true),
        _simpleDialogOption('Round', rounds, Type.round, inOneLine: true),
        _btnCreate(context, 'Create')
      ],
    );
  }
}

SimpleDialogOption _simpleDialogOption(
    String label,
    List<String> items,
    Type type,
    {bool inOneLine = false}) {
  return SimpleDialogOption(
    child: Column(
      children: [
        inOneLine ? Row(
          children: <Widget>[
            Text(
              '$label ',
              style: const TextStyle(
                  color: CustomColors.textGreyLight,
                  fontSize: 12
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            DropDownItem(
              items: items,
              type: type,
            )
          ],
        )
            : Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  '$label ',
                  style: const TextStyle(
                      color: CustomColors.textGreyLight,
                      fontSize: 12
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                DropDownItem(
                  items: items,
                  type: type,
                )
              ],
            ),
          ],
        )
      ],
    ),
  );
}

GestureDetector _btnCreate(BuildContext context, String label) {
  return GestureDetector(
    onTap: () {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewMatch(match: newMatch))
      );
      newMatch = Match.emptyMatch();
    },
    child: SimpleDialogOption(
      child: Text(
        label,
        textAlign: TextAlign.end,
        style: const TextStyle(
          color: CustomColors.primaryBlue,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

typedef SelectDateFunction = void Function();
typedef SelectTimeFunction = void Function();

class DateTimeRow extends StatelessWidget {
  final SelectDateFunction selectDate;
  final SelectTimeFunction selectTime;
  final TextEditingController dateController;
  final TextEditingController timeController;

  const DateTimeRow({
    Key? key,
    required this.selectDate,
    required this.selectTime,
    required this.dateController,
    required this.timeController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      child: Column(
        children: [
          Row(
            children: const <Widget>[
              Text(
                'Date',
                style: TextStyle(
                    color: CustomColors.textGreyLight,
                    fontSize: 12
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: () {
                      selectDate();
                    },
                    child: TextFormField(
                      style: const TextStyle(
                          fontSize: 16
                      ),
                      onSaved: (val) {
                        _setDate = val!;
                      },
                      enabled: false,
                      keyboardType: TextInputType.none,
                      controller: dateController,
                    ),
                  )
              ),
              Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      selectTime();
                    },
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 16
                      ),
                      onSaved: (val) {
                        _setTime = val!;
                      },
                      enabled: false,
                      keyboardType: TextInputType.none,
                      controller: timeController,
                    ),
                  )
              )
            ],
          ),
        ],
      ),
    );
  }
}

List<String> teams = [
  'FŠ Zagi',
  'MNK Gimka',
  'Gimka Malešnica',
  'Gimka Keglić',
  'Futsal Dinamo'
];

List<String> rounds = ['1', '2', '3', '4', '5', '6', '7', '8'];

List<String> duration = ['0', '5', '10', '15', '20', '25', '30', '35', '40', '45', '50', '55', '60'];

enum Type {
  home,
  away,
  round,
  duration
}

class DropDownItem extends StatefulWidget {
  const DropDownItem({Key? key, required this.items, required this.type}) : super(key: key);

  final List<String> items;
  final Type type;

  @override
  State<DropDownItem> createState() => _DropDownItemState();
}

class _DropDownItemState extends State<DropDownItem> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();

    selectedValue = widget.items[0];
    _setDropDownValue(widget.items[0]);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        underline: Container(height: 1, color: CustomColors.textGreyLight,),
        value: selectedValue,
        items: widget.items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue!;
            _setDropDownValue(selectedValue);
          });
        });
  }

  void _setDropDownValue(String value) {
    if (widget.type == Type.home) {
      newMatch.homeTeam = value;
    } else if (widget.type == Type.away) {
      newMatch.awayTeam = value;
    } else if (widget.type == Type.round) {
      newMatch.round = int.parse(value);
    } else if (widget.type == Type.duration) {
      newMatch.duration = int.parse(value);
    }
  }
}