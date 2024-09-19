import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


enum FieldType { text, dropdown, radio, switchField }

class FieldData {
  final String key;
  final String label;
  final FieldType type;
  final String? initialValue;
  final List<dynamic>? dropdownItems;
  final List<String>? radioOptions;
  final bool? initialSwitchValue;
  final TextInputType? inputType;
  final bool isCurrency;
  final String? validatorText;

  FieldData({
    required this.key,
    required this.label,
    this.type = FieldType.text,
    this.initialValue,
    this.dropdownItems,
    this.radioOptions,
    this.initialSwitchValue = true,
    this.inputType,
    this.isCurrency = false,
    this.validatorText,
  });
}

class EditDialog extends StatefulWidget {
  final String title;
  final List<FieldData> fields;
  final Function(Map<String, dynamic> data)? onSave;
  final bool isDeleteButtonAvailable;
  final VoidCallback? onDelete;

  const EditDialog({
    super.key,
    required this.title,
    required this.fields,
    this.onSave,
    this.isDeleteButtonAvailable = false,
    this.onDelete,
  });

  @override
  _EditDialogState createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  late List<TextEditingController> _controllers;
  late List<String?> _dropdownValues;
  late List<String?> _radioValues;
  late List<bool> _switchValues;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controllers = widget.fields
        .where((field) => field.type == FieldType.text)
        .map((field) => TextEditingController(text: field.initialValue))
        .toList();
    _dropdownValues = widget.fields
        .where((field) => field.type == FieldType.dropdown)
        .map((field) => field.initialValue)
        .toList();
    _radioValues = widget.fields
        .where((field) => field.type == FieldType.radio)
        .map((field) => field.initialValue)
        .toList();
    _switchValues = widget.fields
        .where((field) => field.type == FieldType.switchField)
        .map((field) => field.initialSwitchValue ?? false)
        .toList();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final data = <String, dynamic>{};
      int textIndex = 0,
          dropdownIndex = 0,
          radioIndex = 0,
          switchIndex = 0;
      for (var field in widget.fields) {
        if (field.type == FieldType.text) {
          if (field.isCurrency) {
            double? value =
            double.tryParse(_controllers[textIndex++].text);
            if (value != null) {
              data[field.key] = value;
            } else {
              data[field.key] = null;
            }
          } else {
            data[field.key] = _controllers[textIndex++].text;
          }
        } else if (field.type == FieldType.dropdown) {
          data[field.key] = _dropdownValues[dropdownIndex++];
        } else if (field.type == FieldType.radio) {
          data[field.key] = _radioValues[radioIndex++];
        } else if (field.type == FieldType.switchField) {
          data[field.key] = _switchValues[switchIndex++];
        }
      }
      widget.onSave?.call(data);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    int textFieldIndex = 0;
    int dropdownIndex = 0;
    int radioIndex = 0;
    int switchIndex = 0;

    return AlertDialog(
      title: Text(
        widget.title,
        style: TextStyle(fontSize: 14.sp),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: widget.fields.map((field) {
              if (field.type == FieldType.text) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      field.label,
                      style: TextStyle(fontSize: 12.sp),
                    ),
                    SizedBox(height: 1.h),
                    TextFormField(
                      controller: _controllers[textFieldIndex++],
                      keyboardType: field.inputType ?? TextInputType.text,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(8),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return field.validatorText ?? 'Please enter ${field.label.toLowerCase()}';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 1.h),
                  ],
                );
              } else if (field.type == FieldType.dropdown) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      field.label,
                      style: TextStyle(fontSize: 12.sp),
                    ),
                    SizedBox(height: 1.h),
                    DropdownButtonFormField<String>(
                      value: _dropdownValues[dropdownIndex],
                      hint: Text(
                        field.label,
                        style: TextStyle(fontSize: 10.sp),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _dropdownValues[dropdownIndex] = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return field.validatorText ?? 'Please select ${field.label.toLowerCase()}';
                        }
                        return null;
                      },
                      items: field.dropdownItems!
                          .map<DropdownMenuItem<String>>((item) {
                        return DropdownMenuItem<String>(
                          value: item.toString(),
                          child: Text(
                            item.toString(),
                            style: TextStyle(fontSize: 12.sp),
                          ),
                        );
                      }).toList(),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(8),
                      ),
                    ),
                    SizedBox(height: 1.h),
                  ],
                );
              } else if (field.type == FieldType.radio) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      field.label,
                      style: TextStyle(fontSize: 12.sp),
                    ),
                    SizedBox(height: 1.h),
                    Column(
                      children: field.radioOptions!.map((option) {
                        return RadioListTile<String>(
                          title: Text(
                            option,
                            style: TextStyle(fontSize: 10.sp),
                          ),
                          value: option,
                          groupValue: _radioValues[radioIndex],
                          onChanged: (value) {
                            setState(() {
                              _radioValues[radioIndex] = value;
                            });
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 1.h),
                    if (_radioValues[radioIndex] == null)
                      Text(
                        field.validatorText ?? 'Please select ${field.label.toLowerCase()}',
                        style: TextStyle(fontSize: 10.sp, color: Colors.red),
                      ),
                    SizedBox(height: 1.h),
                  ],
                );
              } else if (field.type == FieldType.switchField) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      field.label,
                      style: TextStyle(fontSize: 12.sp),
                    ),
                    SizedBox(height: 1.h),
                    SwitchListTile(
                      title: Text(
                        field.label,
                        style: TextStyle(fontSize: 10.sp),
                      ),
                      value: _switchValues[switchIndex],
                      onChanged: (value) {
                        setState(() {
                          _switchValues[switchIndex] = value;
                        });
                      },
                    ),
                    SizedBox(height: 1.h),
                  ],
                );
              }
              return Container();
            }).toList(),
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                // LocaleData.cancel.getString(context),
                "Cancel",
                style: TextStyle(fontSize: 12.sp),
              ),
            ),
            if (widget.isDeleteButtonAvailable)
              TextButton(
                onPressed: widget.onDelete,
                child: Text(
                  // LocaleData.delete.getString(context),
                  "Delete",
                  style: TextStyle(fontSize: 12.sp, color: Colors.red),
                ),
              ),
            ElevatedButton(
              onPressed: _saveForm,
              child: Text(
                // LocaleData.save.getString(context),
                "Save",
                style: TextStyle(fontSize: 12.sp),
              ),
            ),
          ],
        )
      ],
    );
  }
}
