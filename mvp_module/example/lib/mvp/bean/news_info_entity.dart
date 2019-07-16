class NewsInfoEntity {
	String summary;
	String authorName;
	String fromId;
	String columnName;
	String storeAt;
	String createdAt;
	String title;
	String authorAvatar;
	String type;
	String content;
	String columnId;
	String cover;
	String postId;
	String updatedAt;
	int commentsCount;
	String authorEmail;
	int id;
	int viewsCount;
	String publishedAt;

	NewsInfoEntity({this.summary, this.authorName, this.fromId, this.columnName, this.storeAt, this.createdAt, this.title, this.authorAvatar, this.type, this.content, this.columnId, this.cover, this.postId, this.updatedAt, this.commentsCount, this.authorEmail, this.id, this.viewsCount, this.publishedAt});

	NewsInfoEntity.fromJson(Map<String, dynamic> json) {
		summary = json['summary'];
		authorName = json['author_name'];
		fromId = json['from_id'];
		columnName = json['column_name'];
		storeAt = json['store_at'];
		createdAt = json['created_at'];
		title = json['title'];
		authorAvatar = json['author_avatar'];
		type = json['type'];
		content = json['content'];
		columnId = json['column_id'];
		cover = json['cover'];
		postId = json['post_id'];
		updatedAt = json['updated_at'];
		commentsCount = json['comments_count'];
		authorEmail = json['author_email'];
		id = json['id'];
		viewsCount = json['views_count'];
		publishedAt = json['published_at'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['summary'] = this.summary;
		data['author_name'] = this.authorName;
		data['from_id'] = this.fromId;
		data['column_name'] = this.columnName;
		data['store_at'] = this.storeAt;
		data['created_at'] = this.createdAt;
		data['title'] = this.title;
		data['author_avatar'] = this.authorAvatar;
		data['type'] = this.type;
		data['content'] = this.content;
		data['column_id'] = this.columnId;
		data['cover'] = this.cover;
		data['post_id'] = this.postId;
		data['updated_at'] = this.updatedAt;
		data['comments_count'] = this.commentsCount;
		data['author_email'] = this.authorEmail;
		data['id'] = this.id;
		data['views_count'] = this.viewsCount;
		data['published_at'] = this.publishedAt;
		return data;
	}
}
