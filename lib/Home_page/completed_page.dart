import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:tisserproject/Add_page/bloc/add_bloc.dart';
import 'package:tisserproject/Home_page/detail_page.dart';

class completepage extends StatefulWidget {
  completepage({super.key});

  @override
  State<completepage> createState() => _completepageState();
}

class _completepageState extends State<completepage> {
  @override
  void initState() {
    BlocProvider.of<AddBloc>(context).add(completeevent());
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
                  children: [
                    Expanded(
                      child: Lottie.network(
                        'https://lottie.host/c2703783-e5a7-4b37-92dc-74efc6532388/YooNFUvqOK.json',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 17, left: 20),
                  child: Image.network(
                    'https://img.icons8.com/?size=100&id=VFaz7MkjAiu0&format=png&color=000000',
                    width: 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 20),
                  child: Text(
                    "COMPLETED ",
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 21,
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              child: BlocBuilder<AddBloc, AddState>(
                builder: (context, state) {
                  if (state is addedloading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is completedataloaded) {
                    if (state.completevalue.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.task_alt, size: 60, color: Colors.grey),
                            const SizedBox(height: 10),
                            Text(
                              "No completed tasks yet!",
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
                            child: InkWell(
                              onTap: () {
                                final bloc = context.read<AddBloc>();

                                Navigator.of(context)
                                    .push(
                                      MaterialPageRoute(
                                        builder: (_) => detailcompletepage(
                                          id: data.id,
                                          title: data.title,
                                        ),
                                      ),
                                    )
                                    .then((_) {
                                      bloc.add(completeevent());
                                    });
                              },

                              child: Card(
                                elevation: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Title: ${data.title.toUpperCase()}",
                                        style: GoogleFonts.manrope(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 6),

                                      Text(
                                        "Status: ${data.status}",
                                        style: GoogleFonts.manrope(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
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
