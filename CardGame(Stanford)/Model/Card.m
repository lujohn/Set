//
//  Card.m
//  CardGame(Stanford)
//
//  Created by John Lu on 8/11/15.
//  Copyright (c) 2015 voyager. All rights reserved.
//

#import "Card.h"

@implementation Card


- (int)match:(NSArray *)otherCards {

   int score = 0;

   for (Card *card in otherCards) {
      if ([card.contents isEqualToString:self.contents]) {
         score = 1;
      }
   }


   return score;
}

@end
