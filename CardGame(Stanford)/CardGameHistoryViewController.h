//
//  CardGameHistoryViewController.h
//  CardGame(Stanford)
//
//  Created by John Lu on 9/8/15.
//  Copyright (c) 2015 voyager. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardGameHistoryViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *historyTextField;
@property (strong, nonatomic) NSArray *gameLog;

@end
