class NoteModel {
  int  ?id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  final bool isPinned;
  final bool isArchived;
  final bool isDeleted;

  final List<String> tags;
  final String colorHex;
  final DateTime? reminder;

  final List<String> attachments;
  final List<String> imagePaths;
  final String? voiceNotePath;

  final String? locationNote;
  final String mood;
  final String priority;

  final bool isChecklist;
  final bool passwordProtected;
  final String? passwordHint;

  final String? templateName;
  final bool favorite;

  final bool autoSaveEnabled;
  final String noteType;
  final String deviceName;

  final String noteLanguage;
  final bool markdownEnabled;
  final String noteLayoutStyle;

  final bool collapsed;
  final bool expanded;

  final DateTime lastViewed;

  final bool visibleInSearch;
  final String noteSlug;

  final String notePreview;
  final int wordCount;
  final int characterCount;
  final int readingTimeMin;

  final bool hasTimeStamp;
  final bool isAutoGenerated;

  NoteModel({
    this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    this.isPinned = false,
    this.isArchived = false,
    this.isDeleted = false,
    this.tags = const [],
    this.colorHex = "#FFFFFF",
    this.reminder,
    this.attachments = const [],
    this.imagePaths = const [],
    this.voiceNotePath,
    this.locationNote,
    this.mood = "",
    this.priority = "normal",
    this.isChecklist = false,
    this.passwordProtected = false,
    this.passwordHint,
    this.templateName,
    this.favorite = false,
    this.autoSaveEnabled = true,
    this.noteType = "text",
    this.deviceName = "unknown",
    this.noteLanguage = "en",
    this.markdownEnabled = false,
    this.noteLayoutStyle = "default",
    this.collapsed = false,
    this.expanded = true,
    DateTime? lastViewed,
    this.visibleInSearch = true,
    this.noteSlug = "",
    this.notePreview = "",
    this.wordCount = 0,
    this.characterCount = 0,
    this.readingTimeMin = 0,
    this.hasTimeStamp = false,
    this.isAutoGenerated = false,
  }) : lastViewed = lastViewed ?? DateTime.now();


  factory NoteModel.fromSqlFieldMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'],
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      isPinned: map['is_pinned'] == 1,
      isArchived: map['is_archived'] == 1,
      isDeleted: map['is_deleted'] == 1,
      colorHex: map['color_hex'] ?? '#FFFFFF',
      reminder: map['reminder'] != null ? DateTime.tryParse(map['reminder']) : null,
      mood: map['mood'] ?? '',
      priority: map['priority'] ?? 'normal',
      isChecklist: map['is_checklist'] == 1,
      passwordProtected: map['password_protected'] == 1,
      passwordHint: map['password_hint'],
      templateName: map['template_name'],
      favorite: map['favorite'] == 1,
      autoSaveEnabled: map['auto_save_enabled'] == 1,
      noteType: map['note_type'] ?? 'text',
      deviceName: map['device_name'] ?? 'unknown',
      noteLanguage: map['note_language'] ?? 'en',
      markdownEnabled: map['markdown_enabled'] == 1,
      noteLayoutStyle: map['note_layout_style'] ?? 'default',
      collapsed: map['collapsed'] == 1,
      expanded: map['expanded'] == 1,
      lastViewed: DateTime.parse(map['last_viewed']),
      visibleInSearch: map['visible_in_search'] == 1,
      noteSlug: map['note_slug'] ?? '',
      notePreview: map['note_preview'] ?? '',
      wordCount: map['word_count'] ?? 0,
      characterCount: map['character_count'] ?? 0,
      readingTimeMin: map['reading_time_min'] ?? 0,
      hasTimeStamp: map['has_time_stamp'] == 1,
      isAutoGenerated: map['is_auto_generated'] == 1,
      tags: [], // tags/attachments should be loaded separately
      attachments: [],
      imagePaths: [],
      voiceNotePath: null,
      locationNote: null,
    );
  }



  Map<String, dynamic> get toSqlFieldMap => {
    'id': id, // assuming id is stored as INTEGER
    'title': title,
    'content': content,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
    'is_pinned': isPinned ? 1 : 0,
    'is_archived': isArchived ? 1 : 0,
    'is_deleted': isDeleted ? 1 : 0,
    'color_hex': colorHex,
    'reminder': reminder?.toIso8601String(),
    'mood': mood,
    'priority': priority,
    'is_checklist': isChecklist ? 1 : 0,
    'password_protected': passwordProtected ? 1 : 0,
    'password_hint': passwordHint ?? '',
    'template_name': templateName,
    'favorite': favorite ? 1 : 0,
    'auto_save_enabled': autoSaveEnabled ? 1 : 0,
    'note_type': noteType,
    'device_name': deviceName,
    'note_language': noteLanguage,
    'markdown_enabled': markdownEnabled ? 1 : 0,
    'note_layout_style': noteLayoutStyle,
    'collapsed': collapsed ? 1 : 0,
    'expanded': expanded ? 1 : 0,
    'last_viewed': lastViewed.toIso8601String(),
    'visible_in_search': visibleInSearch ? 1 : 0,
    'note_slug': noteSlug,
    'note_preview': notePreview,
    'word_count': wordCount,
    'character_count': characterCount,
    'reading_time_min': readingTimeMin,
    'has_time_stamp': hasTimeStamp ? 1 : 0,
    'is_auto_generated': isAutoGenerated ? 1 : 0,
  };


}
