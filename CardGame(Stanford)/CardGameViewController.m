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
@property (nonatomic) BOOL shouldRelayoutViews;

@end


@implementation CardGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.containerForCardViews.backgroundColor = [UIColor clearColor];
    [self setUpCardViews];
    [self layoutCardViews];
}

- (void)setUpCardViews
{
    for (UIView *cardView in self.cardViews) {
        NSUInteger cardIndex = [self.cardViews indexOfObject:cardView];
        Card *card = [self.game cardAtIndex:cardIndex];
        [self setupView:cardView forCard:card];
        if (![self.view.subviews containsObject:cardView]) {
            [self.view addSubview:cardView];
        }
    }
}

- (IBAction)tap:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateRecognized) {
        UIView *chosenCardView = sender.view;
        NSUInteger indexOfChosenCardView = [self.cardViews indexOfObject:chosenCardView];
        [self.game chooseCardAtIndex:indexOfChosenCardView];
        self.shouldRelayoutViews = (self.game.scoreForCurrentMove > 0); // Match has occured...
        [self updateUI];
    }
}

- (IBAction)addCard:(UIButton *)sender
{
    if (![self.game addCardToGame]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oh No!" message:@"No more cards remaining!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [alert show];
    } else {
        [self.cardViews addObject:[self createCardViewWithTapGestureRecognizer]];
        self.shouldRelayoutViews = YES;
        [self updateUI];
    }
}

- (void)updateUI
{
    [self setUpCardViews];
    if (self.shouldRelayoutViews) {
        [self setMatchedViewsHidden];
        [self layoutCardViews];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (void)setMatchedViewsHidden
{
    for (UIView *view in self.cardViews) {
        if ([[self.game cardAtIndex:[self.cardViews indexOfObject:view]] isMatched]) {
            view.hidden = YES;
        }
    }
}

- (void)layoutCardViews
{
    Grid *grid = [[Grid alloc] init];
    grid.size =  self.containerForCardViews.bounds.size;
    grid.cellAspectRatio = 200.0/320.0;
    grid.minimumNumberOfCells = [self.cardViews count];
    
    NSUInteger indexOfCardView = 0;
    for (int i = 0; i < grid.rowCount; i++) {
        for (int j = 0; j < grid.columnCount; j++) {
            // This ensures that the # of views are no more than the # of cards in game.
            if (indexOfCardView >= [self.cardViews count]) {
                break;
            }
            
            UIView *view = [self.cardViews objectAtIndex:indexOfCardView];
            while (view.isHidden) {
                indexOfCardView++;
                view = self.cardViews[indexOfCardView];
            }
            CGRect frameForView = [grid frameOfCellAtRow:i inColumn:j];
            frameForView.origin.x += self.containerForCardViews.frame.origin.x;
            frameForView.origin.y += self.containerForCardViews.frame.origin.y;
            view.frame = frameForView;
            
            indexOfCardView++;
        }
    }
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
        UIView *cardView = [self createCardViewWithTapGestureRecognizer];
        [cardViews addObject:cardView];
    }
    return cardViews;
}

- (UIView *)createCardViewWithTapGestureRecognizer
{
    UIView *cardView = [self createCardView];
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [cardView addGestureRecognizer:tapRecognizer];
    
    return cardView;
}

// Other stuff

- (IBAction)newGame:(UIButton *)sender
{
    self.game = nil;
    [self updateUI];
}

- (IBAction)save:(UIButton *)sender
{
    [self.game saveGameToPermanentStore];
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
