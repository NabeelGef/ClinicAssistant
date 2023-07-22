class SignUpPost {
  SignUpPost({
     this.patientId,
  });

  final String? patientId;

  factory SignUpPost.fromJson(Map<String, dynamic> json){
    return SignUpPost(
      patientId: json["patientId"],
    );
  }

  factory SignUpPost.fromJsonTow(Map<String, dynamic> json){
    return SignUpPost(
      patientId: json["message"],
    );
  }

  Map<String, dynamic> toJson() => {
    "patientId": patientId,
  };

  @override
  String toString(){
    return "$patientId";
  }

}

/*
{
	"patientId": "234e84a2-54d1-4b93-8dd5-88896fd5b793"
}*/