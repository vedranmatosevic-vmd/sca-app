String returnDateTimeNow() {
  String dateNow = "${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}";
  String timeNow = "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}";
  String dateTimeNow = "$dateNow $timeNow";
  return dateTimeNow;
}