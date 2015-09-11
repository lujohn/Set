//
//  HighScoreRecord.h
//  CardGame(Stanford)
//
//  Created by John Lu on 9/9/15.
//  Copyright (c) 2015 voyager. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HighScoreRecord : NSObject 

@property (nonatomic) int score;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *game;
@property (nonatomic, strong) NSString *gameDuration;

@end
