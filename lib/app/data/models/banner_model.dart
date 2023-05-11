class BannerModel {
  BannerModel({
      String? bannerId, 
      String? bannerPicture,}){
    _bannerId = bannerId;
    _bannerPicture = bannerPicture;
}

  BannerModel.fromJson(dynamic json) {
    _bannerId = json['banner_id'];
    _bannerPicture = json['banner_picture'];
  }
  String? _bannerId;
  String? _bannerPicture;
BannerModel copyWith({  String? bannerId,
  String? bannerPicture,
}) => BannerModel(  bannerId: bannerId ?? _bannerId,
  bannerPicture: bannerPicture ?? _bannerPicture,
);
  String? get bannerId => _bannerId;
  String? get bannerPicture => _bannerPicture;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['banner_id'] = _bannerId;
    map['banner_picture'] = _bannerPicture;
    return map;
  }

}