class Formatter {

  static String ratingFormatter(double rating){
    return "${rating / 10}";
  }

  static String timeFormatter(double time) {
    final int hour = time.floor();
    final int minit = ((time - hour) * 100).round();
    return "${hour}h $minit min";
  }
}