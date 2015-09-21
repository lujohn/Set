//
//  PlayingCardView.h
//  SuperCard
//
//  Created by John Lu on 9/13/15.
//  Copyright (c) 2015 John Lu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (nonatomic) NSString *suit;
@property (nonatomic) BOOL faceUp;

- (void)pinch:(UIPinchGestureRecognizer *)gesture;

@end
