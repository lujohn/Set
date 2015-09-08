//
//  CardMatchingGame.m
//  CardGame(Stanford)
//
//  Created by John Lu on 8/12/15.
//  Copyright (c) 2015 voyager. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSInteger scoreForCurrentMove;


@end

@implementation CardMatchingGame

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
   self = [super init];
   if (self) {
      for (int i = 0; i < count; i++) {
         Card *card = [deck drawRandomCard];
         if (card) {
            [self.cards addObject:card];
         } else {
            self = nil;
            break;
         }
      }
   }
   return self;
}

- (NSMutableArray *)gameLog
{
   if (!_gameLog) {
      _gameLog = [[NSMutableArray alloc] init];
   }
   return _gameLog;
}

- (NSMutableArray *)currentChoices
{
   if (!_currentChoices) {
      _currentChoices = [[NSMutableArray alloc] init];
   }
    //[self updateCurrentChoices];
   return _currentChoices;
}

- (NSMutableArray *)cards
{
   if (!_cards) {
      _cards = [[NSMutableArray alloc] init];
   }
   return _cards;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
   Card *card = [self cardAtIndex:index];
   NSArray *othercards = [[NSMutableArray alloc] init];
   int totalMatchScore = 0;
   if (!card.isMatched) {
      if(card.isChosen) {
         card.chosen = NO;
         [self.currentChoices removeObject:card];
      } else {
         othercards = [self allUnmatchedChosenCards];
         // Only calculate a score if number of other cards is (n - 1) for n-match game.
         if ([self.currentChoices count] == self.gameMode - 1) {
            int matchScore = [card match:self.currentChoices];
            if (matchScore) {
               totalMatchScore = matchScore * MATCH_BONUS;
               self.score += matchScore * MATCH_BONUS;
               card.matched = YES;
               for (Card *othercard in self.currentChoices) {
                  othercard.matched = YES;
               }
            } else {
               for (Card *othercard in self.currentChoices) {
                  othercard.chosen = NO;
               }
               self.score -= MISMATCH_PENALTY;
               totalMatchScore = -MISMATCH_PENALTY;
            }
         }
         self.score -= COST_TO_CHOOSE;
         card.chosen = YES;
         [self.currentChoices addObject:card];
      }
   }
    self.scoreForCurrentMove = totalMatchScore;
}

- (NSArray *)allUnmatchedChosenCards
{
   NSMutableArray *allChosenCards = [[NSMutableArray alloc] init];
   for (Card *othercard in self.cards) {
      if (!othercard.isMatched && othercard.isChosen) {
         [allChosenCards addObject:othercard];
      }
   }
   return allChosenCards;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
   Card *card = nil;
   if (index < [self.cards count]) {
      card = self.cards[index];
   }
   return card;
}

- (void)updateCurrentChoices
{
    if (self.scoreForCurrentMove < 0) {
        self.currentChoices = [NSMutableArray arrayWithObject:[self.currentChoices lastObject]];
    } else if (self.scoreForCurrentMove > 0) {
        [self.currentChoices removeAllObjects];
    }
}

@end
