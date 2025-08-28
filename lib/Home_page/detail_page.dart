import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:tisserproject/Add_page/bloc/add_bloc.dart';
import 'package:tisserproject/Home_page/update_page.dart';

class detailcompletepage extends StatefulWidget {
  detailcompletepage({required this.id, required this.title});

  String id;
  String title;

  @override
  State<detailcompletepage> createState() => _detailcompletepageState();
}

class _detailcompletepageState extends State<detailcompletepage> {
  @override
  void initState() {
    BlocProvider.of<AddBloc>(
      context,
    ).add(detailcompletedevent(id: widget.id, title: widget.title));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 239, 237, 236),
        body: Column(
          children: [
            Container(
              width: w,
              height: h * 0.2,
              decoration: BoxDecoration(
                color: Color(0xFF3338A0),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 10),
                    Lottie.network(
                      'https://lottie.host/a9b78305-42c1-4fd4-82db-f98197da27fd/SNbkwM9VLV.json',
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: BlocBuilder<AddBloc, AddState>(
                builder: (context, state) {
                  if (state is addedloading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is detailcompletedataloaded) {
                    if (state.completevalue.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.task_alt, size: 60, color: Colors.grey),
                            const SizedBox(height: 10),
                            Text(
                              "Sorry not found",
                              style: GoogleFonts.manrope(
                                fontSize: 18,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ListView.builder(
                        itemCount: state.completevalue.length,
                        itemBuilder: (context, index) {
                          final data = state.completevalue[index];
                          return Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            child: Card(
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10),
                                    Text(
                                      "Title: ${data.title.toUpperCase()}",
                                      style: GoogleFonts.manrope(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    Text(
                                      "Description: ${data.desc}",
                                      style: GoogleFonts.manrope(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 10),

                                    Text(
                                      "Date: ${data.date}",
                                      style: GoogleFonts.manrope(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 10),

                                    Text(
                                      "Status: ${data.status}",
                                      style: GoogleFonts.manrope(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                      ),
                                      onPressed: () async {
                                        final bloc = BlocProvider.of<AddBloc>(
                                          context,
                                        );

                                        await Navigator.of(context)
                                            .push(
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    EditPage(task: data),
                                              ),
                                            )
                                            .then((_) {
                                              bloc.add(
                                                detailcompletedevent(
                                                  id: widget.id,
                                                  title: widget.title,
                                                ),
                                              );
                                            });
                                      },
                                      child: Text(
                                        "Edit",
                                        style: GoogleFonts.manrope(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is addederror) {
                    return Center(child: Text(state.error));
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
