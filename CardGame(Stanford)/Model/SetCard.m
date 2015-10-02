//
//  SetCard.m
//  CardGame(Stanford)
//
//  Created by John Lu on 8/27/15.
//  Copyright (c) 2015 voyager. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

#define ERROR_NUMBER -1

- (int)match:(NSArray *)otherCards
{
    return [self calculateMatchScore:otherCards];
}

// Clean up!!
- (int)calculateMatchScore:(NSArray *)otherCards
{
    BOOL allNumbersSame = YES, allNumbersDifferent = YES,
    allColorsSame = YES, allColorsDifferent = YES,
    allShadesSame = YES, allShadesDifferent = YES,
    allSymbolsSame = YES, allSymbolsDifferent = YES;
    
    for (id card in otherCards) {
        if ([card isMemberOfClass:[SetCard class]]) {
            if ((!allSymbolsSame && !allSymbolsDifferent) ||
                (!allNumbersSame && !allNumbersDifferent) ||
                (!allColorsSame && !allColorsDifferent) ||
                 (!allShadesSame && !allShadesDifferent)) {
                return 0;
            }
            SetCard *setCard = (SetCard *)card;
            (self.number == setCard.number) ? (allNumbersDifferent = NO) : (allNumbersSame = NO);
            (self.color == setCard.color) ? (allColorsDifferent = NO) : (allColorsSame = NO);
            (self.shade == setCard.shade) ? (allShadesDifferent = NO) : (allShadesSame = NO);
            (self.symbol == setCard.symbol) ? (allSymbolsDifferent = NO) : (allSymbolsSame = NO);
        }
    }
    for (int i = 0; i < [otherCards count]; i++) {
        for (int j = i + 1; j < [otherCards count]; j++) {
            if ([otherCards[i] isMemberOfClass:[SetCard class]] && [otherCards[j] isMemberOfClass:[SetCard class]]) {
                SetCard *otherCard1 = (SetCard *)otherCards[i];
                SetCard *otherCard2 = (SetCard *)otherCards[j];
                (otherCard1.number == otherCard2.number) ? (allNumbersDifferent = NO) : (allNumbersSame = NO);
                (otherCard1.color == otherCard2.color) ? (allColorsDifferent = NO) : (allColorsSame = NO);
                (otherCard1.shade == otherCard2.shade) ? (allShadesDifferent = NO) : (allShadesSame = NO);
                (otherCard1.symbol == otherCard2.symbol) ? (allSymbolsDifferent = NO) : (allSymbolsSame = NO);
            }
            if ((!allSymbolsSame && !allSymbolsDifferent) ||
                (!allNumbersSame && !allNumbersDifferent) ||
                (!allColorsSame && !allColorsDifferent) ||
                (!allShadesSame && !allShadesDifferent)) {
                return 0;
            }
        }
    }
    return 5;
}

@synthesize symbol = _symbol;
@synthesize color = _color;
@synthesize shade = _shade;

- (void)setSymbol:(NSNumber *)symbol
{
   if ([[SetCard validSymbols] containsObject:symbol]) {
      _symbol = symbol;
   }
}

- (void)setColor:(NSNumber *)color
{
   if ([[SetCard validColors] containsObject:color]) {
      _color = color;
   }
}

- (void)setShade:(NSNumber *)shade
{
   if ([[SetCard validShades] containsObject:shade]) {
      _shade = shade;
   }
}

- (NSNumber *)symbol
{
   if (_symbol) {
      return _symbol;
   }
    return [NSNumber numberWithInteger:ERROR_NUMBER];
}

- (NSNumber *)shade
{
   if (_shade) {
      return _shade;
   }
    return [NSNumber numberWithInteger:ERROR_NUMBER];
}

- (NSNumber *)color
{
   if (_color) {
      return _color;
   }
    return [NSNumber numberWithInteger:ERROR_NUMBER];
}

+ (NSArray *)validSymbols
{
   return @[@1, @2, @3];
}

+ (NSArray *)validColors
{
   return @[@1, @2, @3];
}

+ (NSArray *)validShades
{
   return @[@1, @2, @3];
}

- (NSString *)description
{
   return [NSString stringWithFormat:@"Number: %@, Symbol: %@, Shade: %@, Color: %@", self.number, self.symbol, self.shade, self.color];
}

@end
