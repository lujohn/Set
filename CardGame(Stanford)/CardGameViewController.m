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

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (nonatomic, readwrite) NSMutableArray *gameLog;

@end

@implementation CardGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateUI];
}

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [self createGame];
        [self prepareGame];
    }
    return _game;
}

- (NSMutableArray *)gameLog
{
    if (!_gameLog) {
        _gameLog = [[NSMutableArray alloc] init];
    }
    return _gameLog;
}


- (IBAction)touchCardButton:(UIButton *)sender
{
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
    [self.game updateCurrentChoices];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger index = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:index];
        [cardButton setAttributedTitle:[self attributedTitleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self setBackgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score:  %ld", (long)self.game.score];
    self.resultsLabel.attributedText = [self attributedResults];
}

- (IBAction)newGame:(UIButton *)sender
{
    self.game = nil;
    self.gameLog = nil;
    [self updateUI];
}

- (CardMatchingGame *)createGame
{
    return [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
}

- (NSAttributedString *)attributedResults
{
    NSInteger matchScore = self.game.scoreForCurrentMove;
    NSMutableAttributedString *retString = [[NSMutableAttributedString alloc] initWithString:@""];
    if (matchScore == 0) {
        retString = [[NSMutableAttributedString alloc] initWithString:@"Current Selection(s): "];
        [retString appendAttributedString:[self cardsToAttributedString:self.game.currentChoices]];
    } else if (matchScore < 0) {
        retString = [[NSMutableAttributedString alloc] initWithString:@"Sorry, "];
        [retString appendAttributedString:[self cardsToAttributedString:self.game.currentChoices]];
        [retString appendAttributedString:[[NSAttributedString alloc] initWithString:@" do not match!" attributes:@{}]];
    } else if (matchScore > 0) {
        retString = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
        [retString appendAttributedString:[self cardsToAttributedString:self.game.currentChoices]];
        [retString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" for %d points!", matchScore] attributes:@{}]];
    }
    [self.gameLog addObject:retString];
    return retString;
}

// ------- Sublclasses Override for Specialized Behavior --------
- (NSAttributedString *)attributedTitleForCard:(Card *)card
{
    if (card.isChosen) {
        return [[NSAttributedString alloc] initWithString:card.contents];
    } else {
        return [[NSAttributedString alloc] initWithString:@""];
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

- (void)prepareGame
{
    self.game.gameMode = 2;
}


// -------- Abstract Methods ----------
- (Deck *)createDeck
{
    return nil;
}

- (NSAttributedString *)cardsToAttributedString:(NSArray *)cards
{
    return nil;
}

@end
