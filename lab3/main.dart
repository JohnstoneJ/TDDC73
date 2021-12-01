import 'package:flutter/material.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:lab3_test2/card.dart';

String readRepositories = """
  query ReadRepositories(\$queryString: String!) {
    search(query: \$queryString, type: REPOSITORY, first: 10 ){
        nodes {
          ... on Repository{
          refs(refPrefix: "refs/heads/") {
              totalCount
            }
          id
          description
          name
          forkCount
          stargazerCount
          url
          licenseInfo{  
            nickname
            spdxId
          }
          commitComments{
            totalCount
          }
          branchProtectionRules{
            totalCount
            }
            
            object(expression: "master") {
              ... on Commit {
                history {
                  totalCount
                }
              }
            }
          }
        }  
      }
  }
""";

void main() async {
  // We're using HiveStore for persistence,
  // so we need to initialize Hive.
  await initHiveForFlutter();

  final HttpLink httpLink = HttpLink(
    'https://api.github.com/graphql',
  );

  final AuthLink authLink = AuthLink(
    getToken: () async => 'Bearer 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',
  );

  final Link link = authLink.concat(httpLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  var app = GraphQLProvider(client: client, child: const MyApp());
  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(
        title: 'GitHub Trending',
        noOfCommits: 0,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.noOfCommits})
      : super(key: key);

  final String title;
  final int noOfCommits;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedLanguage = 'JavaScript';
  List<String> languageList = [
    'JavaScript',
    'TypeScript',
    'Go',
    'Rust',
    'Swift',
    'Web',
    'PHP',
    'CSS',
    'C',
    'C#',
    'C++',
    'Python',
    'Ruby',
    'Java',
  ];

  void _setSelectedLanguage(String newLanguage) {
    setState(() {
      selectedLanguage = newLanguage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(48, 48, 48, 1),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Query(
                options: QueryOptions(
                  document: gql(
                      readRepositories), // this is the query string you just created
                  variables: {
                    'queryString': 'language: $selectedLanguage stars:>1000'
                  },
                  pollInterval: const Duration(seconds: 10),
                ),
                builder: (QueryResult result,
                    {VoidCallback? refetch, FetchMore? fetchMore}) {
                  if (result.hasException) {
                    return Text(result.exception.toString());
                  }
                  if (result.isLoading) {
                    return const Text('Loading');
                  }
                  // it can be either Map or List
                  List repositories = result.data?['search']['nodes'];

                  return ListView.builder(
                      itemCount: repositories.length,
                      itemBuilder: (context, index) {
                        final repository = repositories[index];
                        int noOfCommits = 0;

                        if (repository['object'] != null) {
                          noOfCommits =
                              repository['object']['history']['totalCount'];
                        }

                        return Cardinfo(
                          repo: repository,
                          commits: noOfCommits,
                        );
                      });
                },
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                border:
                    Border.all(color: const Color.fromRGBO(132, 150, 162, 1)),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: DropdownButton(
                isExpanded: true,
                underline: Container(),
                value: selectedLanguage,
                items: languageList
                    .map<DropdownMenuItem<String>>((String _monthValue) {
                  return DropdownMenuItem<String>(
                    value: _monthValue,
                    child: Text(_monthValue),
                  );
                }).toList(),
                onChanged: (value) {
                  _setSelectedLanguage(value.toString());
                  //fetchMore(opts);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
