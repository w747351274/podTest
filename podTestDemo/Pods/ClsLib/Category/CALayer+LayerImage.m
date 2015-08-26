//
//  CALayer+LayerImage.m
//  Plattii-new
//
//  Created by Jianglei Wang on 4/13/15.
//  Copyright (c) 2015 Jianglei Wang. All rights reserved.
//

#import "CALayer+LayerImage.h"

@implementation CALayer (LayerImage)
- (UIImage*)getLayerImage
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 2);
    
    CGContextScaleCTM(UIGraphicsGetCurrentContext(), 1, 1);
    [self renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *tmp = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return tmp;
}

@end
