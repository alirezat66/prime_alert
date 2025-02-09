extension DurationExtension on Duration {
  String get formatted {
    
    final days = inDays;
    final hours = inHours.remainder(24).toString().padLeft(2, '0');
    final minutes = inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = inSeconds.remainder(60).toString().padLeft(2, '0');

    if (days > 0) {
      return "$days days $hours:$minutes:$seconds";
    } else {
      return "$hours:$minutes:$seconds";
    }
  }
}
