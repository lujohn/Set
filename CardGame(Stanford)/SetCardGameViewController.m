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

@implementation SetCardGameViewController

- (void)viewDidLoad
{
   [super viewDidLoad];
   self.game.gameMode = 3;
}

- (Deck *)createDeck
{
   Deck *setDeck = [[SetCardDeck alloc] init];
   return setDeck;
}

- (NSAttributedString *)setAttributedTitleForCard:(Card *)card
{
   SetCard *setCard = (SetCard *)card;
   NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:[setCard symbolStringForCard]];
   NSRange range = NSMakeRange(0, [[setCard symbolStringForCard] length]);

   NSDictionary *attributes = nil;
   NSString *cardColor = setCard.color;
   NSString *shade = setCard.shadeString;

   if ([shade isEqualToString:@"Striped"]) {
      attributes = @{NSForegroundColorAttributeName : [self colorFromColorString:cardColor withAlpha:0.3],
                     NSStrokeWidthAttributeName : @-5,
                     NSStrokeColorAttributeName : [self colorFromColorString:cardColor]};
   } else if ([shade isEqualToString:@"Open"]) {
      attributes = @{NSForegroundColorAttributeName : [UIColor clearColor],
                     NSStrokeColorAttributeName: [self colorFromColorString:cardColor],
                     NSStrokeWidthAttributeName: @-8};
   } else {
      attributes = @{NSForegroundColorAttributeName : [self colorFromColorString:cardColor]};
   }

   if (attributes) {
      [title addAttributes:attributes range:range];
   }
   return title;
}

- (UIColor *)colorFromColorString:(NSString *)color
{
   return [self colorFromColorString:color withAlpha:1.0];
}

- (UIColor *)colorFromColorString:(NSString *)color withAlpha:(CGFloat)alpha
{
   if ([color isEqualToString:@"Red"]) {
      return [UIColor colorWithRed:255 green:0 blue:0 alpha:alpha];
   } else if ([color isEqualToString:@"Green"]) {
      return [UIColor colorWithRed:0 green:255 blue:0 alpha:alpha];
   } else if ([color isEqualToString:@"Purple"]) {
      return [UIColor colorWithRed:255 green:0 blue:255 alpha:alpha];
   } else {
      return [UIColor blackColor];  // default color
   }
}

- (UIImage *)setBackgroundImageForCard:(Card *)card
{
   if (card.isChosen) {
      return [UIImage imageNamed:@"setCardChosen"];
   } else {
      return [UIImage imageNamed:@"cardfront"];
   }
}

- (void)dealloc
{
    NSLog(@"Set Card Game Deallocated!");
}

@end
