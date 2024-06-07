import 'package:contact_book/features/company/domain/entities/company_entity.dart';

class CompanyModel extends CompanyEntity {
  const CompanyModel({
    required super.id,
    required super.companyName,
    required super.vatNumber,
    required super.streetOne,
    required super.streetTwo,
    required super.city,
    required super.state,
    required super.zip,
    required super.country,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'] as int,
      companyName: json['companyName'] as String,
      vatNumber: json['vatNumber'] as String,
      streetOne: json['streetOne'] as String,
      streetTwo: json['streetTwo'] as String?,
      city: json['city'] as String,
      state: json['state'] as String,
      zip: json['zip'] as String,
      country: json['country'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'companyName': companyName,
        'vatNumber': vatNumber,
        'streetOne': streetOne,
        'streetTwo': streetTwo,
        'city': city,
        'state': state,
        'zip': zip,
        'country': country,
      };

  factory CompanyModel.fromEntity(CompanyEntity companyEntity) {
    return CompanyModel(
      id: companyEntity.id,
      companyName: companyEntity.companyName,
      vatNumber: companyEntity.vatNumber,
      streetOne: companyEntity.streetOne,
      streetTwo: companyEntity.streetTwo,
      city: companyEntity.city,
      state: companyEntity.state,
      zip: companyEntity.zip,
      country: companyEntity.country,
    );
  }
  CompanyEntity toEntity() {
    return CompanyEntity(
      id: id,
      companyName: companyName,
      vatNumber: vatNumber,
      streetOne: streetOne,
      streetTwo: streetTwo,
      city: city,
      state: state,
      zip: zip,
      country: country,
    );
  }
}
