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
#import "PlayingCardMatchingGame.h"

@interface CardGameViewController : UIViewController

- (Deck *)createDeck;  // abstract method
- (CardMatchingGame *)createGame; // abstract method

@end
