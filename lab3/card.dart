import 'package:flutter/material.dart';
import 'package:lab3_test2/details.dart';

class Cardinfo extends StatelessWidget {
  Cardinfo({
    required this.repo,
    required this.commits,
  });
  dynamic repo;
  int commits;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => detailsInfo(
                      repo: repo,
                      commits: commits,
                    )),
          );
        },
        child: Card(
            child: Container(
          color: const Color.fromRGBO(66, 66, 66, 1),
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0, 0),
          child: Column(
            children: <Widget>[
              Align(
                  // ------- TITLE ------- //
                  alignment: Alignment.topLeft,
                  child: Text(
                    repo["name"],
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  )),
              const SizedBox(height: 4.0),
              Align(
                  // ------- URL ------- //
                  alignment: Alignment.topLeft,
                  child: Text(
                    repo["url"],
                    style: const TextStyle(color: Colors.grey, fontSize: 13.0),
                  )),
              const SizedBox(height: 8.0),
              Align(
                  // ------- DESCRIPTION ------- //
                  alignment: Alignment.topLeft,
                  child: Text(
                    repo["description"],
                    style: const TextStyle(color: Colors.white, fontSize: 14.0),
                  )),
              const SizedBox(height: 7.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  // ------- FORK ------- //
                  Container(
                    padding: const EdgeInsets.all(5),
                    color: const Color.fromRGBO(63, 63, 63, 1),
                    child: Text("Forks " + repo["forkCount"].toString(),
                        style: const TextStyle(color: Colors.white)),
                  ),
                  // ------- STARS ------- //
                  Container(
                    padding: const EdgeInsets.all(5),
                    color: const Color.fromRGBO(250, 246, 149, 1),
                    child: Text("Stars " + repo["stargazerCount"].toString()),
                  ),
                ],
              ),
            ],
          ),
        )));
  }
}
