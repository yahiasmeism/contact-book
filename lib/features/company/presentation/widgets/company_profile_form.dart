import 'package:contact_book/core/widgets/country_drop_down_menu.dart';
import 'package:contact_book/core/widgets/custom_button.dart';
import 'package:contact_book/core/widgets/custom_outline_button.dart';
import 'package:contact_book/core/widgets/custom_text_form_field.dart';
import 'package:contact_book/features/company/domain/entities/company_entity.dart';
import 'package:contact_book/features/company/presentation/bloc/company_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyProfileForm extends StatefulWidget {
  const CompanyProfileForm({
    super.key,
  });

  @override
  State<CompanyProfileForm> createState() => _CompanyProfileFormState();
}

CompanyEntity? companyEntity;

class _CompanyProfileFormState extends State<CompanyProfileForm> {
  final formKey = GlobalKey<FormState>();
  final companyNameCon = TextEditingController();
  final streetCon = TextEditingController();
  final street2Con = TextEditingController();
  final vatNumberCon = TextEditingController();
  final zipCon = TextEditingController();
  final cityCon = TextEditingController();
  final stateCon = TextEditingController();
  final countryCon = TextEditingController();
  late bool editingActive;
  @override
  void initState() {
    editingActive = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    companyEntity = context.read<CompanyBloc>().company;
    if (companyEntity != null) {
      fillData(companyEntity!);
    }
    return Form(
      key: formKey,
      child: Column(
        children: [
          const SizedBox(height: 32),
          CustomTextFromField(
            labelText: 'Company Name',
            controller: companyNameCon,
            enabled: editingActive,
            isRequired: true,
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: CustomTextFromField(
                  isRequired: true,
                  labelText: 'Street',
                  controller: streetCon,
                  enabled: editingActive,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomTextFromField(
                  labelText: 'Street2',
                  controller: street2Con,
                  enabled: editingActive,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: CustomTextFromField(
                  isRequired: true,
                  keyboardType: TextInputType.number,
                  labelText: 'Vat Number',
                  controller: vatNumberCon,
                  enabled: editingActive,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomTextFromField(
                  isRequired: true,
                  keyboardType: TextInputType.number,
                  labelText: 'Zip',
                  controller: zipCon,
                  enabled: editingActive,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: CustomTextFromField(
                  labelText: 'City',
                  controller: cityCon,
                  enabled: editingActive,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomTextFromField(
                  isRequired: true,
                  labelText: 'State',
                  controller: stateCon,
                  enabled: editingActive,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          CountryDropDownMenu(
            countryController: countryCon,
            enabled: editingActive,
          ),
          const SizedBox(height: 32),
          editingActive
              ? _buildSaveAndUpdateButton(context)
              : _buildEditButton(context),
          const SizedBox(height: 24),
          CustomOutlineButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Back'),
          ),
        ],
      ),
    );
  }

  CustomButton _buildSaveAndUpdateButton(BuildContext context) {
    return CustomButton(
      child: const Text('Save'),
      onPressed: () {
        if (formKey.currentState!.validate()) {
          setState(() {
            editingActive = false;
          });
          CompanyEntity companyEntityUpdate = CompanyEntity(
            id: companyEntity?.id ?? 0,
            companyName: companyNameCon.text,
            vatNumber: vatNumberCon.text,
            streetOne: streetCon.text,
            streetTwo: street2Con.text,
            city: cityCon.text,
            state: stateCon.text,
            zip: zipCon.text,
            country: countryCon.text,
          );
          if (companyEntity != companyEntityUpdate) {
            context.read<CompanyBloc>().add(
                UpdateCompanyInfoEvent(companyEntity: companyEntityUpdate));
          }
        }
      },
    );
  }

  CustomOutlineButton _buildEditButton(BuildContext context) {
    return CustomOutlineButton(
      onPressed: () {
        setState(() {
          editingActive = true;
        });
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.edit_off_outlined),
          SizedBox(width: 8),
          Text('Edit'),
        ],
      ),
    );
  }

  fillData(CompanyEntity companyEntity) {
    companyNameCon.text = companyEntity.companyName;
    streetCon.text = companyEntity.streetOne;
    street2Con.text = companyEntity.streetTwo ?? '';
    vatNumberCon.text = companyEntity.vatNumber;
    zipCon.text = companyEntity.zip;
    cityCon.text = companyEntity.city;
    stateCon.text = companyEntity.state;
    countryCon.text = companyEntity.country;
  }
}
