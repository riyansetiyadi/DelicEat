class CapitalizationHelper {
  String toTitleCase(String text) {
    return text.toLowerCase().split(' ').map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1);
      } else {
        return word;
      }
    }).join(' ');
  }

  String toSentenceCase(String text) {
    List<String> sentences = text.split(RegExp(r'(?<=[.!?])\s*'));

    for (int i = 0; i < sentences.length; i++) {
      if (sentences[i].isNotEmpty) {
        sentences[i] = sentences[i][0].toUpperCase() +
            sentences[i].substring(1).toLowerCase();
      }
    }

    return sentences.join(' ');
  }
}
