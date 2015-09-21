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
#import "PlayingCardView.h"
#import "PlayingCard.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

#define DEFAULT_NUM_CARDS 16

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

/* ------------ Abstract Method Implementations -------------- */
- (CardMatchingGame *)createGame
{
    return [[PlayingCardMatchingGame alloc] initWithCardCount:DEFAULT_NUM_CARDS usingDeck:[self createDeck]];
}

- (Deck *)createDeck
{
   return [[PlayingCardDeck alloc] init];
}

- (UIView *)createCardView
{
    return [[PlayingCardView alloc] init];
}

- (void)setupView:(UIView *)view forCard:(Card *)card
{
    if ([view isMemberOfClass:[PlayingCardView class]] && [card isMemberOfClass:[PlayingCard class]]) {
        PlayingCardView *playingCardView = (PlayingCardView *)view;
        PlayingCard *playingCard = (PlayingCard *)card;
        playingCardView.faceUp = card.isChosen;
        if (playingCardView.faceUp) {
            playingCardView.rank = playingCard.rank;
            playingCardView.suit = playingCard.suit;
        }
    }
}



@end
