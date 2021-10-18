String castAge(String date) {
  DateTime dateTime = DateTime.parse(date);
  int age = DateTime.now().year - dateTime.year;
  return age.toString() + ' years old';
}