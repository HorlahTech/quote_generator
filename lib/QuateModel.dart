class QuoteModel {
  //  final String quote;
  //  final String author;
  int quoteNumber = 0;

  // QuoteModel({required this.quote, required this.author});
  List<Map<String, String>> _quotes = [
    {
      "quote":
          "Success is not final, failure is not fatal: it is the courage to continue that counts.",
      "author": "Winston Churchill"
    },
    {
      "quote": "Believe you can and you're halfway there.",
      "author": "Theodore Roosevelt"
    },
    {
      "quote":
          "It does not matter how slowly you go as long as you do not stop.",
      "author": "Confucius"
    },
    {
      "quote":
          "I have not failed. I've just found 10,000 ways that won't work.",
      "author": "Thomas Edison"
    },
    {
      "quote":
          "I can't change the direction of the wind, but I can adjust my sails to always reach my destination.",
      "author": "Jimmy Dean"
    },
    {
      "quote": "Life is 10% what happens to us and 90% how we react to it.",
      "author": "Charles R. Swindoll"
    },
    {
      "quote":
          "Happiness is not something ready-made. It comes from your own actions.",
      "author": "Dalai Lama XIV"
    },
    {
      "quote":
          "Believe in yourself and all that you are. Know that there is something inside you that is greater than any obstacle.",
      "author": "Christian D. Larson"
    },
    {
      "quote": "The only way to do great work is to love what you do.",
      "author": "Steve Jobs"
    },
    {
      "quote":
          "In the end, we will remember not the words of our enemies, but the silence of our friends.",
      "author": "Martin Luther King Jr."
    },
    {
      "quote":
          "Life is like a camera: focus on the good times, develop from the negatives, and if things don't work out, take another shot.",
      "author": "Unknown"
    },
    {
      "quote": "Be the change that you wish to see in the world.",
      "author": "Mahatma Gandhi"
    },
    {
      "quote":
          "A champion is defined not by their wins, but by how they can recover when they fall.",
      "author": "Serena Williams"
    },
    {
      "quote":
          "Our greatest glory is not in never falling, but in rising every time we fall.",
      "author": "Confucius"
    },
    {
      "quote": "The best way to predict the future is to create it.",
      "author": "Abraham Lincoln"
    },
    {
      "quote":
          "I am not a product of my circumstances. I am a product of my decisions.",
      "author": "Stephen Covey"
    },
    {
      "quote":
          "Do not wait for opportunity to knock, create a door for yourself and knock on it.",
      "author": "Unknown"
    },
    {
      "quote": "It always seems impossible until it's done.",
      "author": "Nelson Mandela"
    },
    {
      "quote":
          "Your time is limited, don't waste it living someone else's life.",
      "author": "Steve Jobs"
    },
    {
      "quote": "Don't let yesterday take up too much of today.",
      "author": "Will Rogers"
    },
    {
      "quote": "You miss 100% of the shots you don't take.",
      "author": "Wayne Gretzky"
    },
    {
      "quote":
          "We cannot solve our problems with the same thinking we used when we created them.",
      "author": "Albert Einstein"
    },
    {
      "quote": "If you want to lift yourself up, lift up someone else.",
      "author": "Booker T. Washington"
    },
    {
      "quote":
          "The only limit to our realization of tomorrow will be our doubts of today.",
      "author": "Franklin D. Roosevelt"
    },
    {
      "quote":
          "If you can't fly then run, if you can't run then walk, if you can't walk then crawl, but whatever you do you have to keep moving forward.",
      "author": "Unknown"
    }
  ];
  List<Map<String, String>> get getQuoteList => _quotes;

  void nextQuote() {
    if (quoteNumber < _quotes.length - 1) {
      quoteNumber++;
    }
  }

  void previousQuestion() {
    if (quoteNumber > _quotes.length - 1) {
      quoteNumber++;
    }
  }

  set setQuoteNumber(int num) {
    quoteNumber = num;
  }

  String? getQuote() {
    return _quotes[quoteNumber]['quote'];
  }

  getAllQuote() {
    _quotes.forEach((element) {
      element['quote'];
    });
    // return _quotes['quote'];
  }

  String? getAuthor() {
    return _quotes[quoteNumber]['author'];
  }

  bool isLastQuote() {
    return quoteNumber == _quotes.length - 1;
  }

  int getQuoteLength() {
    return _quotes.length;
  }
}






class QuotModel{
final quote, author, tags, id;
QuotModel( {required this.quote, required this.author, required this.tags, required this.id,} );
factory QuotModel.fromJson(Map<String, dynamic> data){
  return QuotModel(
      id : data['_id'],
      quote : data['content'],
    author: data['author'],
    tags: data['tags']
  );

}
factory QuotModel.quoteListfromJson(List<Map<String, dynamic>> data, int index){
  return QuotModel(
      quote : data[index]['content'],
    author: data[index]['author'],
    tags: data[index]['tags'], id: data[index]['id']
  );

}
}