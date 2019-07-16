class DemoEntity {
	String fromId;
	String updatedAt;
	String createdAt;
	int id;

	DemoEntity({this.fromId, this.updatedAt, this.createdAt, this.id});

	DemoEntity.fromJson(Map<String, dynamic> json) {
		fromId = json['from_id'];
		updatedAt = json['updated_at'];
		createdAt = json['created_at'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['from_id'] = this.fromId;
		data['updated_at'] = this.updatedAt;
		data['created_at'] = this.createdAt;
		data['id'] = this.id;
		return data;
	}
}
