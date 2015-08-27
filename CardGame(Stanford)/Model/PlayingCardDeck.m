//
//  PlayingCardDeck.m
//  CardGame(Stanford)
//
//  Created by John Lu on 8/11/15.
//  Copyright (c) 2015 voyager. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (instancetype)init {

   self = [super init];
   if (self) {
      for (NSString *suit in [PlayingCard validSuits]) {
      for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
            PlayingCard *card = [[PlayingCard alloc] init];
            card.suit = suit;
            card.rank = rank;
            [self addCard:card];
         }
      }
   }
   return self;
}

@end
