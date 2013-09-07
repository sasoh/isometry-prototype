//
//  ViewController.m
//  IsometryPrototype
//
//  Created by Alexander Popov on 9/7/13.
//  Copyright (c) 2013 -. All rights reserved.
//

#import "ViewController.h"

const int mapColumns    = 10;
const int mapRows       = 8;
const int map[mapRows][mapColumns] = {
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 0, 0, 0, 0, 0, 0, 1,
    1, 1, 1, 0, 0, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 0, 0, 0, 0, 1,
    1, 1, 1, 1, 0, 0, 1, 1, 1, 1,
};
const CGFloat tileSize          = 30.0; // for carthesian display
const CGFloat tileIsoHeight     = 30.0; // for isometric display
const CGFloat tileIsoWidth      = 60.0;
const CGFloat tileIsoHeightHalf = 15.0; // for isometric calculations
const CGFloat tileIsoWidthHalf  = 30.0;

CGFloat offset; // will be used to show the map only on the positive X axis

@interface ViewController ()

- (void)drawArrayMap;
- (void)drawArrayTile:(int)type inView:(UIView *)container atPoint:(CGPoint)position;
- (void)drawIsometricTile:(int)type inView:(UIView *)container atPoint:(CGPoint)position;
- (void)addInputInView:(UIView *)targetView;
- (void)handleInputFrom:(UIGestureRecognizer *)recognizer;
- (void)updateStatusLabelWithScreenLocation:(CGPoint)position;

// screen/grid
- (CGPoint)gridFromScreen:(CGPoint)position;
- (CGPoint)screenFromGridX:(int)column andY:(int)row;

// grid/isometric grid
- (CGPoint)isoFromGridX:(int)column andY:(int)row;
- (CGPoint)gridFromIso:(CGPoint)position;

// screen/isometric grid
- (CGPoint)isoFromScreen:(CGPoint)position;
- (CGPoint)screenFromIso:(CGPoint)position;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [statusLabel setText:@""];
    
    
    // since for Y increases in isometric projection the screen X coordinates can go <0, I'll add lowest value as an offset for all tiles
    // the 'leftmost' position would be (mapRows - 1), so I'll use its X coordinate
    CGPoint isoLimit = [self isoFromGridX:0 andY:(mapRows - 1) * tileSize];
    offset = isoLimit.x;
    
    [self drawArrayMap];
    // add gesture recognizer to detect taps
    [self addInputInView:containerView];

    [super viewWillAppear:animated];

}

- (void)drawArrayMap
{
    
    for (int row = 0; row < mapRows; ++row) {
        for (int column = 0; column < mapColumns; ++column) {
            CGPoint tilePosition = CGPointZero;
            // for drawing in carthesian
//            tilePosition.x = column * tileSize;
//            tilePosition.y = row * tileSize;
//            [self drawArrayTile:map[row][column] inView:containerView atPoint:tilePosition];
            
            // for drawing isometric
            tilePosition = [self screenFromIso:CGPointMake(column, row)];
            [self drawIsometricTile:map[row][column] inView:containerView atPoint:tilePosition]; // for drawing in isometric
        }
    }
   
}

- (void)updateStatusLabelWithScreenLocation:(CGPoint)position
{
    
//    CGPoint gridLocation = [self gridFromScreen:position];
    
    CGPoint isoLocation = [self isoFromScreen:position];
    isoLocation.x = floorf(isoLocation.x);
    isoLocation.y = floorf(isoLocation.y);
    
//    NSString *str = [NSString stringWithFormat:@"Actual position: %@\nGrid position: %@\nSnapped screen position: %@", NSStringFromCGPoint(position), NSStringFromCGPoint(gridLocation), NSStringFromCGPoint([self screenFromGridX:gridLocation.x andY:gridLocation.y])];
    NSString *str = [NSString stringWithFormat:@"Actual position: %@\nIsometric grid position: %@", NSStringFromCGPoint(position), NSStringFromCGPoint(isoLocation)];
    [statusLabel setText:str];
    
}

- (void)drawArrayTile:(int)type inView:(UIView *)container atPoint:(CGPoint)position
{
    
    UIView *tileView = [[UIView alloc] initWithFrame:CGRectMake(position.x, position.y, tileSize, tileSize)];
    UIColor *tileColor = nil;
    if (type == 0) {
        tileColor = [UIColor greenColor];
    } else {
        tileColor = [UIColor yellowColor];
    }
    [tileView setBackgroundColor:tileColor];
    [container addSubview:tileView];
    
}

- (void)drawIsometricTile:(int)type inView:(UIView *)container atPoint:(CGPoint)position
{
    
    UIImageView *tileView = [[UIImageView alloc] initWithFrame:CGRectMake(position.x + fabs(offset), position.y, tileIsoWidth, tileIsoHeight)];
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"tile%d", type]];
    [tileView setImage:image];
    [container addSubview:tileView];
    
}

- (void)addInputInView:(UIView *)targetView
{
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleInputFrom:)];
    [targetView addGestureRecognizer:recognizer];
    
}

- (void)handleInputFrom:(UIGestureRecognizer *)recognizer
{
    
    CGPoint location = [recognizer locationInView:containerView];
    
    [self updateStatusLabelWithScreenLocation:location];
    
}

// screen/grid
- (CGPoint)gridFromScreen:(CGPoint)position
{
    
    CGPoint result = CGPointZero;
    result.x = floorf(position.x / tileSize);
    result.y = floorf(position.y / tileSize);
    return result;
    
}

- (CGPoint)screenFromGridX:(int)column andY:(int)row
{
    
    CGPoint result = CGPointZero;
    result.x = column * tileSize;
    result.y = row * tileSize;
    return result;
    
}

// grid/isometric grid
- (CGPoint)isoFromGridX:(int)column andY:(int)row
{

    CGPoint result = CGPointZero;
    result.x = column - row;
    result.y = (column + row) / 2;
    return result;
    
}

- (CGPoint)gridFromIso:(CGPoint)position
{

    CGPoint result = CGPointZero;
    result.x = (2 * position.y + position.x) / 2;
    result.y = (2 * position.y - position.x) / 2;
    return result;

}

// screen/isometric grid
- (CGPoint)isoFromScreen:(CGPoint)position
{
    
    // remove offset
    position.x -= fabsf(offset);
    // tile drawing is from top left corner, not top center
    position.x -= tileIsoWidthHalf;
    
    CGPoint result = CGPointZero;
    result.x = ((position.x / tileIsoWidthHalf) + (position.y / tileIsoHeightHalf)) / 2;
    result.y = ((position.y / tileIsoHeightHalf) - (position.x / tileIsoWidthHalf)) / 2;
    return result;

}

- (CGPoint)screenFromIso:(CGPoint)position
{

    CGPoint result = CGPointZero;
    result.x = (position.x - position.y) * tileIsoWidthHalf;
    result.y = (position.x + position.y) * tileIsoHeightHalf;
    return result;

}

@end
