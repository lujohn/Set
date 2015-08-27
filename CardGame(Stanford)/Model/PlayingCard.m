//
//  PlayingCard.m
//  CardGame(Stanford)
//
//  Created by John Lu on 8/11/15.
//  Copyright (c) 2015 voyager. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

static const int THREE_OF_A_KIND_BONUS = 12;
static const int FLUSH_BONUS = 6;
- (int)match:(NSArray *)otherCards
{
   int score = 0, numMatchingRank = 1, numMatchingSuits = 1;
   PlayingCard *card1 = nil, *card2 = nil;

   for (int i = 0; i < [otherCards count]; i++) {
      if (self.rank == [[otherCards objectAtIndex:i] rank]) {
         score += 4;
         numMatchingRank++;
      } else if ([self.suit isEqualToString:[otherCards[i] suit]]) {
         score += 1;
         numMatchingSuits += 1;
      }
   }
   for (int i = 0; i < [otherCards count]; i++) {
      for (int j = i + 1; j < [otherCards count]; j++) {
         card1 = otherCards[i];
         card2 = otherCards[j];
         if (card1.rank == card2.rank) {
            score += 4;
            numMatchingRank++;
         } else if ([card1.suit isEqualToString:card2.suit]) {
            score += 1;
            numMatchingSuits++;
         }
      }
   }
   if (numMatchingRank == 3) {
      score += THREE_OF_A_KIND_BONUS;
   }
   if (numMatchingSuits == 3) {
      score += FLUSH_BONUS;
   }
   return score;
}

- (NSString *)contents {

   NSArray *rankStrings = [PlayingCard rankStrings];
   return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+ (NSArray *)validSuits {

   return  @[@"♣︎", @"♥︎", @"♠︎", @"♦︎"];

}

- (void)setSuit:(NSString *)suit {
   if ([[PlayingCard validSuits] containsObject:suit]){
      _suit = suit;
   }
}

- (NSString *)suit {
   return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings {

   return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",
            @"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

- (void)setRank:(NSUInteger)rank {
   if (rank <= [PlayingCard maxRank]) {
      _rank = rank;
   }
}

+ (NSUInteger)maxRank {
   return [[PlayingCard rankStrings] count] - 1;  // max: 13
}

@end
