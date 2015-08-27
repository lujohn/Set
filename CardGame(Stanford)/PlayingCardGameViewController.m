//
//  PlayingCardGameViewController.m
//  CardGame(Stanford)
//
//  Created by John Lu on 8/26/15.
//  Copyright (c) 2015 voyager. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck
{
   return [[PlayingCardDeck alloc] init];
}

@end
