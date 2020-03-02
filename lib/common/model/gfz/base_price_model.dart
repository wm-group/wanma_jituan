class BasePriceModel {
  String wlmc;
  double jzj;
  String sxrq;
  String vkorg;

  BasePriceModel({this.wlmc, this.jzj, this.sxrq, this.vkorg});

  BasePriceModel.fromJson(Map<String, dynamic> json) {
    wlmc = json['wlmc'];
    jzj = json['jzj'];
    sxrq = json['sxrq'];
    vkorg = json['vkorg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wlmc'] = this.wlmc;
    data['jzj'] = this.jzj;
    data['sxrq'] = this.sxrq;
    data['vkorg'] = this.vkorg;
    return data;
  }
}
