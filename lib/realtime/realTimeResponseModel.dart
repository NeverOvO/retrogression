class realTimeResponseModel {
  final String? code;
  final String? message;
  final List<realTimeResponseData>? data;
  final int? page;

  realTimeResponseModel({this.code, this.message, this.data, this.page});

  factory realTimeResponseModel.fromJson(Map<dynamic, dynamic> json) {
    return realTimeResponseModel(
      code : json['Code'].toString(),
      message : json['Message'].toString(),
      data: (json['Data'] as List).map((i) => realTimeResponseData.fromJson(i)).toList(),
      page:json['Page'] ?? 0,
    );
  }
}

class realTimeResponseData{
  final String? createTime;
  final String? desc;
  final String? title;
  final String? url;
  final String? icon;
  final String? id;
  final String? img;
  final String? imgUrl;
  final String? sort;
  final String? tid;
  final String? type;

  realTimeResponseData({this.createTime, this.desc, this.title, this.url, this.icon, this.id, this.img, this.imgUrl, this.sort, this.tid, this.type});

  factory realTimeResponseData.fromJson(Map<String, dynamic> json) {
    return realTimeResponseData(
      createTime : json['CreateTime'].toString(),
      desc : json['Desc'].toString(),
      title : json['Title'].toString(),
      url : json['Url'].toString(),
      icon : json['icon'].toString(),
      id : json['id'].toString(),
      img : json['img'].toString(),
      imgUrl : json['imgUrl'].toString(),
      sort : json['sort'].toString(),
      tid : json['tid'].toString(),
      type : json['type'].toString(),
    );
  }
}