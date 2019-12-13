import 'package:intl/intl.dart';

class ConvertDate {

  // Convert pubDate into "Publié il y a X minutes/heures/jours"
  String publishedDateToString(string) {
    // DateFormat for Le Monde
    DateFormat dateFormat = DateFormat("EEE, dd MMM yyyy HH:mm:ss Z");
    DateTime dateTime = dateFormat.parse(string);

    int result = DateTime.now().difference(dateTime).inMinutes;

    if (result >= 2880) {
      return "Publié il y a ${(result / 1440).floor()} jours";
    } else if (result >= 1440) {
      return "Publié il y a ${(result / 1440).floor()} jour";
    } else if (result >= 120) {
      return "Publié il y a ${(result / 60).floor()} heures";
    } else if (result >= 60) {
      return "Publié il y a ${(result / 60).floor()} heure";
    } else {
      return "Publié il y a $result minutes";
    }
  }

}

