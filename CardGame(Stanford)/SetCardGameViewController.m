//
//  SetCardGameViewController.m
//  CardGame(Stanford)
//
//  Created by John Lu on 8/27/15.
//  Copyright (c) 2015 voyager. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "SetCardMatchingGame.h"
#import "SetCardView.h"

@implementation SetCardGameViewController

#define DEFAULT_NUM_CARDS 12
- (void)viewDidLoad
{
    [super viewDidLoad];
}

/* ------------ Abstract Method Implementations ------------- */
- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];;
}

- (CardMatchingGame *)createGame
{
    return [[SetCardMatchingGame alloc] initWithCardCount:DEFAULT_NUM_CARDS usingDeck:[self createDeck]];
}

- (UIView *)createCardView
{
    return [[SetCardView alloc] init];
}

- (void)setupView:(UIView *)view forCard:(Card *)card;
{
    if ([card isMemberOfClass:[SetCard class]] && [view isMemberOfClass:[SetCardView class]]) {
        SetCardView *setCardView = (SetCardView *)view;
        SetCard *setCard = (SetCard *)card;
        setCardView.number = setCard.number;
        setCardView.symbol = setCard.symbol;
        setCardView.shade = setCard.shade;
        setCardView.color = setCard.color;
        if (setCard.isChosen) {
            setCardView.alpha = 0.8;
        } else {
            setCardView.alpha = 1.0;
        }
    }
}

/* -------------- Method Overrides -------------- */
- (void)prepareGame
{
    self.game.gameMode = 3;
}

/* ---------- Helper Methods ----------- */


@end
