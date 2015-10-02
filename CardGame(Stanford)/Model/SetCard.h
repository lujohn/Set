//
//  SetCard.h
//  CardGame(Stanford)
//
//  Created by John Lu on 8/27/15.
//  Copyright (c) 2015 voyager. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@interface SetCard : Card

@property (nonatomic, strong) NSNumber *symbol;
@property (nonatomic, strong) NSNumber *color;
@property (nonatomic) NSNumber *number;
@property (nonatomic, strong) NSNumber *shade;


+ (NSArray *)validSymbols;
+ (NSArray *)validColors;
+ (NSArray *)validShades;

@end
