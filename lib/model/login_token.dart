class AccessToken {
  AccessToken({
     this.accessToken,
  });

  final AccessTokenClass? accessToken;

  factory AccessToken.fromJson(Map<String, dynamic> json){
    return AccessToken(
      accessToken: json["accessToken"] == null ? null : AccessTokenClass.fromJson(json["accessToken"]),
    );


  }

  factory AccessToken.fromJsonTow(String json){
    return AccessToken(
      accessToken: AccessTokenClass.fromJsonTow(json),
    );
  }

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken?.toJson(),
  };

  @override
  String toString(){
    return "$accessToken, ";
  }

}

class AccessTokenClass {
  AccessTokenClass({
     this.accessToken,
  });

  final String? accessToken;

  factory AccessTokenClass.fromJson(Map<String, dynamic> json){
    return AccessTokenClass(
      accessToken: json["accessToken"],
    );
  }

  factory AccessTokenClass.fromJsonTow(String json){
    return AccessTokenClass(
      accessToken: json,
    );
  }

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
  };

  @override
  String toString(){
    return "$accessToken, ";
  }

}

/*
{
	"accessToken": {
		"accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXRpZW50SWQiOiIxIiwidHlwZSI6NCwiaWF0IjoxNjg3MjQ2NDAxLCJleHAiOjE2ODczMzI4MDF9.U_93QDcOOhAAmJSOgeRvNh-TeGXJ_-yvtVT7MK0COFk"
	}
}*/