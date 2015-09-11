//
//  HighScoresViewController.m
//  CardGame(Stanford)
//
//  Created by John Lu on 9/8/15.
//  Copyright (c) 2015 voyager. All rights reserved.
//

#import "HighScoresViewController.h"
#import "HighScoreRecord.h"
#import "PlayingCardMatchingGame.h"
#import "SetCardMatchingGame.h"

@interface HighScoresViewController ()

//@property (nonatomic, strong) NSArray *highScoresData;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *gamePlayedLabels;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *dateLabels;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *durationLabels;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *scoreLabels;


@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *sortButtons;


@end

@implementation HighScoresViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.sortKey = @"Score";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)updateUI
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *highScoreEntries = [defaults objectForKey:@"High Scores"]; // dictionaries
    
    // Sort High Scores
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:self.sortKey ascending:NO];
    NSArray *sortedHighScoreEntries = [highScoreEntries sortedArrayUsingDescriptors:@[sortDescriptor]];
    
    // Sort Outlet collection by tag number.
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"tag" ascending:YES];
    self.gamePlayedLabels = [self.gamePlayedLabels sortedArrayUsingDescriptors:@[sortDescriptor]];
    self.dateLabels = [self.dateLabels sortedArrayUsingDescriptors:@[sortDescriptor]];
    self.durationLabels = [self.durationLabels sortedArrayUsingDescriptors:@[sortDescriptor]];
    self.scoreLabels = [self.scoreLabels sortedArrayUsingDescriptors:@[sortDescriptor]];
    
    int i = 0;
    while (i < [self.gamePlayedLabels count]) {
        UILabel *gameLabel, *dateLabel, *durationLabel, *scoreLabel;
        gameLabel = self.gamePlayedLabels[i];
        dateLabel = self.dateLabels[i];
        durationLabel = self.durationLabels[i];
        scoreLabel = self.scoreLabels[i];
        
        if (i >= [sortedHighScoreEntries count]) {
            gameLabel.text = @"";
            dateLabel.text = @"";
            durationLabel.text = @"";
            scoreLabel.text = @"";
        } else {
            NSDictionary *highScoreEntry = sortedHighScoreEntries[i];
            gameLabel.text = [highScoreEntry objectForKey:@"Game"];
            
            NSDate *date = [highScoreEntry objectForKey:@"Date"];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.timeStyle = NSDateFormatterMediumStyle;
            dateFormatter.dateStyle = NSDateFormatterMediumStyle;
            NSString *dateString = [dateFormatter stringFromDate:date];
            
            dateLabel.text = dateString;
            
            NSNumber *duration = [highScoreEntry objectForKey:@"Duration"];
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            numberFormatter.maximumFractionDigits = 0;
            NSString *durationString = [numberFormatter stringFromNumber:duration];
            
            durationLabel.text = durationString;
            
            NSNumber *score = [highScoreEntry objectForKey:@"Score"];
            scoreLabel.text = [NSString stringWithFormat:@"%@", score];
        }
        i++;
    }
    for (UIButton *sortButton in self.sortButtons) {
        if ([sortButton.currentTitle isEqualToString:self.sortKey]) {
            sortButton.backgroundColor = [UIColor lightGrayColor];
        } else {
            sortButton.backgroundColor = nil;
        }
    }
}

- (NSString *)titleForLabelFor:(NSDictionary *)highScoreEntry
{
    NSString *retString = nil;
    NSString *gamePlayed = [highScoreEntry objectForKey:@"Game"];
    NSNumber *score = [highScoreEntry objectForKey:@"Score"];

    NSNumber *duration = [highScoreEntry objectForKey:@"Duration"];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.maximumFractionDigits = 0;
    NSString *durationString = [numberFormatter stringFromNumber:duration];
    
    NSDate *date = [highScoreEntry objectForKey:@"Date"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeStyle = NSDateFormatterMediumStyle;
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    if ([gamePlayed isEqualToString:NSStringFromClass([PlayingCardMatchingGame class])]) {
        retString = [NSString stringWithFormat:@"Game: Playing Cards  Date: %@  Duration: %@ sec  Score: %@ pts", dateString, durationString, score];
    } else if ([[highScoreEntry objectForKey:@"Game"] isEqualToString:NSStringFromClass([SetCardMatchingGame class])]) {
        retString = [NSString stringWithFormat:@"Game: Set  Date: %@  Duration: %@ sec  Score: %@ pts", dateString, durationString, score];
    }
    return retString;
}

- (void)setSortKey:(NSString *)sortKey
{
    if ([[self validSortKeys] containsObject:sortKey]) {
        _sortKey = sortKey;
    } else {
        _sortKey = @"Score";  // Default Sort Key
    }
}

- (IBAction)changeSortKey:(UIButton *)sender
{
    if ([sender.currentTitle isEqualToString:@"Score"]) {
        self.sortKey = @"Score";
    } else if ([sender.currentTitle isEqualToString:@"Date"]) {
        self.sortKey = @"Date";
    } else if ([sender.currentTitle isEqualToString:@"Duration"]) {
        self.sortKey = @"Duration";
    } else {
        self.sortKey = @"Game";
    }
    [self updateUI];
}

- (NSArray *)validSortKeys
{
    return @[@"Score", @"Date", @"Duration", @"Game"];
}

@end
