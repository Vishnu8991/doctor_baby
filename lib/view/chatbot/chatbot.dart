import 'package:flutter/material.dart';

class MyVaccineDatabase {
  List<Map<String, dynamic>> questions = [
    {
      'question': 'Select a category',
      'options': ['To know more about my child vaccine', 'What is a vaccine?']
    },
    {
      'question': 'To know more about my child vaccine',
      'options': [
        'What vaccines are recommended for my child?',
        'When should my child get vaccinated?',
        'Next vaccine date ?',
        'Give all vaccine schedules'
      ]
    },
    {
      'question': 'What is a vaccine?',
      'options': [
        'How do vaccines work?',
        'Are vaccines safe?',
        'Why should I vaccinate my child?',
        'Can my baby handle all of these vaccines?'
      ]
    },
    {
      'question': 'What vaccines are recommended for my child?',
      'options': ['Next vaccine date?', 'Give all vaccine schedules']
    },
  ];

  Map<String, String> answers = {
    "Next vaccine date ?":
        'The next vaccine date for your child is on January 15, 2023.',
    "Give all vaccine schedules":
        "Here is the complete vaccine schedule for your child... \n november 4 \n december 4\n january 4 ",
    'What vaccines are recommended for my child?':
        'The recommended vaccines for your child include...',
    'When should my child get vaccinated?':
        'Your child should receive vaccinations according to the following schedule...',
    'How do vaccines work?':
        'Vaccines work by stimulating the immune system to recognize and fight specific pathogens...',
    'Are vaccines safe?':
        'Yes, vaccines are rigorously tested for safety and are an essential tool in preventing diseases...',
    'Why should I vaccinate my child?':
        'Vaccinating your child is important for protecting them against serious diseases and building immunity...',
    'Can my baby handle all of these vaccines?':
        'Vaccines are carefully designed to be safe for babies and are administered based on a schedule recommended by health professionals...',
  };
}

class ChatMessage {
  String message;
  bool isUser;

  ChatMessage({required this.message, required this.isUser});
}

class ChatBot extends StatefulWidget {
  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final List<ChatMessage> chatMessages = [];
  final MyVaccineDatabase database = MyVaccineDatabase();
  List<String> botOptions = [];
  int currentQuestionIndex = 0;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _displayWelcomeMessage();
    _displayOptions();
  }

  bool canGoBack() {
    return currentQuestionIndex > 0;
  }

 void _handleBack() {
  if (canGoBack()) {
    // Remove the last user message
    chatMessages.removeLast();

    // Go back to the previous question
    currentQuestionIndex--;
    _displayOptions();

    setState(() {});
  }
}


  void _handleOptionSelected(String selectedOption) {
    setState(() {
      chatMessages.add(ChatMessage(message: selectedOption, isUser: true));
    });

    if (currentQuestionIndex >= 0 &&
        currentQuestionIndex < database.questions.length) {
      currentQuestionIndex = _getNextQuestionIndex(selectedOption);
      String botResponse = _getBotResponse(selectedOption);

      if (database.questions[currentQuestionIndex]['options'] != null) {
        _displayOptions();
      }

      setState(() {
        if (botResponse.isNotEmpty) {
          chatMessages.add(ChatMessage(message: botResponse, isUser: false));
        }
      });

      // Scroll to the bottom only if it's a user message
      if (selectedOption.isNotEmpty) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    }
  }

  void _displayOptions() {
    botOptions.clear();
    if (currentQuestionIndex >= 0 &&
        currentQuestionIndex < database.questions.length) {
      for (var option in database.questions[currentQuestionIndex]['options']) {
        botOptions.add(option);
      }
    }
  }

  void _displayWelcomeMessage() {
    setState(() {
      chatMessages.add(ChatMessage(
        message: 'Hello User, how can I help you?',
        isUser: false,
      ));
      _displayOptions();
    });
  }

  int _getNextQuestionIndex(String selectedOption) {
    for (var i = currentQuestionIndex + 1; i < database.questions.length; i++) {
      if (database.questions[i]['question'] == selectedOption) {
        return i;
      }
    }
    return currentQuestionIndex;
  }

  String _getBotResponse(String selectedOption) {
    if (database.answers.containsKey(selectedOption)) {
      return database.answers[selectedOption]!;
    } else {
      // Return an empty string for subcategories
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Chat Bot .',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: chatMessages.length + botOptions.length + (canGoBack() ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < chatMessages.length) {
                  ChatMessage message = chatMessages[index];
                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Align(
                      alignment: message.isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        child: ClipRRect(
                          borderRadius: message.isUser
                              ? BorderRadius.only(
                                  topLeft: Radius.circular(16.0),
                                  bottomRight: Radius.circular(16.0),
                                  bottomLeft: Radius.circular(16.0),
                                )
                              : BorderRadius.only(
                                  topRight: Radius.circular(16.0),
                                  bottomLeft: Radius.circular(16.0),
                                  bottomRight: Radius.circular(16.0),
                                ),
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            color: message.isUser ? Colors.blue : Colors.grey,
                            child: Text(
                              message.message,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  if (canGoBack() && index == chatMessages.length + botOptions.length) {
                    return Row(
                      children: [
                        SizedBox(width: 10,),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                          ),
                          onPressed: _handleBack,
                          child: Row(
                            children: [
                              Icon(Icons.arrow_back,color: Colors.white,),
                              SizedBox(width: 10,),
                              Text('Previous',style: TextStyle(color: Colors.white),),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            _handleOptionSelected(botOptions[index - chatMessages.length]);
                          },
                          child: Text(botOptions[index - chatMessages.length]),
                        ),
                      ],
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
