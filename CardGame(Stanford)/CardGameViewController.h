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

- (Deck *)createDeck;  // abstract method

// Override for specialized games
- (NSAttributedString *)setAttributedTitleForCard:(Card *)card;
- (UIImage *)setBackgroundImageForCard:(Card *)card;

@end
