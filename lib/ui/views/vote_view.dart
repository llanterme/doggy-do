import 'package:doggy_do/core/models/dog_model.dart';
import 'package:doggy_do/core/viewmodels/vote_view_model.dart';
import 'package:doggy_do/ui/views/dog_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../../core/enums/viewstate.dart';
import 'base_view.dart';

class VoteView extends StatefulWidget {
  const VoteView({Key? key}) : super(key: key);

  @override
  State<VoteView> createState() => _VoteViewState();
}

class _VoteViewState extends State<VoteView> {
  final CardSwiperController controller = CardSwiperController();

  List<DogModel> currentDogList = [];
  String lastKey = "";

  @override
  Widget build(BuildContext context) {
    return BaseView<VoteViewModel>(
      onModelReady: (model) async {
        await model.getDogsForVoting(lastKey);
      },
      builder: (context, model, child) {
        if (model.state == ViewState.Busy) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          currentDogList = model.dogList;

          if (currentDogList.isEmpty) {
            return Center(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'No dogs to vote for.',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            );
          }

          final cards = model.dogList.map((dog) {
            return DogCard(dog: dog);
          }).toList();

          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Flexible(
                    child: CardSwiper(
                      controller: controller,
                      cardsCount: cards.length,
                      onSwipe: (int previousIndex, int? currentIndex,
                          CardSwiperDirection direction) {
                        debugPrint(
                          'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
                        );
                        return true;
                      },
                      isLoop: false,
                      onUndo: _onUndo,
                      onEnd: () {
                        lastKey = currentDogList.last.id!;
                        model.getDogsForVoting(lastKey);
                      },
                      numberOfCardsDisplayed: 1,
                      backCardOffset: const Offset(40, 40),
                      padding: const EdgeInsets.all(24.0),
                      cardBuilder: (
                        context,
                        index,
                        horizontalThresholdPercentage,
                        verticalThresholdPercentage,
                      ) =>
                          cards[index],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FloatingActionButton(
                          onPressed: () =>
                              controller.swipe(CardSwiperDirection.left),
                          child: const Icon(Icons.thumb_down_sharp),
                        ),
                        FloatingActionButton(
                          onPressed: () =>
                              controller.swipe(CardSwiperDirection.right),
                          child: const Icon(Icons.thumb_up_sharp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $currentIndex was undod from the ${direction.name}',
    );
    return true;
  }
}
