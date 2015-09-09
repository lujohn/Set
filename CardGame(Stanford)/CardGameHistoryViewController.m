//
//  CardGameHistoryViewController.m
//  CardGame(Stanford)
//
//  Created by John Lu on 9/8/15.
//  Copyright (c) 2015 voyager. All rights reserved.
//

#import "CardGameHistoryViewController.h"


@interface CardGameHistoryViewController ()

@end

@implementation CardGameHistoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.historyTextField.attributedText = [self gameLogtoAttributedString:self.gameLog];
}

- (NSAttributedString *)gameLogtoAttributedString:(NSArray *)gameLog
{
    NSMutableAttributedString *retString = [[NSMutableAttributedString alloc] initWithString:@""];
    for (id attString in gameLog) {
        if ([attString isKindOfClass:[NSAttributedString class]]) {
            [retString appendAttributedString:attString];
            [[retString mutableString] appendString:@"\n"];
        }
    }
    return retString;
}

@end
