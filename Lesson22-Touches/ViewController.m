//
//  ViewController.m
//  Lesson22-Touches
//
//  Created by Nick Bibikov on 11/7/14.
//  Copyright (c) 2014 Nick Bibikov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) UIView* draggingView;
@property (assign, nonatomic) CGPoint touchOffset;

@end

@implementation ViewController


#pragma mark - Initializing

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    /*
    UIView* draggingView = [[UIView alloc] initWithFrame:CGRectMake(40, 300, 40, 40)];
    draggingView.backgroundColor = UIColorFromRGB(0x9c6c4a);
    [self.view addSubview:draggingView];
    draggingView = self.draggingView;
    
    UIImageView* testView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mario-0.png"]];
    testView.center = CGPointMake(50, 529);
    [self.view addSubview:testView];
*/
    for (int i = 0; i < 5; i++) {
        UIView* viewSquare = [[UIView alloc] initWithFrame:CGRectMake(10 + 50 * i , 100, 50, 50)];
        viewSquare.backgroundColor = [self randomColor];
        [self.view addSubview:viewSquare];
    }
    
}


#pragma mark - Touches

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    self.smallSky.center = CGPointMake(-100, 70);
    self.bigSky.center = CGPointMake(-100, 150);
    
    [UIView animateWithDuration:5
                          delay:0
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionRepeat
                     animations:^{
                         self.smallSky.center = CGPointMake(500, 70);
                     } completion:^(BOOL finished) {

                     }];
    
    [UIView animateWithDuration:5
                          delay:2
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionRepeat
                     animations:^{
                         self.bigSky.center = CGPointMake(500, 150);
                     } completion:^(BOOL finished) {

                     }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) logTouches:(NSSet*)touches withMethod:(NSString*) methodName {
    
    NSMutableString* string = [NSMutableString stringWithString:methodName];
    
    for (UITouch* touch in touches) {
        CGPoint location = [touch locationInView:self.view];
        [string appendFormat:@" %@", NSStringFromCGPoint(location)];
    }
    
    NSLog(@"%@", string);
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self logTouches:touches withMethod:@"touchesBegan"];
    
    UITouch* touchTest = [touches anyObject];
    CGPoint pointOnMainView = [touchTest locationInView:self.view];
    UIView* draggingView = [self.view hitTest:pointOnMainView withEvent:event];
    
    if (![draggingView isEqual:self.view]) {
        self.draggingView = draggingView;
        [self.view bringSubviewToFront:self.draggingView];
        CGPoint touchPoint = [touchTest locationInView:self.draggingView];
        self.touchOffset = CGPointMake(CGRectGetMidX(self.draggingView.bounds) - touchPoint.x,
                                       CGRectGetMidY(self.draggingView.bounds) - touchPoint.y);
        
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.draggingView.transform = CGAffineTransformMakeScale(1.6f, 1.6f);
                             self.draggingView.alpha = 0.3;
                         }];
        
    } else {
        
        self.draggingView = nil;
    }
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

    if (self.draggingView) {
        UITouch* touchTest = [touches anyObject];
        CGPoint pointOnMainView = [touchTest locationInView:self.view];
        self.draggingView.center = CGPointMake(pointOnMainView.x + self.touchOffset.x,
                                               pointOnMainView.y + self.touchOffset.y);
    }
    
    [self logTouches:touches withMethod:@"touchesMoved"];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self logTouches:touches withMethod:@"touchesEnded"];
    [self animationEnded];
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self logTouches:touches withMethod:@"touchesCancelled"];
    [self animationEnded];
}


#pragma mark - function

- (void) animationEnded {
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.draggingView.transform = CGAffineTransformIdentity;
                         self.draggingView.alpha = 1;
                     }];
    
    self.draggingView = nil;
}

- (UIColor*) randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor* color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}
//-------------------------------------------------------------------------------
@end
