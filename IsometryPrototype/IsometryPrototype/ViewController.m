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
const CGFloat tileSize = 30.0;

@interface ViewController ()

- (void)drawArrayMap;
- (void)drawArrayTile:(int)type inView:(UIView *)container atPoint:(CGPoint)position;
- (void)addInputInView:(UIView *)targetView;
- (void)handleInputFrom:(UIGestureRecognizer *)recognizer;

// screen to grid
- (CGPoint)gridFromScreen:(CGPoint)position;
- (CGPoint)screenFromGridX:(int)column andY:(int)row;

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
            tilePosition.x = column * tileSize;
            tilePosition.y = row * tileSize;
            [self drawArrayTile:map[row][column] inView:containerView atPoint:tilePosition];
        }
    }
    
    
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

- (void)addInputInView:(UIView *)targetView
{
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleInputFrom:)];
    [targetView addGestureRecognizer:recognizer];
    
}

- (void)handleInputFrom:(UIGestureRecognizer *)recognizer
{
    
    CGPoint location = [recognizer locationInView:containerView];
    
    CGPoint gridLocation = [self gridFromScreen:location];
    
    NSString *str = [NSString stringWithFormat:@"Actual position: %@\nGrid position: %@\nSnapped screen position: %@", NSStringFromCGPoint(location), NSStringFromCGPoint(gridLocation), NSStringFromCGPoint([self screenFromGridX:gridLocation.x andY:gridLocation.y])];
    [statusLabel setText:str];
    
}

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

@end
