import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:tisserproject/Add_page/bloc/add_bloc.dart';
import 'package:tisserproject/Auth/bloc/auth_bloc.dart';
import 'package:tisserproject/Auth/screen/check_page.dart';
import 'package:tisserproject/Home_page/completed_page.dart';
import 'package:tisserproject/Home_page/pending_page.dart';

class ProjectDashboard extends StatelessWidget {
  const ProjectDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (_) => AddBloc()..add(FetchProjectCount()),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: AppBar(
            backgroundColor: const Color(0xFF3338A0),
            centerTitle: true,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Track your projects easily",
                          style: GoogleFonts.aBeeZee(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Color.fromARGB(
                                  255,
                                  60,
                                  59,
                                  59,
                                ),
                                title: Text(
                                  'Alert',
                                  style: TextStyle(color: Colors.white),
                                ),
                                content: Text(
                                  'Are You Want to Exit.',
                                  style: TextStyle(color: Colors.white),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      BlocProvider.of<AuthBloc>(
                                        context,
                                      ).add(logoutevent());
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                          builder: (context) => AuthWrapper(),
                                        ),
                                        (route) => false,
                                      );
                                    },
                                    child: Text('YES'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('NO'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.exit_to_app, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<AddBloc, AddState>(
            builder: (context, state) {
              if (state is ProjectCountLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProjectCountLoaded) {
                if (state.completedCount == 0 && state.pendingCount == 0) {
                  return const Center(
                    child: Text(
                      "No project added",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  );
                }

                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return completepage();
                        //     },
                        //   ),
                        // );
                        final bloc = context.read<AddBloc>();

                        Navigator.of(context)
                            .push(
                              MaterialPageRoute(builder: (_) => completepage()),
                            )
                            .then((_) {
                              bloc.add(FetchProjectCount());
                            });
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.network(
                              'https://lottie.host/38509159-9ead-4ea6-8a69-41d481c03c4a/t69ZL3reLA.json',
                              height: h * 0.26,
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 35,
                              ),
                              title: Text(
                                "COMPLETED PROJECTS",
                                style: GoogleFonts.manrope(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Text(
                                state.completedCount.toString(),
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    InkWell(
                      onTap: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return pendingpage();
                        //     },
                        //   ),
                        // );

                        final bloc = context.read<AddBloc>();

                        Navigator.of(context)
                            .push(
                              MaterialPageRoute(builder: (_) => pendingpage()),
                            )
                            .then((_) {
                              bloc.add(FetchProjectCount());
                            });
                      },

                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Lottie.network(
                              'https://lottie.host/e323b102-7694-420c-be4a-9fa563bd1f73/yY8UHHqDDr.json',
                              height: h * 0.26,
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.pending_actions,
                                color: Colors.orange,
                                size: 35,
                              ),
                              title: Text(
                                "PENDING PROJECTS",
                                style: GoogleFonts.manrope(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Text(
                                state.pendingCount.toString(),
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is ProjectCountError) {
                return Center(child: Text("Error: ${state.error}"));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
