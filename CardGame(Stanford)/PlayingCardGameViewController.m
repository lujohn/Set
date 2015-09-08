//
//  PlayingCardGameViewController.m
//  CardGame(Stanford)
//
//  Created by John Lu on 8/26/15.
//  Copyright (c) 2015 voyager. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController


/* ------------ Abstract Method Implementations -------------- */
- (Deck *)createDeck
{
   return [[PlayingCardDeck alloc] init];
}

- (NSAttributedString *)cardsToAttributedString:(NSArray *)cards
{
    NSMutableAttributedString *retString = [[NSMutableAttributedString alloc] initWithString:@""];
    
    for (Card *card in cards) {
        NSMutableAttributedString *cardContents = [[NSMutableAttributedString alloc] initWithString:card.contents];
        [cardContents setAttributes:@{} range:NSMakeRange(0, [card.contents length])];
        [retString appendAttributedString:cardContents];
    }
    return retString;
}

@end
