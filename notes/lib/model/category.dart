class Category {
  int id;
  int noteId;
  String type;

  Category({
    this.id = -1,
    this.noteId = -1,
    this.type = "",
  });

  // Convert Category object to SQLite-compatible Map
  Map<String, dynamic> toSqliteMap() {
    return {
      'note_id': noteId, // Foreign key linking to notes
      'tag': type,      // Category type like 'Work', 'Personal', etc.
    };
  }

  // Convert Map to Category object (from SQLite)
  factory Category.fromSqliteMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],        // Get id from SQLite result
      noteId: map['note_id'], // Get note_id from SQLite result
      type: map['tag'],    // Get type from SQLite result
    );
  }
}
