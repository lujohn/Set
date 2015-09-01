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

@property (nonatomic, strong) NSString *symbol;
@property (nonatomic, strong) NSString *color;
@property (nonatomic) NSUInteger number;
@property (nonatomic, strong) NSString *shadeString;


+ (NSArray *)validSymbols;
+ (NSArray *)validColors;
+ (NSArray *)validShadeStrings;

- (NSString *)symbolStringForCard;

@end
