import 'package:flutter/material.dart';

class detailsInfo extends StatefulWidget {
  detailsInfo({
    required this.repo,
    required this.commits,
  });
  dynamic repo;
  int commits;

  @override
  _detailsInfoState createState() => _detailsInfoState();
}

class _detailsInfoState extends State<detailsInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(widget.repo['name']),
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(color: Colors.white24),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // ------- NAME ------- //
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 350,
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      widget.repo['name'],
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ------- DESCRIPTION ------- //
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 350,
                    child: Text(
                      "${widget.repo['name']} - ${widget.repo['description']}",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 60),

              // // ------- LICENSE ------- //
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 350,
                    child: Text(
                      "License:          ${widget.repo['licenseInfo']['spdxId']}",
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 18),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // ------- COMMITS ------- //
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 350,
                    child: Text(
                      "Commits:         " + widget.commits.toString(),
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 18),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // ------- BRANCHES ------- //
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 350,
                    child: Text(
                      "Branches:           ${widget.repo['refs']['totalCount']}",
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 18),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ------- TILLBAKA ------- //
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 300, 0, 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: const Color.fromRGBO(250, 246, 149, 1)),
                    width: 150,
                    height: 40,
                    child: InkWell(
                      onTap: () {
                        //Go back to cards
                        Navigator.pop(context);
                      },
                      child: const Center(
                        child: Text(
                          'TILLBAKA',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
