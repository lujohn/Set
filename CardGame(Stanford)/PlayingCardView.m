//
//  PlayingCardView.m
//  SuperCard
//
//  Created by John Lu on 9/13/15.
//  Copyright (c) 2015 John Lu. All rights reserved.
//

#import "PlayingCardView.h"

@interface PlayingCardView ()

@property (nonatomic) CGFloat cardFaceScaleFactor;

@end

@implementation PlayingCardView

#pragma mark - Initialization
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

@synthesize cardFaceScaleFactor = _cardFaceScaleFactor;
#define DEFAULT_CARD_FACE_SCALE_FACTOR .85

- (CGFloat)cardFaceScaleFactor
{
    if (!_cardFaceScaleFactor) {
        _cardFaceScaleFactor = DEFAULT_CARD_FACE_SCALE_FACTOR;
    }
    return _cardFaceScaleFactor;
}

- (void)setCardFaceScaleFactor:(CGFloat)cardFaceScaleFactor
{
    _cardFaceScaleFactor = cardFaceScaleFactor;
    [self setNeedsDisplay];
}

- (void)setRank:(NSUInteger)rank
{
    _rank = rank;
    [self setNeedsDisplay];
}

- (void)setSuit:(NSString *)suit
{
    _suit = suit;
    [self setNeedsDisplay];
}

- (void)setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

- (void)pinch:(UIPinchGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateChanged ||
        gesture.state == UIGestureRecognizerStateEnded) {
        self.cardFaceScaleFactor *= gesture.scale;
        gesture.scale = 1.0;
    }
}

#pragma mark - Drawing

#define CORNER_FONT_STANDARD_HEIGHT 180
#define CORNER_RADIUS 12

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }
- (CGFloat)cornerOffset { return [self cornerRadius] / 3.0; }

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    [[UIColor blackColor] setStroke];
    [roundedRect fill];
    [roundedRect stroke];
    
    // Draw Image in Middle
    if (self.faceUp) {
        UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", [self rankString], self.suit]];
        if (faceImage) {
            CGRect imageRect = CGRectInset(self.bounds, self.bounds.size.width * (1.0 - self.cardFaceScaleFactor), self.bounds.size.height * (1.0 - self.cardFaceScaleFactor));
            [faceImage drawInRect:imageRect];
        } else {
            [self drawPips];
        }
        // Draw the corner texts
        [self drawCorners];
    } else {
        [[UIImage imageNamed:@"cardBack"] drawInRect:self.bounds];
    }
}

#define HOFFSET_PERCENTAGE 0.200
#define VOFFSET1_PERCENTAGE 0.100
#define VOFFSET2_PERCENTAGE 0.175
#define VOFFSET3_PERCENTAGE 0.225
#define VOFFSET4_PERCENTAGE 0.350

- (void)drawPips
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    if (self.rank == 1 || self.rank == 3 || self.rank == 5 || self.rank == 9) {
        [self drawPipsWithHorizontalOffSet:0
                            verticalOffSet:0
                       mirroredeVertically:NO];
    }
    
    if (self.rank == 2 || self.rank == 3) {
        [self drawPipsWithHorizontalOffSet:0
                            verticalOffSet:VOFFSET4_PERCENTAGE
                       mirroredeVertically:YES];
    }
    
    if (self.rank == 6 || self.rank == 7 || self.rank == 8) {
        [self drawPipsWithHorizontalOffSet:HOFFSET_PERCENTAGE
                            verticalOffSet:0
                       mirroredeVertically:NO];
    }
    
    if (self.rank == 7 || self.rank == 8) {
        [self drawPipsWithHorizontalOffSet:0
                            verticalOffSet:VOFFSET2_PERCENTAGE
                       mirroredeVertically:(self.rank != 7)];
    }
    
    if (self.rank == 9 || self.rank == 10) {
        [self drawPipsWithHorizontalOffSet:HOFFSET_PERCENTAGE
                            verticalOffSet:VOFFSET1_PERCENTAGE
                       mirroredeVertically:YES];
    }
    
    if (self.rank == 4 || self.rank == 5 || self.rank == 6 || self.rank == 7 || self.rank == 8 || self.rank == 9 || self.rank == 10) {
        [self drawPipsWithHorizontalOffSet:HOFFSET_PERCENTAGE
                            verticalOffSet:VOFFSET4_PERCENTAGE
                       mirroredeVertically:YES];
    }
    
    if (self.rank == 10) {
        [self drawPipsWithHorizontalOffSet:0
                            verticalOffSet:VOFFSET3_PERCENTAGE
                       mirroredeVertically:YES];
    }
    
    CGContextRestoreGState(context);
}

- (void)drawPipsWithHorizontalOffSet:(CGFloat)horOffSet verticalOffSet:(CGFloat)vertOffSet mirroredeVertically:(BOOL)mirroredVertically
{
    [self drawPipsWithHorizontalOffset:horOffSet verticalOffset:vertOffSet];
    if (mirroredVertically) {
        [self pushContextState];
        [self rotateContextUpsideDown];
        [self drawPipsWithHorizontalOffset:horOffSet verticalOffset:vertOffSet];
        [self popContextState];
    }
}

#define PIP_FONT_SCALE_FACTOR .015
- (void)drawPipsWithHorizontalOffset:(CGFloat)horOffset verticalOffset:(CGFloat)vertOffSet
{
    // Set up the Attributed Text to draw
    UIFont *pipFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    pipFont = [pipFont fontWithSize:pipFont.pointSize * self.bounds.size.width * PIP_FONT_SCALE_FACTOR];
    NSAttributedString *pipText = [[NSAttributedString alloc] initWithString:self.suit attributes:@{ NSFontAttributeName : pipFont}];
    
    // Set up Point to draw pip at
    CGPoint middleOfView = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    CGSize pipSize = [pipText size];
    CGPoint pipOrigin;
    pipOrigin.x = middleOfView.x - (pipSize.width / 2.0) - (horOffset * self.bounds.size.width);
    pipOrigin.y = middleOfView.y - (pipSize.height / 2.0) - (vertOffSet * self.bounds.size.height);
    
    [pipText drawAtPoint:pipOrigin];
    
    // If horOffSet duplicate text on other side.
    if (horOffset) {
        pipOrigin.x += (horOffset * 2.0 * self.bounds.size.width);
        [pipText drawAtPoint:pipOrigin];
    }
}

- (void)pushContextState
{
    CGContextSaveGState(UIGraphicsGetCurrentContext());
}

- (void)rotateContextUpsideDown
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
}

- (void)popContextState
{
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

- (void)drawCorners
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    UIFont *cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cornerFont = [cornerFont fontWithSize:cornerFont.pointSize * [self cornerScaleFactor]];
    
    NSAttributedString *text = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", [self rankString], self.suit] attributes:@{NSParagraphStyleAttributeName : paragraphStyle, NSFontAttributeName : cornerFont}];
    
    CGRect textRect;
    textRect.origin = CGPointMake([self cornerOffset], [self cornerOffset]);
    textRect.size = [text size];
    
    [text drawInRect:textRect];
    
    // Draws the bottom corner (upside down)
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
    [text drawInRect:textRect];
    
    CGContextRestoreGState(context);
}

- (NSString *)rankString
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",
             @"7",@"8",@"9",@"10",@"J",@"Q",@"K"][self.rank];
}

@end
