import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grid_app/controllers/patient_controller.dart';
import 'package:grid_app/extensions/shared_extensions.dart';
import 'package:grid_app/helpers/pateint_helper.dart';
import 'package:provider/provider.dart';

class EntryView extends StatefulWidget {
  const EntryView({super.key});

  @override
  State<EntryView> createState() => _EntryViewState();
}

class _EntryViewState extends State<EntryView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Patient Data Controllers
  final _patientIdController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _diagnosisController = TextEditingController();
  final _doNotAdministerController = TextEditingController();
  final _bloodTypeController = TextEditingController();
  final _dateOfEntryController = TextEditingController();

  // Graph Data Controllers
  final _graphDateGraphController = TextEditingController();
  final _graphTimeGraphController = TextEditingController();
  final _temperatureController = TextEditingController();
  final _bloodPressureController = TextEditingController();
  final _bloodOxygenController = TextEditingController();

  // Heart Data Controllers
  final _dateTimeHeartController = TextEditingController();
  final _heartDateheartController = TextEditingController();
  final _heartTimeheartController = TextEditingController();
  final _cvpController = TextEditingController();
  final _papController = TextEditingController();
  final _pwpController = TextEditingController();
  final _coController = TextEditingController();
  final _icpController = TextEditingController();

// Respiratory Data Controllers
  final _dateTimeRespiratoryController = TextEditingController();
  final _respiratoryDaterespiratoryController = TextEditingController();
  final _respiratoryTimerespiratoryController = TextEditingController();
  final _respiratoryTypeController = TextEditingController();
  final _vtController = TextEditingController();
  final _rrController = TextEditingController();
  final _peepController = TextEditingController();
  final _fio2Controller = TextEditingController();
  final _maskO2Controller = TextEditingController();

  // Blood Gasses Controllers
  final _dateTimeBloodGassesController = TextEditingController();
  final _bloodgasesDatebloodgasesController = TextEditingController();
  final _bloodgasesTimebloodgasesController = TextEditingController();
  final _phController = TextEditingController();
  final _paO2Controller = TextEditingController();
  final _paCO2Controller = TextEditingController();
  final _hco3Controller = TextEditingController();
  final _satO2Controller = TextEditingController();
  final _beController = TextEditingController();

  // Expelled Fluids Controllers
  final _dateTimeExpelledFluidsController = TextEditingController();
  final _expelledfluidDateexpelledfluidController = TextEditingController();
  final _expelledfluidTimeexpelledfluidController = TextEditingController();
  final _urineController = TextEditingController();
  final _levinController = TextEditingController();
  final _paroxeteushAController = TextEditingController();
  final _paroxeteushBController = TextEditingController();
  final _lostFluidSumController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _patientIdController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _diagnosisController.dispose();
    _doNotAdministerController.dispose();
    _bloodTypeController.dispose();
    _dateOfEntryController.dispose();
    _temperatureController.dispose();
    _bloodPressureController.dispose();
    _bloodOxygenController.dispose();
    _cvpController.dispose();
    _papController.dispose();
    _pwpController.dispose();
    _coController.dispose();
    _icpController.dispose();
    _graphDateGraphController.dispose();
    _graphTimeGraphController.dispose();
    _dateTimeHeartController.dispose();
    _vtController.dispose();
    _rrController.dispose();
    _peepController.dispose();
    _fio2Controller.dispose();
    _maskO2Controller.dispose();
    _dateTimeBloodGassesController.dispose();
    _phController.dispose();
    _paO2Controller.dispose();
    _paCO2Controller.dispose();
    _hco3Controller.dispose();
    _satO2Controller.dispose();
    _beController.dispose();
    _dateTimeExpelledFluidsController.dispose();
    _urineController.dispose();
    _levinController.dispose();
    _paroxeteushAController.dispose();
    _paroxeteushBController.dispose();
    _lostFluidSumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 5.h,
        bottom: TabBar(
          controller: _tabController,
          onTap: (value) {
            setState(() {});
          },
          indicatorPadding: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          labelPadding: EdgeInsets.zero,
          labelStyle: TextStyle(fontSize: 12),
          tabs: [
            Tab(text: 'Patient\nInfo'),
            Tab(text: 'Graph\nInfo'),
            Tab(text: 'Heart\nInfo'),
            Tab(text: 'Respiratory\nInfo'),
            Tab(text: 'Blood\nGasses'),
            Tab(text: 'Expelled\nFluids'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildPatientInfoForm(),
          buildGraphDataForm(),
          buildHeartDataForm(),
          buildRespiratoryDataForm(),
          buildBloodGassesForm(),
          buildExpelledFluidsForm(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: () {
          if (_tabController.index == 0 && !validatePatientInfoForm()) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Please complete all patient info',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.blueAccent,
              ),
            );
          }
          if (_tabController.index == 1 && !validateGraphDataForm()) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Please complete all graph info',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.blueAccent,
              ),
            );
          }
          if (_tabController.index == 2 && !validateHeartDataForm()) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Please complete all heart info',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.blueAccent,
              ),
            );
          }
          if (_tabController.index == 3 && !validateRespiratoryDataForm()) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Please complete all respiratory data',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.blueAccent,
              ),
            );
          }
          if (_tabController.index == 4 && !validateBloodGassesForm()) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Please complete all blood gasses info',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.blueAccent,
              ),
            );
          }
          if (_tabController.index == 5 && !validateExpelledFluidsForm()) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Please complete all expelled fluids info',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.blueAccent,
              ),
            );
          }
          if (_tabController.index == 0 && validatePatientInfoForm()) {
            context.read<PatientController>().postPatientInfo(
                  patientId: _patientIdController.text,
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  age: _ageController.text,
                  height: _heightController.text,
                  weight: _weightController.text,
                  diagnosis: _diagnosisController.text,
                  doNotAdminister: _doNotAdministerController.text,
                  bloodType: _bloodTypeController.text,
                  dateOfEntry: _dateOfEntryController.text,
                  callBack: () {
                    clearPatientInfoForm();
                  },
                );
          }
          if (_tabController.index == 1 && validateGraphDataForm()) {
            context.read<PatientController>().postGraphInfo(
                  patientId: _patientIdController.text,
                  datetime:
                      '${_graphDateGraphController.text} ${_graphTimeGraphController.text}',
                  temperature: _temperatureController.text,
                  bloodPressure: _bloodPressureController.text,
                  bloodOxygen: _bloodOxygenController.text,
                  callBack: () {
                    clearGraphInfoForm();
                  },
                );
          }
          if (_tabController.index == 2 && validateHeartDataForm()) {
            context.read<PatientController>().postHeartInfo(
                  patientId: _patientIdController.text,
                  datetime:
                      '${_heartDateheartController.text} ${_heartTimeheartController.text}',
                  cVP: _cvpController.text,
                  pAP: _papController.text,
                  pWP: _pwpController.text,
                  cO: _coController.text,
                  iCP: _icpController.text,
                  callBack: () {
                    clearHeartInfoForm();
                  },
                );
          }
          if (_tabController.index == 3 && validateRespiratoryDataForm()) {
            context.read<PatientController>().postRespiratoryInfo(
                  patientId: _patientIdController.text,
                  datetime:
                      '${_respiratoryDaterespiratoryController.text} ${_respiratoryTimerespiratoryController.text}',
                  respirationType: _respiratoryTypeController.text,
                  vT: _vtController.text,
                  rr: _rrController.text,
                  pEEP: _peepController.text,
                  fiO2: _fio2Controller.text,
                  maskO2: _maskO2Controller.text,
                  callBack: () {
                    clearRespiratoryInfoForm();
                  },
                );
          }
          if (_tabController.index == 4 && validateBloodGassesForm()) {
            context.read<PatientController>().postBloodGasesInfo(
                  patientId: _patientIdController.text,
                  datetime:
                      '${_bloodgasesDatebloodgasesController.text} ${_bloodgasesTimebloodgasesController.text}',
                  pH: _phController.text,
                  paO2: _paO2Controller.text,
                  paCO2: _paCO2Controller.text,
                  hCO3: _hco3Controller.text,
                  satO2: _satO2Controller.text,
                  bE: _beController.text,
                  callBack: () {
                    clearBloodGasesInfoForm();
                  },
                );
          }
          if (_tabController.index == 5 && validateExpelledFluidsForm()) {
            context.read<PatientController>().postExpelledFluidsInfo(
                  patientId: _patientIdController.text,
                  datetime:
                      '${_expelledfluidDateexpelledfluidController.text} ${_expelledfluidTimeexpelledfluidController.text}',
                  urine: _urineController.text,
                  levin: _levinController.text,
                  paroxeteushA: _paroxeteushAController.text,
                  paroxeteushB: _paroxeteushBController.text,
                  lostFluidSum: _lostFluidSumController.text,
                  callBack: () {
                    clearExpelledFluidInfoForm();
                  },
                );
          }
        },
        backgroundColor: Colors.green,
        child: Text(
          'Submit',
          style: TextStyle(color: Colors.white),
        ),
        // Icon(
        //   _tabController.index != 2
        //       ? Icons.arrow_forward_ios_rounded
        //       : Icons.save,
        // color: Colors.white,
        // ),
      ),
    );
  }

  Widget buildPatientInfoForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: <Widget>[
          buildTextField(
            'Patient ID',
            _patientIdController,
            TextInputType.number,
            textInputAction: TextInputAction.done,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          buildTextField(
              'First Name', _firstNameController, TextInputType.text),
          buildTextField('Last Name', _lastNameController, TextInputType.text),
          buildTextField('Age', _ageController, TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ]),
          buildTextField('Height', _heightController, TextInputType.number,
              inputFormatters: [
                FormTextInputFormatter.double,
              ]),
          buildTextField('Weight', _weightController, TextInputType.number,
              inputFormatters: [
                FormTextInputFormatter.double,
              ]),
          buildTextField('Diagnosis', _diagnosisController, TextInputType.text),
          buildTextField('Do Not Administer', _doNotAdministerController,
              TextInputType.text),
          buildTextField('Blood Type', _bloodTypeController, TextInputType.text,
              textInputAction: TextInputAction.done),
          Container(
            height: 40.h,
            padding: REdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_dateOfEntryController.text.isNotEmpty
                    ? _dateOfEntryController.text
                    : 'Date of Entry'),
                GestureDetector(
                  onTap: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    final res = await PateintHelper.selectDate(context);
                    if (res != null) {
                      _dateOfEntryController.text = res;
                      setState(() {});
                    }
                  },
                  child: Icon(
                    Icons.calendar_month,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGraphDataForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: <Widget>[
          buildTextField(
            'Patient ID',
            _patientIdController,
            TextInputType.number,
            textInputAction: TextInputAction.done,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          Container(
            height: 40.h,
            padding: REdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_graphDateGraphController.text.isNotEmpty
                    ? _graphDateGraphController.text
                    : 'Date'),
                GestureDetector(
                  onTap: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    final res = await PateintHelper.selectDate(context);
                    if (res != null) {
                      _graphDateGraphController.text = res;
                      setState(() {});
                    }
                  },
                  child: Icon(
                    Icons.calendar_month,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            height: 40.h,
            padding: REdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_graphTimeGraphController.text.isNotEmpty
                    ? _graphTimeGraphController.text
                    : 'Time'),
                GestureDetector(
                  onTap: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    final res = await PateintHelper.selectTime(
                        context, _graphDateGraphController.text);
                    if (res != null) {
                      _graphTimeGraphController.text = res;
                      // .replaceAll(':00', '');
                      setState(() {});
                    }
                  },
                  child: Icon(
                    Icons.calendar_month,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          buildTextField(
            'Temperature (ºC)',
            _temperatureController,
            TextInputType.number,
            inputFormatters: [
              FormTextInputFormatter.double,
            ],
          ),
          buildTextField(
            'Blood Pressure (mmHg)',
            _bloodPressureController,
            TextInputType.number,
            inputFormatters: [
              FormTextInputFormatter.double,
            ],
          ),
          buildTextField(
            'Blood Oxygen (SpO2)',
            _bloodOxygenController,
            TextInputType.number,
            inputFormatters: [
              FormTextInputFormatter.double,
            ],
          ),
        ],
      ),
    );
  }

  Widget buildHeartDataForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: <Widget>[
          buildTextField(
            'Patient ID',
            _patientIdController,
            TextInputType.number,
            textInputAction: TextInputAction.done,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          Container(
            height: 40.h,
            padding: REdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_heartDateheartController.text.isNotEmpty
                    ? _heartDateheartController.text
                    : 'Date'),
                GestureDetector(
                  onTap: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    final res = await PateintHelper.selectDate(context);
                    if (res != null) {
                      _heartDateheartController.text = res;
                      setState(() {});
                    }
                  },
                  child: Icon(
                    Icons.calendar_month,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            height: 40.h,
            padding: REdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_heartTimeheartController.text.isNotEmpty
                    ? _heartTimeheartController.text
                    : 'Time'),
                GestureDetector(
                  onTap: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    final res = await PateintHelper.selectTime(
                        context, _heartDateheartController.text);
                    if (res != null) {
                      _heartTimeheartController.text = res;
                      //.replaceAll(':00', '');
                      setState(() {});
                    }
                  },
                  child: Icon(
                    Icons.calendar_month,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          buildTextField(
            'CVP',
            _cvpController,
            TextInputType.number,
            inputFormatters: [
              FormTextInputFormatter.double,
            ],
          ),
          buildTextField(
            'PAP',
            _papController,
            TextInputType.number,
            inputFormatters: [
              FormTextInputFormatter.double,
            ],
          ),
          buildTextField(
            'PWP',
            _pwpController,
            TextInputType.number,
            inputFormatters: [
              FormTextInputFormatter.double,
            ],
          ),
          buildTextField(
            'CO',
            _coController,
            TextInputType.number,
            inputFormatters: [
              FormTextInputFormatter.double,
            ],
          ),
          buildTextField(
            'ICP',
            _icpController,
            TextInputType.number,
            textInputAction: TextInputAction.done,
            inputFormatters: [
              FormTextInputFormatter.double,
            ],
          ),
        ],
      ),
    );
  }

  Widget buildRespiratoryDataForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: <Widget>[
          buildTextField(
            'Patient ID',
            _patientIdController,
            TextInputType.number,
            textInputAction: TextInputAction.done,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          Container(
            height: 40.h,
            padding: REdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_respiratoryDaterespiratoryController.text.isNotEmpty
                    ? _respiratoryDaterespiratoryController.text
                    : 'Date'),
                GestureDetector(
                  onTap: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    final res = await PateintHelper.selectDate(context);
                    if (res != null) {
                      _respiratoryDaterespiratoryController.text = res;
                      setState(() {});
                    }
                  },
                  child: Icon(
                    Icons.calendar_month,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            height: 40.h,
            padding: REdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_respiratoryTimerespiratoryController.text.isNotEmpty
                    ? _respiratoryTimerespiratoryController.text
                    : 'Time'),
                GestureDetector(
                  onTap: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    final res = await PateintHelper.selectTime(
                        context, _respiratoryDaterespiratoryController.text);
                    if (res != null) {
                      _respiratoryTimerespiratoryController.text = res;
                      //
                      //replaceAll(':00', '');
                      setState(() {});
                    }
                  },
                  child: Icon(
                    Icons.calendar_month,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          buildTextField(
            'Respiration Type',
            _respiratoryTypeController,
            TextInputType.text,
          ),
          buildTextField(
            'VT',
            _vtController,
            TextInputType.number,
            inputFormatters: [
              FormTextInputFormatter.double,
            ],
          ),
          buildTextField(
            'RR',
            _rrController,
            TextInputType.number,
            inputFormatters: [
              FormTextInputFormatter.double,
            ],
          ),
          buildTextField(
            'PEEP',
            _peepController,
            TextInputType.number,
            inputFormatters: [
              FormTextInputFormatter.double,
            ],
          ),
          buildTextField(
            'FiO2',
            _fio2Controller,
            TextInputType.number,
            inputFormatters: [
              FormTextInputFormatter.double,
            ],
          ),
          buildTextField(
            'MaskO2',
            _maskO2Controller,
            TextInputType.text,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }

  Widget buildBloodGassesForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: <Widget>[
          buildTextField(
            'Patient ID',
            _patientIdController,
            TextInputType.number,
            textInputAction: TextInputAction.done,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          Container(
            height: 40.h,
            padding: REdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_bloodgasesDatebloodgasesController.text.isNotEmpty
                    ? _bloodgasesDatebloodgasesController.text
                    : 'Date'),
                GestureDetector(
                  onTap: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    final res = await PateintHelper.selectDate(context);
                    if (res != null) {
                      _bloodgasesDatebloodgasesController.text = res;
                      setState(() {});
                    }
                  },
                  child: Icon(
                    Icons.calendar_month,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            height: 40.h,
            padding: REdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_bloodgasesTimebloodgasesController.text.isNotEmpty
                    ? _bloodgasesTimebloodgasesController.text
                    : 'Time'),
                GestureDetector(
                  onTap: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    final res = await PateintHelper.selectTime(
                        context, _bloodgasesDatebloodgasesController.text);
                    if (res != null) {
                      _bloodgasesTimebloodgasesController.text = res;
                      //
                      //.replaceAll(':00', '');
                      setState(() {});
                    }
                  },
                  child: Icon(
                    Icons.calendar_month,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          buildTextField(
            'pH',
            _phController,
            TextInputType.number,
            inputFormatters: [
              FormTextInputFormatter.double,
            ],
          ),
          buildTextField(
            'PaO2',
            _paO2Controller,
            TextInputType.number,
            inputFormatters: [
              FormTextInputFormatter.double,
            ],
          ),
          buildTextField(
            'PaCO2',
            _paCO2Controller,
            TextInputType.number,
            inputFormatters: [
              FormTextInputFormatter.double,
            ],
          ),
          buildTextField(
            'HCO3',
            _hco3Controller,
            TextInputType.number,
            inputFormatters: [
              FormTextInputFormatter.double,
            ],
          ),
          buildTextField(
            'SatO2',
            _satO2Controller,
            TextInputType.number,
            inputFormatters: [
              FormTextInputFormatter.double,
            ],
          ),
          buildTextField(
            'BE',
            _beController,
            TextInputType.number,
            inputFormatters: [
              FormTextInputFormatter.double,
            ],
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }

  Widget buildExpelledFluidsForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: <Widget>[
          buildTextField(
            'Patient ID',
            _patientIdController,
            TextInputType.number,
            textInputAction: TextInputAction.done,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          Container(
            height: 40.h,
            padding: REdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_expelledfluidDateexpelledfluidController.text.isNotEmpty
                    ? _expelledfluidDateexpelledfluidController.text
                    : 'Date'),
                GestureDetector(
                  onTap: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    final res = await PateintHelper.selectDate(context);
                    if (res != null) {
                      _expelledfluidDateexpelledfluidController.text = res;
                      setState(() {});
                    }
                  },
                  child: Icon(
                    Icons.calendar_month,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            height: 40.h,
            padding: REdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_expelledfluidTimeexpelledfluidController.text.isNotEmpty
                    ? _expelledfluidTimeexpelledfluidController.text
                    : 'Time'),
                GestureDetector(
                  onTap: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    final res = await PateintHelper.selectTime(context,
                        _expelledfluidDateexpelledfluidController.text);
                    if (res != null) {
                      _expelledfluidTimeexpelledfluidController.text = res;
                      //
                      //.replaceAll(':00', '');
                      setState(() {});
                    }
                  },
                  child: Icon(
                    Icons.calendar_month,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          buildTextField(
            'Urine',
            _urineController,
            TextInputType.number,
            inputFormatters: [
              FormTextInputFormatter.double,
            ],
          ),
          buildTextField(
            'Levin',
            _levinController,
            TextInputType.number,
            inputFormatters: [
              FormTextInputFormatter.double,
            ],
          ),
          buildTextField(
            'ParoxeteushA',
            _paroxeteushAController,
            TextInputType.number,
            inputFormatters: [
              FormTextInputFormatter.double,
            ],
          ),
          buildTextField(
            'ParoxeteushB',
            _paroxeteushBController,
            TextInputType.number,
            inputFormatters: [
              FormTextInputFormatter.double,
            ],
          ),
          buildTextField(
            'Lost Fluid Sum',
            _lostFluidSumController,
            TextInputType.number,
            inputFormatters: [
              FormTextInputFormatter.double,
            ],
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }

  Widget buildTextField(
    String labelText,
    TextEditingController controller,
    TextInputType keyboardType, {
    Widget? suffixIcon,
    List<TextInputFormatter>? inputFormatters,
    bool readOnly = false,
    bool? ignorePointers,
    TextInputAction? textInputAction,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
          suffixIcon: suffixIcon,
        ),
        readOnly: readOnly,
        ignorePointers: ignorePointers,
        keyboardType: keyboardType,
        textInputAction: textInputAction ?? TextInputAction.next,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter $labelText';
          }
          return null;
        },
        inputFormatters: inputFormatters,
      ),
    );
  }

  void clearPatientInfoForm() {
    _patientIdController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _ageController.clear();
    _heightController.clear();
    _weightController.clear();
    _diagnosisController.clear();
    _doNotAdministerController.clear();
    _bloodTypeController.clear();
    _dateOfEntryController.clear();
  }

  void clearGraphInfoForm() {
    _patientIdController.clear();
    _graphDateGraphController.clear();
    _graphTimeGraphController.clear();
    _temperatureController.clear();
    _bloodPressureController.clear();
    _bloodOxygenController.clear();
    setState(() {});
  }

  void clearHeartInfoForm() {
    _patientIdController.clear();
    _heartDateheartController.clear();
    _heartTimeheartController.clear();
    _cvpController.clear();
    _papController.clear();
    _pwpController.clear();
    _coController.clear();
    _icpController.clear();
    setState(() {});
  }

  void clearRespiratoryInfoForm() {
    _patientIdController.clear();
    _respiratoryDaterespiratoryController.clear();
    _respiratoryTimerespiratoryController.clear();
    _respiratoryTypeController.clear();
    _vtController.clear();
    _rrController.clear();
    _peepController.clear();
    _fio2Controller.clear();
    _maskO2Controller.clear();
    setState(() {});
  }

  void clearBloodGasesInfoForm() {
    _patientIdController.clear();
    _bloodgasesDatebloodgasesController.clear();
    _bloodgasesTimebloodgasesController.clear();
    _phController.clear();
    _paO2Controller.clear();
    _paCO2Controller.clear();
    _hco3Controller.clear();
    _satO2Controller.clear();
    _beController.clear();
    setState(() {});
  }

  void clearExpelledFluidInfoForm() {
    _patientIdController.clear();
    _expelledfluidDateexpelledfluidController.clear();
    _expelledfluidTimeexpelledfluidController.clear();
    _urineController.clear();
    _levinController.clear();
    _paroxeteushAController.clear();
    _paroxeteushBController.clear();
    _lostFluidSumController.clear();
    setState(() {});
  }

  bool validatePatientInfoForm() {
    return _patientIdController.text.isNotEmpty &&
        _firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty &&
        _ageController.text.isNotEmpty &&
        _heightController.text.isNotEmpty &&
        _weightController.text.isNotEmpty &&
        _diagnosisController.text.isNotEmpty &&
        _doNotAdministerController.text.isNotEmpty &&
        _bloodTypeController.text.isNotEmpty &&
        _dateOfEntryController.text.isNotEmpty;
  }

  bool validateGraphDataForm() {
    return _patientIdController.text.isNotEmpty &&
        _graphDateGraphController.text.isNotEmpty &&
        _graphTimeGraphController.text.isNotEmpty &&
        _temperatureController.text.isNotEmpty &&
        _bloodPressureController.text.isNotEmpty &&
        _bloodOxygenController.text.isNotEmpty;
  }

  bool validateHeartDataForm() {
    return _patientIdController.text.isNotEmpty &&
        _heartDateheartController.text.isNotEmpty &&
        _heartTimeheartController.text.isNotEmpty &&
        _cvpController.text.isNotEmpty &&
        _papController.text.isNotEmpty &&
        _pwpController.text.isNotEmpty &&
        _coController.text.isNotEmpty &&
        _icpController.text.isNotEmpty;
  }

  bool validateRespiratoryDataForm() {
    return _patientIdController.text.isNotEmpty &&
        _respiratoryDaterespiratoryController.text.isNotEmpty &&
        _respiratoryTimerespiratoryController.text.isNotEmpty &&
        _vtController.text.isNotEmpty &&
        _rrController.text.isNotEmpty &&
        _peepController.text.isNotEmpty &&
        _fio2Controller.text.isNotEmpty &&
        _maskO2Controller.text.isNotEmpty;
  }

  bool validateBloodGassesForm() {
    return _patientIdController.text.isNotEmpty &&
        _bloodgasesDatebloodgasesController.text.isNotEmpty &&
        _bloodgasesTimebloodgasesController.text.isNotEmpty &&
        _phController.text.isNotEmpty &&
        _paO2Controller.text.isNotEmpty &&
        _paCO2Controller.text.isNotEmpty &&
        _hco3Controller.text.isNotEmpty &&
        _satO2Controller.text.isNotEmpty &&
        _beController.text.isNotEmpty;
  }

  bool validateExpelledFluidsForm() {
    return _patientIdController.text.isNotEmpty &&
        _expelledfluidDateexpelledfluidController.text.isNotEmpty &&
        _expelledfluidTimeexpelledfluidController.text.isNotEmpty &&
        _urineController.text.isNotEmpty &&
        _levinController.text.isNotEmpty &&
        _paroxeteushAController.text.isNotEmpty &&
        _paroxeteushBController.text.isNotEmpty &&
        _lostFluidSumController.text.isNotEmpty;
  }
}
