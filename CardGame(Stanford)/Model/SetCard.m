//
//  SetCard.m
//  CardGame(Stanford)
//
//  Created by John Lu on 8/27/15.
//  Copyright (c) 2015 voyager. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

static NSString *DEFAULT_SYMBOL = @"?";
static NSString *DEFAULT_SHADE_STRING = @"?";
static NSString *DEFAULT_COLOR = @"?";

- (int)match:(NSArray *)otherCards // OVERRIDE!!!!
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
            ([self.color isEqualToString:setCard.color]) ? (allColorsDifferent = NO) : (allColorsSame = NO);
            ([self.shadeString isEqualToString:setCard.shadeString]) ? (allShadesDifferent = NO) : (allShadesSame = NO);
            ([self.symbol isEqualToString:setCard.symbol]) ? (allSymbolsDifferent = NO) : (allSymbolsSame = NO);
        }
    }
    for (int i = 0; i < [otherCards count]; i++) {
        for (int j = i + 1; j < [otherCards count]; j++) {
            if ((!allSymbolsSame && !allSymbolsDifferent) ||
                (!allNumbersSame && !allNumbersDifferent) ||
                (!allColorsSame && !allColorsDifferent) ||
                (!allShadesSame && !allShadesDifferent)) {
                return 0;
            }
            if ([otherCards[i] isMemberOfClass:[SetCard class]] && [otherCards[j] isMemberOfClass:[SetCard class]]) {
                SetCard *otherCard1 = (SetCard *)otherCards[i];
                SetCard *otherCard2 = (SetCard *)otherCards[j];
                (otherCard1.number == otherCard2.number) ? (allNumbersDifferent = NO) : (allNumbersSame = NO);
                ([otherCard1.color isEqualToString:otherCard2.color]) ? (allColorsDifferent = NO) : (allColorsSame = NO);
                ([otherCard1.shadeString isEqualToString:otherCard2.shadeString]) ? (allShadesDifferent = NO) : (allShadesSame = NO);
                ([otherCard1.symbol isEqualToString:otherCard2.symbol]) ? (allSymbolsDifferent = NO) : (allSymbolsSame = NO);
            }
        }
    }
    return 20;
}

- (NSString *)symbolStringForCard
{
   NSString *symbolString = @"";
   for (int i = 0; i < self.number; i++) {
      symbolString = [symbolString stringByAppendingString:self.symbol];
   }
   return symbolString;
}

@synthesize symbol = _symbol;
@synthesize color = _color;
@synthesize shadeString = _shadeString;

- (void)setSymbol:(NSString *)symbol
{
   if ([[SetCard validSymbols] containsObject:symbol]) {
      _symbol = symbol;
   }
}

- (void)setColor:(NSString *)color
{
   if ([[SetCard validColors] containsObject:color]) {
      _color = color;
   }
}

- (void)setShadeString:(NSString *)shade
{
   if ([[SetCard validShadeStrings] containsObject:shade]) {
      _shadeString = shade;
   }
}

- (NSString *)symbol
{
   if (_symbol) {
      return _symbol;
   }
   return DEFAULT_SYMBOL;
}

- (NSString *)shade
{
   if (_shadeString) {
      return _shadeString;
   }
   return DEFAULT_SHADE_STRING;
}

- (NSString *)color
{
   if (_color) {
      return _color;
   }
   return @"?";
}

+ (NSArray *)validSymbols
{
   return @[@"▲", @"◼︎", @"●"];
}

+ (NSArray *)validColors
{
   return @[@"Red", @"Green", @"Purple"];
}

+ (NSArray *)validShadeStrings
{
   return @[@"Solid", @"Striped", @"Open"];
}

- (NSString *)description
{
   return [NSString stringWithFormat:@"Number: %d, Symbol: %@, Shade: %@, Color: %@", self.number, self.symbol, self.shadeString, self.color];
}

@end
