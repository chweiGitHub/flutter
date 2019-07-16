class TestEntity {
	String msg;
	bool success;
	int state;

	TestEntity({this.msg, this.success, this.state});

	TestEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		success = json['success'];
		state = json['state'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['msg'] = this.msg;
		data['success'] = this.success;
		data['state'] = this.state;
		return data;
	}
}
