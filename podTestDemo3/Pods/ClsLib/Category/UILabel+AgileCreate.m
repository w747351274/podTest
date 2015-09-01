//
//  UILabel+AgileCreate.m
//  Pro10788
//
//  Created by WangJiangLei on 12/2/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import "UILabel+AgileCreate.h"

@implementation UILabel (AgileCreate)

+(UILabel *)labelWithContent:(NSString *)str{
    UILabel *label = [[UILabel alloc]init];
    [label setText:str];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor whiteColor]];
    [label setNumberOfLines:0];
    [label setFont:[UIFont fontWithName:@"Helvetica" size:13]];
    [label sizeToFit];
    [label.layer setShadowColor:[UIColor whiteColor].CGColor];
    return label;
}
+(UILabel *)labelWithString:(NSString *)str{
    UILabel *label = [[UILabel alloc]init];
    [label setText:str];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor blackColor]];
    [label setNumberOfLines:0];
    [label setFont:[UIFont fontWithName:@"Helvetica" size:14]];
    [label sizeToFit];
    [label.layer setShadowColor:[UIColor whiteColor].CGColor];
    return label;
}

- (void)alignTop {
    CGSize fontSize = [self.text sizeWithFont:self.font];
    double finalHeight = fontSize.height * self.numberOfLines;
    double finalWidth = self.frame.size.width;    //expected width of label
    CGSize theStringSize = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
    int newLinesToPad = (finalHeight  - theStringSize.height) / fontSize.height;
    for(int i=0; i<newLinesToPad; i++)
        self.text = [self.text stringByAppendingString:@"\n "];
}

@end
