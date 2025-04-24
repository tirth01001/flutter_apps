

class TakeNote {

  final int id;
  final String title;
  final String content; 
  final DateTime dateTime;
  final String date;

  TakeNote({
    this.id = 0,
    required this.title,
    required this.content,
    required this.dateTime,
    this.date='',
  });

  Map<String,dynamic> get toSqlFieldWithoutID => {
    'title': title,
    'content': content,
  };

  Map<String,dynamic> get toSqlField => {
    'title': title,
    'content': content,
    // 'create_at': DateTime.timestamp(),
  };


  factory TakeNote.fromSQl(Map<String,dynamic> map) => TakeNote(
    title: map["title"], 
    content: map["content"], 
    // dateTime: DateTime.parse(map["create_at"]),
    dateTime: DateTime(200),
    date: map["create_at"],
    id: map['id']
  );

}