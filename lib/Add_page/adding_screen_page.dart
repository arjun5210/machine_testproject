import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:tisserproject/Add_page/bloc/add_bloc.dart';
import 'package:tisserproject/model/data_model.dart';

class Addingpage extends StatefulWidget {
  const Addingpage({super.key});

  @override
  State<Addingpage> createState() => _AddingpageState();
}

class _AddingpageState extends State<Addingpage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  String _status = "Pending";
  @override
  void dispose() {
    _idController.clear();
    _titleController.clear();
    _descController.clear();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: w,
              height: h * 0.4,
              color: const Color(0xFF3338A0),
              child: Column(
                children: [
                  Lottie.network(
                    'https://lottie.host/c20eeb71-5722-482b-8707-d880667199c6/Rgzn1IxxNb.json',
                    height: h * 0.3,
                    width: w,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: w,
                height: h * 0.65,
                decoration: const BoxDecoration(
                  color: Color(0xFFF4E7E1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      SizedBox(height: h * 0.03),

                      _buildLabel("Title"),
                      TextFormField(
                        controller: _titleController,
                        decoration: _inputDecoration(),
                        validator: (value) => value == null || value.isEmpty
                            ? "Enter title"
                            : null,
                      ),
                      SizedBox(height: h * 0.02),

                      _buildLabel("ID"),
                      TextFormField(
                        controller: _idController,
                        decoration: _inputDecoration(),
                        validator: (value) =>
                            value == null || value.isEmpty ? "Enter ID" : null,
                      ),
                      SizedBox(height: h * 0.02),

                      _buildLabel("Description"),
                      TextFormField(
                        controller: _descController,
                        decoration: _inputDecoration(),
                        validator: (value) => value == null || value.isEmpty
                            ? "Enter description"
                            : null,
                      ),
                      SizedBox(height: h * 0.02),

                      _buildLabel("Status"),
                      DropdownButtonFormField<String>(
                        value: _status,
                        items: ['Pending', 'Completed']
                            .map(
                              (status) => DropdownMenuItem(
                                value: status,
                                child: Text(status),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _status = value!;
                          });
                        },
                        decoration: _inputDecoration(),
                      ),
                      SizedBox(height: h * 0.03),

                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            String today = DateFormat(
                              'dd-MM-yyyy',
                            ).format(DateTime.now());

                            var data = await datadetails(
                              date: today,
                              desc: _descController.text.trim(),
                              id: _idController.text.trim(),
                              title: _titleController.text.trim(),
                              status: _status,
                            );

                            BlocProvider.of<AddBloc>(
                              context,
                            ).add(addingevent(task: data));

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Form Submitted Successfully "),
                              ),
                            );
                            _idController.clear();
                            _titleController.clear();
                            _descController.clear();
                          }
                        },
                        child: Container(
                          width: w,
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFF3338A0),
                          ),
                          child: const Center(
                            child: Text(
                              "SUBMIT",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 20, bottom: 5),
      child: Text(
        text,
        style: GoogleFonts.manrope(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      fillColor: const Color(0xFFFFF2F2),
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
