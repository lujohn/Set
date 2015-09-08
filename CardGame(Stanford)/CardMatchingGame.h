//
//  CardMatchingGame.h
//  CardGame(Stanford)
//
//  Created by John Lu on 8/12/15.
//  Copyright (c) 2015 voyager. All rights reserved.
//
//  Abstract Class! Implement required methods as indicated below...

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSInteger scoreForCurrentMove;
@property (nonatomic) int gameMode;
@property (nonatomic, strong) NSMutableArray *gameLog;
@property (nonatomic, strong) NSMutableArray *currentChoices;

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;
- (Card *)cardAtIndex:(NSUInteger)index;
- (void)updateCurrentChoices;

// Override for Specialized games
- (void)chooseCardAtIndex:(NSUInteger)index;

@end
