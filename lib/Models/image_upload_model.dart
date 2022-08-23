class ImageUploadResponse {
  String? fileUrl;
  String? fileName;
  String? status;
  String? message;

  ImageUploadResponse({this.fileUrl, this.fileName, this.status, this.message});

  ImageUploadResponse.fromJson(Map<String, dynamic> json) {
    fileUrl = json['file_url'];
    fileName = json['file_name'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['file_url'] = fileUrl;
    data['file_name'] = fileName;
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}
