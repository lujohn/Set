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


/* -------- Abstract Methods (Subclasses MUST Override) ---------- */
- (Deck *)createDeck;
- (NSAttributedString *)cardsToAttributedString:(NSArray *)cards;

// Subclasses should override for specialized behavior
- (NSAttributedString *)attributedTitleForCard:(Card *)card;
- (UIImage *)setBackgroundImageForCard:(Card *)card;
- (void)prepareGame;

@end
