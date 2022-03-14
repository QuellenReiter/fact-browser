import '../provider/queries.dart';

class Fact{
  final String factText;
  final String factDate;
  final String factLanguage;
  final String factLink;
  final String factAuthor;
  final String factMedia;
  Fact(
    this.factText,
    this.factAuthor,
    this.factDate,
    this.factLanguage,
    this.factLink,
    this.factMedia);
    
    Fact.fromMap(Map<String, dynamic>? map) : 
      factText = map?[Queries.factText],
      factAuthor = map?[Queries.factAuthor],
      factMedia = map?[Queries.factMedia],
      factDate = map?[Queries.factDate],
      factLink = map?[Queries.factLink],
      factLanguage = map?[Queries.factLanguage];
}

class Facts{
  List<Fact> facts = [];
  Facts.fromMap(Map<String, dynamic>? map) {
    for(Map<String, dynamic>? fact in map?["edges"]){
      facts.add(Fact.fromMap(fact?["node"]));
    }
  }
      
  
}