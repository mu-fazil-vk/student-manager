class StdntsJson {
  StdntsJson(
  this.idTemp, this.nameTemp, this.departmentTemp, this.admissionNoTemp, this.rollNoTemp, this.regNoTemp, this.dobTemp, this.bloodGroupTemp, this.yearOfAdmissionTemp, this.categoryTemp, this.addressTemp, this.studentPhoneTemp, this.parentNameTemp, this.parentPhoneTemp, this.remarkTemp, this.imageTemp,
  );
  final int idTemp;
  final String nameTemp;
  final String departmentTemp;
  final String admissionNoTemp;
  final String rollNoTemp;
  final String regNoTemp;
  final String dobTemp;
  final String bloodGroupTemp;
  final String yearOfAdmissionTemp;
  final String categoryTemp;
  final String addressTemp;
  final String studentPhoneTemp;
  final String parentNameTemp;
  final String parentPhoneTemp;
  final String remarkTemp;
  final String imageTemp;

  StdntsJson.fromJson(Map<String, dynamic> json)
      : idTemp = json['id'],
        nameTemp = json['name'],
        departmentTemp = json['department'],
        admissionNoTemp = json['admissionNo'],
        rollNoTemp = json['rollNo'],
        regNoTemp = json['regNo'],
        dobTemp = json['dob'],
        bloodGroupTemp = json['bloodGroup'],
        yearOfAdmissionTemp = json['yearOfAdmission'],
        categoryTemp = json['category'],
        addressTemp = json['address'],
        studentPhoneTemp = json['studentPhone'],
        parentNameTemp = json['parentName'],
        parentPhoneTemp = json['parentPhone'],
        remarkTemp = json['remark'],
        imageTemp = json['image'];


  Map<String, dynamic> toJson() {
    return {
      'id': idTemp,
      'name': nameTemp,
      'department': departmentTemp,
      'admissionNo': admissionNoTemp,
      'rollNo': rollNoTemp,
      'registerNo': regNoTemp,
      'dob': dobTemp,
      'bloodGroup': bloodGroupTemp,
      'yearOfAdmission': yearOfAdmissionTemp,
      'category': categoryTemp,
      'address': addressTemp,
      'studentPhone': studentPhoneTemp,
      'parentName': parentNameTemp,
      'parentPhone': parentPhoneTemp,
      'remark': remarkTemp,
      'image': imageTemp
    };
  }
}
