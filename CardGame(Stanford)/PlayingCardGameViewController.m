//
//  PlayingCardGameViewController.m
//  CardGame(Stanford)
//
//  Created by John Lu on 8/26/15.
//  Copyright (c) 2015 voyager. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCardMatchingGame.h"
#import "CardGameHistoryViewController.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"playingCardGameHistory"]) {
        if ([segue.destinationViewController isMemberOfClass:[CardGameHistoryViewController class]]) {
            CardGameHistoryViewController *historyController = (CardGameHistoryViewController *)segue.destinationViewController;
            historyController.gameLog = self.gameLog;
        }
    }
}

/* ------------ Abstract Method Implementations -------------- */
- (CardMatchingGame *)createGame
{
    return [[PlayingCardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
}

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
