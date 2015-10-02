//
//  SetCardView.m
//  CardGame(Stanford)
//
//  Created by John Lu on 9/24/15.
//  Copyright (c) 2015 voyager. All rights reserved.
//

#import "SetCardView.h"

@implementation SetCardView


-(instancetype)initWithFrame:(CGRect)frame
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

- (void)setNumber:(NSNumber *)number
{
    _number = number;
    [self setNeedsDisplay];
}

- (void)setShade:(NSNumber *)shade
{
    _shade = shade;
    [self setNeedsDisplay];
}

- (void)setColor:(NSNumber *)color
{
    _color = color;
    [self setNeedsDisplay];
}

- (void)setSymbol:(NSNumber *)symbol
{
    _symbol = symbol;
    [self setNeedsDisplay];
}

#define CORNER_FONT_STANDARD_HEIGHT 180
#define CORNER_RADIUS 12

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }
- (CGFloat)cornerOffset { return [self cornerRadius] / 3.0; }

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    [[UIColor whiteColor] setFill];
    [[UIColor blackColor] setStroke];
    [roundedRect fill];
    [roundedRect stroke];
    [self drawSymbols];
}

#define VOFFSET_1_PERCENTAGE .27
#define VOFFSET_2_PERCENTAGE .17
#define SYMBOL_HEIGHT_PERCENTAGE .23
#define SYMBOL_WIDTH_PERCENTAGE .60

- (CGFloat)symbolHeight { return self.bounds.size.height * SYMBOL_HEIGHT_PERCENTAGE; }
- (CGFloat)symbolWidth { return self.bounds.size.width * SYMBOL_WIDTH_PERCENTAGE; }

- (void)drawSymbols
{
    [self pushContextState];
    if ([self.number isEqualToNumber:@1] || [self.number isEqualToNumber:@3]) {
        [self drawSymbolWithVerticalOffset:0.0 mirroredVertically:NO];
    }
    
    if ([self.number isEqualToNumber:@2]) {
        [self drawSymbolWithVerticalOffset:VOFFSET_2_PERCENTAGE mirroredVertically:YES];
    }
    
    if ([self.number isEqualToNumber:@3]) {
        [self drawSymbolWithVerticalOffset:VOFFSET_1_PERCENTAGE mirroredVertically:YES];
    }

    [self popContextState];
}

- (void)drawSymbolWithVerticalOffset:(CGFloat)vOffset mirroredVertically:(BOOL)mirrored
{
    [self drawSymbolWithVerticalOffset:vOffset];
    if (mirrored) {
        [self pushContextState];
        [self rotateContextUpsideDown];
        [self drawSymbolWithVerticalOffset:vOffset];
        [self popContextState];
    }
}

- (void)drawSymbolWithVerticalOffset:(CGFloat)vOffset
{
    UIColor *cardColor = [self colorForCard];
    [cardColor setFill];
    [cardColor setStroke];
    
    [self pushContextState];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, -self.bounds.size.height * vOffset);
    
    UIBezierPath *symbol = [self bezierPathForSymbol];
    [symbol addClip];
    [self drawShadingForPath:symbol];
    [symbol stroke];
    [self popContextState];
}


#define STANDRARD_WIDTH 150
#define STANDARD_NUM_STRIPES 20

- (CGFloat)numStripes { return self.bounds.size.width * STANDARD_NUM_STRIPES / STANDRARD_WIDTH; }
- (CGFloat)horizontalOffsetForStripe { return [self symbolWidth] / [self numStripes]; }
- (void)drawShadingForPath:(UIBezierPath *)path
{
    // 1 = stripes, 2 = solid, 3 = open
    if ([self.shade isEqualToNumber:@1]) {
        [self fillInStripesForPath:path];
    } else if ([self.shade isEqualToNumber:@2]) {
        [path fill];
    }
}

- (UIColor *)colorForCard
{
    // 1 = green, 2 = red, 3 = purple
    if ([self.color isEqualToNumber:@1]) {
        return [UIColor greenColor];
    } else if ([self.color isEqualToNumber:@2]) {
        return [UIColor redColor];
    } else {
        return [UIColor purpleColor];
    }
}

- (UIBezierPath *)bezierPathForSymbol
{
    // 1 = Oval, 2 = Diamond, 3 = Squiggle
    if ([self.symbol isEqualToNumber:@1]) {
        return [self pathForOval];
    } else if ([self.symbol isEqualToNumber:@2]) {
        return [self pathForDiamond];
    } else {
        return [self pathForSquiggle];
    }
}

- (void)fillInStripesForPath:(UIBezierPath *)path
{
    // Stripes
    CGPoint middle = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    
    CGPoint startPoint, endPoint;
    startPoint.x = middle.x - [self symbolWidth] / 2.0;
    startPoint.y = middle.y - [self symbolWidth] / 2.0;
    endPoint.x = startPoint.x;
    endPoint.y = startPoint.y + [self symbolHeight] * 2.0;  // Multiplcation by 2 only to guarantee that stripe spans whole shape.
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];
    
    int i = 0;
    while (i < [self numStripes]) {
        startPoint.x += [self horizontalOffsetForStripe];
        endPoint.x += [self horizontalOffsetForStripe];
        [path moveToPoint:startPoint];
        [path addLineToPoint:endPoint];
        i++;
    }
    [path stroke];
}

- (UIBezierPath *)pathForOval
{
    CGPoint middle = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    UIBezierPath *oval = [[UIBezierPath alloc] init];

    // Draw Line on Top (half)
    CGPoint startOfLine, endOfLine;
    startOfLine.x = middle.x;
    startOfLine.y = middle.y - ([self symbolHeight] / 2.0);
    endOfLine.x = startOfLine.x + ([self symbolWidth] / 4.0);
    endOfLine.y = startOfLine.y;
    [oval moveToPoint:startOfLine];
    [oval addLineToPoint:endOfLine];
    
    // Draw Half Circle (right)
    CGPoint centerOfCircle;
    centerOfCircle.x = endOfLine.x;
    centerOfCircle.y = endOfLine.y + ([self symbolHeight] / 2.0);
    [oval addArcWithCenter:centerOfCircle radius:[self symbolHeight] / 2.0 startAngle:-M_PI_2 endAngle:M_PI_2 clockwise:YES];
    
    // Draw Bottom Line (full)
    endOfLine.x = oval.currentPoint.x - ([self symbolWidth] / 2.0);
    endOfLine.y = oval.currentPoint.y;
    [oval addLineToPoint:endOfLine];
    
    // Draw Half Circle (left)
    centerOfCircle.x = oval.currentPoint.x;
    centerOfCircle.y = oval.currentPoint.y - ([self symbolHeight] / 2.0);
    [oval addArcWithCenter:centerOfCircle radius:[self symbolHeight] / 2.0 startAngle:M_PI_2 endAngle:-M_PI_2 clockwise:YES];
    
    [oval closePath];  // connect left half circle to first line

    return oval;
    
}

- (UIBezierPath *)pathForDiamond
{
    CGPoint middle = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    UIBezierPath *diamond = [[UIBezierPath alloc] init];
    
    // Draw Left Diagonal (top)
    CGPoint startOfLine, endOfLine;
    startOfLine.x = middle.x - [self symbolWidth] / 2.0;
    startOfLine.y = middle.y;
    endOfLine.x = middle.x;
    endOfLine.y = middle.y - [self symbolHeight] / 2.0;
    [diamond moveToPoint:startOfLine];
    [diamond addLineToPoint:endOfLine];
    
    // Draw Right Diagonal (top)
    endOfLine.x = middle.x + [self symbolWidth] / 2.0;
    endOfLine.y = middle.y;
    [diamond addLineToPoint:endOfLine];
    
    // Draw Right Diagonal (bottom)
    endOfLine.x = middle.x;
    endOfLine.y = middle.y + [self symbolHeight] / 2.0;
    [diamond addLineToPoint:endOfLine];
    
    // Draw Left Diagonal (bottom)
    endOfLine.x = middle.x - [self symbolWidth] / 2.0;
    endOfLine.y = middle.y;
    [diamond addLineToPoint:endOfLine];
    
    return diamond;
}

#define CONTROL_POINT_WIDTH_FACTOR_ONE 0.50
#define CONTROL_POINT_WIDTH_FACTOR_TWO 0.20
#define CONTROL_POINT_HEIGHT_FACTOR_ONE 1.2
#define CONTROL_POINT_HEIGHT_FACTOR_TWO 0.45
- (UIBezierPath *)pathForSquiggle
{
    CGPoint middle = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    UIBezierPath *squiggle = [[UIBezierPath alloc] init];
    
    // Top squiggle
    CGPoint startPoint, controlOne, controlTwo, endPoint;
    startPoint.x =  middle.x - [self symbolWidth] / 2.0;
    startPoint.y = middle.y + [self symbolHeight] / 2.0;
    
    controlOne.x = middle.x - [self symbolWidth] * CONTROL_POINT_WIDTH_FACTOR_ONE;
    controlOne.y = middle.y - [self symbolHeight] * CONTROL_POINT_HEIGHT_FACTOR_ONE;
    
    controlTwo.x = middle.x + [self symbolWidth] * CONTROL_POINT_WIDTH_FACTOR_TWO;
    controlTwo.y = middle.y + [self symbolHeight] * CONTROL_POINT_HEIGHT_FACTOR_TWO;
    
    endPoint.x = middle.x + [self symbolWidth] / 2.0;
    endPoint.y = middle.y - [self symbolHeight] / 2.0;
    
    [squiggle moveToPoint:startPoint];
    [squiggle addCurveToPoint:endPoint controlPoint1:controlOne controlPoint2:controlTwo];
    
    // Bottom Squiqqle
    startPoint.x = middle.x + [self symbolWidth] / 2.0;
    startPoint.y = middle.y - [self symbolHeight] / 2.0;
    
    controlOne.x = middle.x + [self symbolWidth] * CONTROL_POINT_WIDTH_FACTOR_ONE;
    controlOne.y = middle.y + [self symbolHeight] * CONTROL_POINT_HEIGHT_FACTOR_ONE;
    
    controlTwo.x = middle.x - [self symbolWidth] * CONTROL_POINT_WIDTH_FACTOR_TWO;
    controlTwo.y = middle.y - [self symbolHeight] * CONTROL_POINT_HEIGHT_FACTOR_TWO;
    
    endPoint.x = middle.x - [self symbolWidth] / 2.0;
    endPoint.y = middle.y + [self symbolHeight] / 2.0;
    
    [squiggle moveToPoint:startPoint];
    [squiggle addCurveToPoint:endPoint controlPoint1:controlOne controlPoint2:controlTwo];
    
    return squiggle;
}

- (void)pushContextStateAndRotateUpsideDown
{
    [self pushContextState];
    [self rotateContextUpsideDown];
}

- (void)rotateContextUpsideDown
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
}

- (void)pushContextState
{
    CGContextSaveGState(UIGraphicsGetCurrentContext());
}

- (void)popContextState
{
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
}
@end
