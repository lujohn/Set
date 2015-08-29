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
@property (nonatomic, strong) Deck *deck;
@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISwitch *threeCardModeSwitch;
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
      self.game.gameMode = [self determineGameMode];
   }
   return _game;
}

- (IBAction)changeGameLogDisplay:(UISlider *)sender
{
   NSArray *gameLog = self.game.gameLog;
   float sliderValue = sender.value;

   int logIndex = ([gameLog count] -1) * sliderValue;
   self.resultsLabel.text = gameLog[logIndex];

}

- (IBAction)touchCardButton:(UIButton *)sender
{
   if (self.threeCardModeSwitch.enabled) {
      self.threeCardModeSwitch.enabled = NO;
   }

   if (!self.logSlider.enabled) {
      self.logSlider.enabled = YES;
   }
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
   self.threeCardModeSwitch.enabled = YES;
   self.logSlider.enabled = NO;
   [self updateUI];
}

- (IBAction)switchGameMode:(UISwitch *)sender
{
   self.game.gameMode = [self determineGameMode];
}

- (int)determineGameMode
{
   if (self.threeCardModeSwitch.on) {
      return 3;
   } else {
      return 2;
   }
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
