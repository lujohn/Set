//
//  Deck.m
//  CardGame(Stanford)
//
//  Created by John Lu on 8/11/15.
//  Copyright (c) 2015 voyager. All rights reserved.
//

#import "Deck.h"

@interface Deck()

@property (nonatomic, strong) NSMutableArray *cards;

@end

@implementation Deck

- (NSMutableArray *)cards {
   if (!_cards) {
      _cards = [[NSMutableArray alloc] init];
   }
   return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop {
   if (atTop) {
      [self.cards insertObject:card atIndex:0];
   } else {
      [self.cards addObject:card];
   }
}

- (void)addCard:(Card *)card {
   [self addCard:card atTop:NO];
}

- (Card *)drawRandomCard {

   Card *randomCard = nil;

   if ([self.cards count]) {
      unsigned randomIndex = arc4random() % [self.cards count];
      randomCard = self.cards[randomIndex];
      [self.cards removeObjectAtIndex:randomIndex];
   }
   return randomCard;
}

@end
