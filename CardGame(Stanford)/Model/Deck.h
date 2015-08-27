//
//  Deck.h
//  CardGame(Stanford)
//
//  Created by John Lu on 8/11/15.
//  Copyright (c) 2015 voyager. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject


- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
