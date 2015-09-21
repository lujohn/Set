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
#import "SetCardMatchingGame.h"

@implementation SetCardGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

/* ------------ Abstract Method Implementations ------------- */
- (NSAttributedString *)cardsToAttributedString:(NSArray *)cards
{
    NSMutableAttributedString *retString = [[NSMutableAttributedString alloc] initWithString:@""];
    for (SetCard *card in cards) {
        [retString appendAttributedString:[self attributedTitleForCard:card]];
    }
    return retString;
}

- (CardMatchingGame *)createGame
{
    return [[SetCardMatchingGame alloc] initWithCardCount:[self.cardViews count] usingDeck:[self createDeck]];
}

- (Deck *)createDeck
{
    Deck *setDeck = [[SetCardDeck alloc] init];
    return setDeck;
}

/* -------------- Method Overrides -------------- */
- (NSAttributedString *)attributedTitleForCard:(Card *)card
{
    SetCard *setCard = (SetCard *)card;
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:[setCard symbolStringForCard]];
    NSRange range = NSMakeRange(0, [[setCard symbolStringForCard] length]);
    
    NSDictionary *attributes = [self attributesForCard:setCard];
    if (attributes) {
        [title addAttributes:attributes range:range];
    }
    return title;
}

- (UIImage *)setBackgroundImageForCard:(Card *)card
{
    if (card.isChosen) {
        return [UIImage imageNamed:@"setCardChosen"];
    } else {
        return [UIImage imageNamed:@"cardfront"];
    }
}

- (void)prepareGame
{
    self.game.gameMode = 3;
}

/* ---------- Helper Methods ----------- */
- (NSDictionary *)attributesForCard:(SetCard *)card
{
    NSDictionary *attributes = nil;
    if ([card.shadeString isEqualToString:@"Striped"]) {
        attributes = @{NSForegroundColorAttributeName : [self colorFromColorString:card.color withAlpha:0.3],
                       NSStrokeWidthAttributeName : @-5,
                       NSStrokeColorAttributeName : [self colorFromColorString:card.color]};
    } else if ([card.shadeString isEqualToString:@"Open"]) {
        attributes = @{NSForegroundColorAttributeName : [UIColor clearColor],
                       NSStrokeColorAttributeName: [self colorFromColorString:card.color],
                       NSStrokeWidthAttributeName: @-8};
    } else {
        attributes = @{NSForegroundColorAttributeName : [self colorFromColorString:card.color]};
    }
    return attributes;
}

- (UIColor *)colorFromColorString:(NSString *)color
{
    return [self colorFromColorString:color withAlpha:1.0];
}

- (UIColor *)colorFromColorString:(NSString *)color withAlpha:(CGFloat)alpha
{
    if ([color isEqualToString:@"Red"]) {
        return [UIColor colorWithRed:1 green:0 blue:0 alpha:alpha];
    } else if ([color isEqualToString:@"Green"]) {
        return [UIColor colorWithRed:0 green:1 blue:0 alpha:alpha];
    } else if ([color isEqualToString:@"Purple"]) {
        return [UIColor colorWithRed:1 green:0 blue:1 alpha:alpha];
    } else {
        return [UIColor blackColor];  // default color
    }
}

@end
