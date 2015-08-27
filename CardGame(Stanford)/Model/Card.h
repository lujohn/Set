//
//  Card.h
//  CardGame(Stanford)
//
//  Created by John Lu on 8/11/15.
//  Copyright (c) 2015 voyager. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (nonatomic, strong) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;


@end
