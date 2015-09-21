//
//  CardMatchingGame.m
//  CardGame(Stanford)
//
//  Created by John Lu on 8/12/15.
//  Copyright (c) 2015 voyager. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSInteger scoreForCurrentMove;
@property (nonatomic, strong) NSDate *gameStartTime;
@property (nonatomic, strong) Deck *deck;


@end

@implementation CardMatchingGame

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    if (self) {
        _deck = deck;
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
                _gameStartTime = [[NSDate alloc] init];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (NSMutableArray *)gameLog
{
    if (!_gameLog) {
        _gameLog = [[NSMutableArray alloc] init];
    }
    return _gameLog;
}

- (NSMutableArray *)currentChoices
{
    if (!_currentChoices) {
        _currentChoices = [[NSMutableArray alloc] init];
    }
    return _currentChoices;
}

- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (NSUInteger)cardCount
{
    return [self.cards count];
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (Card *)cardAtIndex:(NSUInteger)index
{
    Card *card = nil;
    if (index < [self.cards count]) {
        card = self.cards[index];
    }
    return card;
}

- (BOOL)addCardToGame
{
    Card *card = [self.deck drawRandomCard];
    if (card) {
        [self.cards addObject:card];
        return YES;
    } else {
        return NO;  // no more cards in deck;
    }
}

- (void)removeCardFromGame:(Card *)card
{
    [self.cards removeObject:card];
}

- (void)removeCards:(NSArray *)cards
{
    [self.cards removeObjectsInArray:cards];
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    NSArray *othercards = [[NSMutableArray alloc] init];
    int totalMatchScore = 0;
    if (!card.isMatched) {
        if(card.isChosen) {
            card.chosen = NO;
            [self.currentChoices removeObject:card];
        } else {
            othercards = [self allUnmatchedChosenCards];
            [self.currentChoices addObject:card];
            // Only calculate a score if number of other cards is (n - 1) for n-match game.
            if ([self.currentChoices count] == self.gameMode) {
                int matchScore = [card match:othercards];
                if (matchScore) {
                    totalMatchScore = matchScore * MATCH_BONUS;
                    card.matched = YES;
                    for (Card *othercard in othercards) {
                        othercard.matched = YES;
                    }
                    [self.currentChoices removeAllObjects];
                } else {
                    for (Card *othercard in othercards) {
                        othercard.chosen = NO;
                    };
                    totalMatchScore = -MISMATCH_PENALTY;
                    self.currentChoices = [NSMutableArray arrayWithObject:card];
                }
                self.score += totalMatchScore;
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
    self.scoreForCurrentMove = totalMatchScore;
    NSLog(@"Total match score == %d", totalMatchScore);
    NSLog(@"current choices: %@", self.currentChoices);
}

- (NSArray *)allUnmatchedChosenCards
{
    NSMutableArray *allChosenCards = [[NSMutableArray alloc] init];
    for (Card *othercard in self.cards) {
        if (!othercard.isMatched && othercard.isChosen) {
            [allChosenCards addObject:othercard];
        }
    }
    return allChosenCards;
}


- (void)saveGameToPermanentStore
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *nameOfGame = NSStringFromClass([self class]);
    NSDate *currentDateAndTime = [[NSDate alloc] init];
    NSTimeInterval durationOfGame = [currentDateAndTime timeIntervalSinceDate:self.gameStartTime];
    NSDictionary *newEntry = @{@"Game" : nameOfGame,
                               @"Score" : [NSNumber numberWithInteger:self.score],
                               @"Date" : currentDateAndTime,
                               @"Duration" : [NSNumber numberWithDouble:durationOfGame]};
    
    if (![defaults objectForKey:@"High Scores"]) {
        NSArray *highScores = @[newEntry];
        [defaults setValue:highScores forKey:@"High Scores"];
    } else {
        NSArray *highScores = [defaults objectForKey:@"High Scores"];
        NSMutableArray *newHighScores = [NSMutableArray arrayWithArray:highScores];
        [newHighScores addObject:newEntry];
        [defaults setValue:newHighScores forKey:@"High Scores"];
    }
    [defaults synchronize];
}

@end
