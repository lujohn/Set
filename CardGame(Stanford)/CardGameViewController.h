//
//  CardGameViewController.h
//  CardGame(Stanford)
//
//  Created by John Lu on 8/9/15.
//  Copyright (c) 2015 voyager. All rights reserved.
//
//  Abstract class. Subclasses must implement required method as indicated.

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController

@property (nonatomic, strong) CardMatchingGame *game;
@property (nonatomic, strong) NSMutableArray *cardViews;

/* -------- Abstract Methods (Subclasses MUST Override) ---------- */
- (Deck *)createDeck;
- (CardMatchingGame *)createGame;
- (UIView *)createCardView;

// Subclasses should override for specialized behavior
- (void)prepareGame;
- (void)setupView:(UIView *)view forCard:(Card *)card;

@end
