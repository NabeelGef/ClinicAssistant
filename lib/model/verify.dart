class Verify {
  Verify({
     this.message,
  });

  final String? message;

  factory Verify.fromJson(Map<String, dynamic> json){
    return Verify(
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
  };

  @override
  String toString(){
    return "$message, ";
  }

}

/*
{
	"message": "account created successfully"
}*/