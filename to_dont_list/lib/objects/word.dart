enum WordType{
  verb,
  noun,
  adjective,
  other

}

class Word {
  Word({required this.name, required this.translation});
  final String name;
  String translation;
  //String translation;
}