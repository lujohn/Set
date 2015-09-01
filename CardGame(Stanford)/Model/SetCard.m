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
   return 0;
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
