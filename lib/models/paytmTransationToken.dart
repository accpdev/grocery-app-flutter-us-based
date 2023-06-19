class PaytmTransactionToken {
  int? status;
  String? message;
  Data? data;

  PaytmTransactionToken({this.status, this.message, this.data});

  PaytmTransactionToken.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? txnToken;
  PaytmResponse? paytmResponse;

  Data({this.txnToken, this.paytmResponse});

  Data.fromJson(Map<String, dynamic> json) {
    txnToken = json['txn_token'];
    paytmResponse = json['paytm_response'] != null ? PaytmResponse.fromJson(json['paytm_response']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['txn_token'] = txnToken;
    if (paytmResponse != null) {
      data['paytm_response'] = paytmResponse!.toJson();
    }
    return data;
  }
}

class PaytmResponse {
  Head? head;
  Body? body;

  PaytmResponse({this.head, this.body});

  PaytmResponse.fromJson(Map<String, dynamic> json) {
    head = json['head'] != null ? Head.fromJson(json['head']) : null;
    body = json['body'] != null ? Body.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (head != null) {
      data['head'] = head!.toJson();
    }
    if (body != null) {
      data['body'] = body!.toJson();
    }
    return data;
  }
}

class Head {
  String? responseTimestamp;
  String? version;
  String? signature;

  Head({this.responseTimestamp, this.version, this.signature});

  Head.fromJson(Map<String, dynamic> json) {
    responseTimestamp = json['responseTimestamp'];
    version = json['version'];
    signature = json['signature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['responseTimestamp'] = responseTimestamp;
    data['version'] = version;
    data['signature'] = signature;
    return data;
  }
}

class Body {
  ResultInfo? resultInfo;
  String? txnToken;
  bool? isPromoCodeValid;
  bool? authenticated;

  Body({this.resultInfo, this.txnToken, this.isPromoCodeValid, this.authenticated});

  Body.fromJson(Map<String, dynamic> json) {
    resultInfo = json['resultInfo'] != null ? ResultInfo.fromJson(json['resultInfo']) : null;
    txnToken = json['txnToken'];
    isPromoCodeValid = json['isPromoCodeValid'];
    authenticated = json['authenticated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (resultInfo != null) {
      data['resultInfo'] = resultInfo!.toJson();
    }
    data['txnToken'] = txnToken;
    data['isPromoCodeValid'] = isPromoCodeValid;
    data['authenticated'] = authenticated;
    return data;
  }
}

class ResultInfo {
  String? resultStatus;
  String? resultCode;
  String? resultMsg;

  ResultInfo({this.resultStatus, this.resultCode, this.resultMsg});

  ResultInfo.fromJson(Map<String, dynamic> json) {
    resultStatus = json['resultStatus'];
    resultCode = json['resultCode'];
    resultMsg = json['resultMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['resultStatus'] = resultStatus;
    data['resultCode'] = resultCode;
    data['resultMsg'] = resultMsg;
    return data;
  }
}
