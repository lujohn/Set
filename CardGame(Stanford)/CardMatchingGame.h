//
//  CardMatchingGame.h
//  CardGame(Stanford)
//
//  Created by John Lu on 8/12/15.
//  Copyright (c) 2015 voyager. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) int gameMode;
@property (nonatomic, strong) NSString *currentResult;
@property (nonatomic, strong) NSMutableArray *gameLog;

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@end
