//
//  CardGameViewController.m
//  CardGame(Stanford)
//
//  Created by John Lu on 8/9/15.
//  Copyright (c) 2015 voyager. All rights reserved.
//

#import "CardGameViewController.h"
#import "Card.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (weak, nonatomic) IBOutlet UISlider *logSlider;

@end

@implementation CardGameViewController

- (void)viewDidLoad
{
   [super viewDidLoad];
   self.logSlider.enabled = NO;
}

- (CardMatchingGame *)game
{
   if (!_game) {
      _game = [self createGame];
      self.game.gameMode = 2;
   }
   return _game;
}

- (IBAction)changeGameLogDisplay:(UISlider *)sender
{
   NSArray *gameLog = self.game.gameLog;
   float sliderValue = sender.value;
   int logIndex = ([gameLog count] - 1) * sliderValue;
   self.resultsLabel.text = gameLog[logIndex];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
   NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
   [self.game chooseCardAtIndex:chosenButtonIndex];
   [self updateUI];
}

- (void)updateUI
{
   for (UIButton *cardButton in self.cardButtons) {
      NSUInteger index = [self.cardButtons indexOfObject:cardButton];
      Card *card = [self.game cardAtIndex:index];
      [cardButton setTitle:[self setTitleForCard:card] forState:UIControlStateNormal];
      [cardButton setBackgroundImage:[self setBackgroundImageForCard:card] forState:UIControlStateNormal];
      cardButton.enabled = !card.isMatched;
      self.scoreLabel.text = [NSString stringWithFormat:@"Score:  %ld", (long)self.game.score];
      self.resultsLabel.text = self.game.currentResult;
   }
}

- (IBAction)newGame:(UIButton *)sender
{
   self.game = nil;
   self.logSlider.enabled = NO;
   [self updateUI];
}

- (CardMatchingGame *)createGame
{
   return [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
}

- (Deck *)createDeck  // abstract method
{
   return nil;
}

- (NSString *)setTitleForCard:(Card *)card
{
   if (card.isChosen) {
      return card.contents;
   } else {
      return @"";
   }
}

- (UIImage *)setBackgroundImageForCard:(Card *)card
{
   if (card.isChosen) {
      return [UIImage imageNamed:@"cardfront"];
   } else {
      return [UIImage imageNamed:@"cardback"];
   }
}

@end
