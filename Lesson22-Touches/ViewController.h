//
//  ViewController.h
//  Lesson22-Touches
//
//  Created by Nick Bibikov on 11/7/14.
//  Copyright (c) 2014 Nick Bibikov. All rights reserved.
//

#import <UIKit/UIKit.h>
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *smallSky;
@property (strong, nonatomic) IBOutlet UIImageView *bigSky;

@end

