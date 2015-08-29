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
static NSString *DEFAULT_shade_STRING = @"?";

- (int)match:(NSArray *)otherCards // OVERRIDE!!!!
{
   return 0;
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

- (void)setColor:(UIColor *)color
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
   return DEFAULT_shade_STRING;
}

- (UIColor *)color
{
   if (_color) {
      return _color;
   }
   return [UIColor blackColor];
}

+ (NSArray *)validSymbols
{
   return @[@"▲", @"◼︎", @"●"];
}

+ (NSArray *)validColors
{
   return @[[UIColor redColor], [UIColor greenColor], [UIColor purpleColor]];
}

+ (NSArray *)validShadeStrings
{
   return @[@"Solid", @"Striped", @"Open"];
}

@end
