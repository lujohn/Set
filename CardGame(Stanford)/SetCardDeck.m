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
         for (NSString *symbol in [SetCard validSymbols]) {
            for (NSString *shadeString in [SetCard validShadeStrings]) {
               for (NSString *color in [SetCard validColors]) {
                  SetCard *card = [[SetCard alloc] init];
                  card.symbol = symbol;
                  card.shadeString = shadeString;
                  card.color = color;
                  card.number = i;
                  [self addCard:card];
               }
            }
         }
      }
   }
   return self;
}

@end
