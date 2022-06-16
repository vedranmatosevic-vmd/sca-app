import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sca_app/common/loaded_data.dart';
import 'package:sca_app/common/style.dart';
import 'package:sca_app/models/match.dart';
import 'package:sca_app/router/router.dart';
import 'package:sca_app/services/database_service.dart';
import 'package:sca_app/widget/styled_layout.dart';

Match newMatch = Match.emptyMatch();

class CreateNewMatch extends StatefulWidget {
  const CreateNewMatch({Key? key}) : super(key: key);

  @override
  State<CreateNewMatch> createState() => _CreateNewMatchState();
}

class _CreateNewMatchState extends State<CreateNewMatch> {
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
  Widget build(BuildContext context) {

    return StyledLayout(
      appBarTitle: "Create new match",
      backgroundColor: CustomColors.grey,
      actions: _actions(context, _dateController, _timeController),
      body: Column(
        children: <Widget>[
          _contentTitle(),
          Container(
            decoration: const BoxDecoration(
                color: Colors.white
            ),
            child: Column(
              children: <Widget>[
                _simpleDialogOption('Home', teamsByCompetitions, FormFieldType.home),
                _simpleDialogOption('Away', teamsByCompetitions, FormFieldType.away),
                DateTimeRow(selectDate: _selectDate,
                    selectTime: _selectTime,
                    dateController: _dateController,
                    timeController: _timeController),
                _simpleDialogOption(
                    'Duration', duration, FormFieldType.duration, inOneLine: true),
                _simpleDialogOption('Round', rounds, FormFieldType.round, inOneLine: true),
              ],
            ),
          ),
        ],
      ),
    );
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
        _hour = selectedTime.hour < 10 ? "0" + selectedTime.hour.toString() : selectedTime.hour.toString();
        _minute = selectedTime.minute < 10 ? "0" + selectedTime.minute.toString() : selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
      });
    }
  }
}

Container _simpleDialogOption(
    String label,
    List<String> items,
    FormFieldType type,
    {bool inOneLine = false}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Column(
      children: [
        inOneLine ? Row(
          children: <Widget>[
            Text(
              '$label ',
              style: const TextStyle(
                  color: CustomColors.black,
                  fontSize: 14
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
                      color: CustomColors.black,
                      fontSize: 14
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          Row(
            children: const <Widget>[
              Text(
                'Date',
                style: TextStyle(
                    color: CustomColors.black,
                    fontSize: 14
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
                      decoration: const InputDecoration(
                        disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: CustomColors.black)
                        ),
                      ),
                      style: const TextStyle(
                          fontSize: 16
                      ),
                      onSaved: (val) {

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
                      decoration: const InputDecoration(
                        disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: CustomColors.black)
                        ),
                      ),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 16
                      ),
                      onSaved: (val) {

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

List<String> rounds = ['1', '2', '3', '4', '5', '6', '7', '8'];

List<String> duration = ['0', '5', '10', '15', '20', '25', '30', '35', '40', '45', '50', '55', '60'];

enum FormFieldType {
  home,
  away,
  round,
  duration
}

class DropDownItem extends StatefulWidget {
  const DropDownItem({Key? key, required this.items, required this.type}) : super(key: key);

  final List<String> items;
  final FormFieldType type;

  @override
  State<DropDownItem> createState() => _DropDownItemState();
}

class _DropDownItemState extends State<DropDownItem> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();

    if (widget.type == FormFieldType.duration) {
      selectedValue = widget.items[6];
    } else {
      selectedValue = widget.items[0];
    }

    _setDropDownValue(selectedValue);

    rebuildAllChildren(context);
  }

  @override
  Widget build(BuildContext context) {

    return DropdownButton(
        underline: Container(height: 1, color: CustomColors.black,),
        value: selectedValue,
        items: widget.items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue!.toString();
            _setDropDownValue(selectedValue);
          });
        });
  }

  void _setDropDownValue(String value) {

    if (widget.type == FormFieldType.home) {
      newMatch.homeTeam = value;
    } else if (widget.type == FormFieldType.away) {
      newMatch.awayTeam = value;
    } else if (widget.type == FormFieldType.round) {
      newMatch.round = int.parse(value);
    } else if (widget.type == FormFieldType.duration) {
      newMatch.duration = int.parse(value);
    }
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }
    (context as Element).visitChildren(rebuild);
  }
}

Container _contentTitle() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Row(
      children: const [
        Text(
          'Informacije',
          style: TextStyle(
              color: CustomColors.black,
              fontSize: 16
          ),
        ),
      ],
    ),
  );
}

List<Widget> _actions(BuildContext context, TextEditingController dateController, TextEditingController timeController) {

  return <Widget>[
    const SizedBox(width: 10,),
    GestureDetector(
      onTap: () async {
        DatabaseService service = DatabaseService();
        newMatch.uuid = UniqueKey().hashCode;
        newMatch.date = dateController.text;
        newMatch.time = timeController.text;
        newMatch.competition = selectedLeague;

        await service.addMatch(newMatch);

        navigateTo(context, Pages.newMatch, match: newMatch);
      },
      child: const Icon(
          Icons.save
      ),
    ),
    const SizedBox(width: 10,)
  ];
}
