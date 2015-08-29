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

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

-(Deck *)createDeck
{
   return [[SetCardDeck alloc] init];
}


@end
