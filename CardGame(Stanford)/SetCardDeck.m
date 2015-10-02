//
//  SetCardDeck.m
//  CardGame(Stanford)
//
//  Created by John Lu on 8/27/15.
//  Copyright (c) 2015 voyager. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"


@implementation SetCardDeck

- (instancetype)init
{
   self = [super init];
   if (self) {
      for (int i = 1; i <= 3; i++) {
         for (NSNumber *symbol in [SetCard validSymbols]) {
            for (NSNumber *shadeString in [SetCard validShades]) {
               for (NSNumber *color in [SetCard validColors]) {
                  SetCard *card = [[SetCard alloc] init];
                  card.symbol = symbol;
                  card.shade = shadeString;
                  card.color = color;
                  card.number = [NSNumber numberWithInteger:i];
                  [self addCard:card];
               }
            }
         }
      }
   }
   return self;
}

@end
