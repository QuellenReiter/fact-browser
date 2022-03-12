class Queries {
  //
  static String searchStatements(String query) {
    String ret = '''
  query searchStatements{
  statements(where:{
    text:{matchesRegex:"$query", options: "i"}
  }){
    edges{
      node{
        text,
        author,
        date,
        true,
        medium,
        language,
        label,
        statementType,
        relevance,
        funny,
        corrected
      }
    }
  }
}
  ''';
    return ret;
  }
}
