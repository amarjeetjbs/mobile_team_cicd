import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_team_cicd/feature/home/cubit/holiday_cubit.dart';
import 'package:mobile_team_cicd/feature/term_condition/term_condition_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<HolidayCubit>().isThereHoliday(),
    );
    Future.microtask(
      () => context.read<HolidayCubit>().weekHolidays(),
    );
    Future.microtask(
      () => context.read<HolidayCubit>().monthHolidays(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HolidayCubit, HolidayState?>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Home"),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Text('Holiday calendar'),
                ),
                ListTile(
                  title: const Text('All the holidays'),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('Terms and Conditions'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const TermAndConditionPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Today"),
                  Text(
                    "Is today is a holiday: "
                    "${(state?.todayHoliday ?? false) ? "Yes" : "No"}",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text("Week"),
                  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    border: TableBorder.all(color: Colors.black),
                    children: [
                      const TableRow(
                        children: [
                          CellTitle(title: 'date'),
                          CellTitle(title: 'day'),
                          CellTitle(title: 'name'),
                          CellTitle(title: 'states'),
                        ],
                      ),
                      ...List.generate(
                        (state?.thisWeekHoliday?.length ?? 0),
                        (index) => TableRow(
                          children: [
                            CellBody(body: state?.thisWeekHoliday?[index].date),
                            CellBody(body: state?.thisWeekHoliday?[index].day),
                            CellBody(body: state?.thisWeekHoliday?[index].name),
                            CellBody(
                                body: state?.thisWeekHoliday?[index].states
                                    .toString()),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Text("This month"),
                  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    border: TableBorder.all(color: Colors.black),
                    children: [
                      const TableRow(
                        children: [
                          CellTitle(title: 'date'),
                          CellTitle(title: 'day'),
                          CellTitle(title: 'name'),
                          CellTitle(title: 'states'),
                        ],
                      ),
                      ...List.generate(
                        (state?.thisWeekHoliday?.length ?? 0),
                        (index) => TableRow(
                          children: [
                            CellBody(body: state?.thisWeekHoliday?[index].date),
                            CellBody(body: state?.thisWeekHoliday?[index].day),
                            CellBody(body: state?.thisWeekHoliday?[index].name),
                            CellBody(
                              body: state?.thisWeekHoliday?[index].states
                                  .toString(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CellBody extends StatelessWidget {
  const CellBody({super.key, required this.body});

  final String? body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        (body ?? "").replaceAll("[", "").replaceAll("]", ""),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class CellTitle extends StatelessWidget {
  const CellTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
