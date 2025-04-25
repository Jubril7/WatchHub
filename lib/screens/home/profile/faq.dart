import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';

class Faq extends StatefulWidget {
  const Faq({super.key});

  @override
  State<Faq> createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 249, 246),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text(
          "FAQ",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 22, 69, 169),
      ),
      body: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Accordion(
                  headerBorderColor: const Color.fromARGB(255, 22, 69, 169),
                  contentBorderColor: const Color.fromARGB(255, 22, 69, 169),
                  headerBackgroundColor: const Color.fromARGB(255, 22, 69, 169),
                  headerPadding: const EdgeInsets.all(20),
                  children: <AccordionSection>[
                    AccordionSection(
                        header: const Text(
                          "How do I make an order?",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        content: const Text(
                          "To make an order, head over to a watch page you will like to order and simply add it to your cart, when are satisfied with the item you added go to the cart page and checkout on your order and it will be delivered to you!",
                          style: TextStyle(fontSize: 20),
                        )),
                    AccordionSection(
                        header: const Text(
                          "Can i change my shipping address?",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        content: const Text(
                          'Yes you can! to change your shipping address go to the your profile page and click on "edit profile", you will be able to update your shipping address there.',
                          style: TextStyle(fontSize: 20),
                        )),
                    AccordionSection(
                        header: const Text(
                          "How long will it take for my order to arrive?",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        content: const Text(
                          "Your order will normally arrive within 3-5 business days as long as there is no delay which we will be sure to notify you about.",
                          style: TextStyle(fontSize: 20),
                        )),
                    AccordionSection(
                        header: const Text(
                          "How do I make enquiries/complaints?",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        content: const Text(
                          'You can make enquiries by going over to the user page and clicking on "contact us" and we will be sure to reply to you as soon as possible.',
                          style: TextStyle(fontSize: 20),
                        )),
                    AccordionSection(
                        header: const Text(
                          "Can I get a refund on an watch?",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        content: const Text(
                          "Of course you can! If you are not satisfied with your order we will be happy to refund you back your money as long as it meets our refunds/return policy.",
                          style: TextStyle(fontSize: 20),
                        ))
                  ])
            ],
          ),
        ),
      ),
    );
  }
}
