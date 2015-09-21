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
#import "Grid.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIView *containerForCardViews;

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

- (NSMutableArray *)cardViews
{
    if (!_cardViews) {
        _cardViews = [self cardViewsForGame];
    }
    return _cardViews;
}

- (NSMutableArray *)cardViewsForGame
{
    NSMutableArray *cardViews = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.game.cardCount; i++) {
        UIView *cardView = [self createCardView];
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [cardView addGestureRecognizer:tapRecognizer];
        
        [cardViews addObject:cardView];
    }
    return cardViews;
}

- (IBAction)newGame:(UIButton *)sender
{
    self.game = nil;
    [self updateUI];
}

- (IBAction)save:(UIButton *)sender
{
    [self.game saveGameToPermanentStore];
}

- (IBAction)tap:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateRecognized) {
        UIView *chosenCardView = sender.view;
        NSUInteger indexOfChosenCardView = [self.cardViews indexOfObject:chosenCardView];
        [self.game chooseCardAtIndex:indexOfChosenCardView];
        [self updateUI];
    }
}

- (void)updateUI
{
    for (UIView *cardView in self.cardViews) {
        NSUInteger index = [self.cardViews indexOfObject:cardView];
        Card *card = [self.game cardAtIndex:index];
        [self setupView:cardView forCard:card];
    }
    [self removeAllMatchedCardsFromGame];
    [self layoutCardViews];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (void)removeAllMatchedCardsFromGame
{
    NSMutableArray *cardsToRemove = [[NSMutableArray alloc] init];
    NSMutableArray *cardViewsToRemove = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.game.cardCount; i++) {
        Card *card = [self.game cardAtIndex:i];
        if (card.isMatched) {
            [cardsToRemove addObject:card];
            UIView *cardView = [self.cardViews objectAtIndex:i];
            [cardViewsToRemove addObject:cardView];
            [cardView removeFromSuperview];
        }
    }
    [self.game removeCards:cardsToRemove];
    [self.cardViews removeObjectsInArray:cardViewsToRemove];
}

- (void)layoutCardViews
{
    Grid *grid = [[Grid alloc] init];
    grid.size =  self.containerForCardViews.bounds.size;
    grid.cellAspectRatio = 200.0/320.0;
    grid.minimumNumberOfCells = self.game.cardCount;
    
    NSUInteger indexOfCardView = 0;
    for (int i = 0; i < grid.rowCount; i++) {
        for (int j = 0; j < grid.columnCount; j++) {
            // This ensures that the # of views are no more than the # of cards in game.
            if (indexOfCardView >= self.game.cardCount) {
                break;
            }
            // Adjust frame
            CGRect frameForView = [grid frameOfCellAtRow:i inColumn:j];
            frameForView.origin.x += self.containerForCardViews.frame.origin.x;
            frameForView.origin.y += self.containerForCardViews.frame.origin.y;
            
            UIView *cardView = self.cardViews[indexOfCardView];
            cardView.frame = frameForView;
            
            if (![[self.view subviews] containsObject:cardView]) {
                [self.view addSubview:cardView];
            }
            indexOfCardView++;
        }
    }
}

/* ----------- Sublclasses Override for Specialized Behavior ---------- */
- (void)prepareGame
{
    self.game.gameMode = 2;
}


/* --------------------- Abstract Methods ------------------------- */
- (Deck *)createDeck
{
    return nil;
}

- (CardMatchingGame *)createGame
{
    return nil;
}

- (UIView *)createCardView
{
    return nil;
}

- (void)setupView:(UIView *)view forCard:(Card *)card
{
    return;
}


@end
