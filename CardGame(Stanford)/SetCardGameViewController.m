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
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *setCardButtons;

@end

@implementation SetCardGameViewController

- (void)viewDidLoad
{
   [super viewDidLoad];
   self.cardButtons = self.setCardButtons;
   self.game.gameMode = 3;
   [self updateUI];
}

- (Deck *)createDeck
{
   Deck *setDeck = [[SetCardDeck alloc] init];
   return setDeck;
}

- (void)updateUI
{
   for (UIButton *cardButton in self.cardButtons) {
      NSUInteger index = [self.cardButtons indexOfObject:cardButton];
      Card *card = [self.game cardAtIndex:index];
      [cardButton setAttributedTitle:[self setAttributedTitleForCard:card] forState:UIControlStateNormal];
      [cardButton setBackgroundImage:[self setBackgroundImageForCard:card] forState:UIControlStateNormal];
      cardButton.enabled = !card.isMatched;
   }
}

- (NSAttributedString *)setAttributedTitleForCard:(Card *)card
{
   SetCard *setCard = (SetCard *)card;
   NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:[setCard symbolStringForCard]];
   NSRange range = NSMakeRange(0, [[setCard symbolStringForCard] length]);
   NSLog(@"Length %d", [[setCard symbolStringForCard] length]);

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

- (NSString *)setTitleForCard:(Card *)card
{
   SetCard *setCard = (SetCard *)card;
   NSString *retString = [NSString stringWithFormat:@"%@", setCard.symbol];
   return retString;
}

- (UIImage *)setBackgroundImageForCard:(Card *)card
{
   if (card.isChosen) {
      return [UIImage imageNamed:@"setCardChosen"];
   } else {
      return [UIImage imageNamed:@"cardfront"];
   }
}

@end
