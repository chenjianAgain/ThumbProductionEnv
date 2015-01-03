//
//  SSFShowColorPointView.m
//  Thumb
//
//  Created by ios on 14-11-18.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import "SSFShowColorPointView.h"

@interface SSFShowColorPointView ()

@property (strong,nonatomic) IBOutletCollection(UIButton) NSArray *buttonPoints;

@end

@implementation SSFShowColorPointView

- (void)showColorPointWithColorPointString:(NSString *)colorPointString
{
    if (colorPointString.length) {
        
        for (UIButton *button in self.buttonPoints) {
            button.selected = NO;
        }
        
        for (int i = 0; i < colorPointString.length; i ++) {
            NSString *a = [colorPointString substringWithRange:NSMakeRange(i, 1)];
            int b = [a intValue];
            for (UIButton *button in self.buttonPoints) {
                if (button.tag == b) {
                    button.selected = YES;
                }
            }
        }        
    }
}

+ (SSFShowColorPointView *)instanceSSFShowColorPointView
{
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"SSFShowColorPointView" owner:self options:nil];
    return arr[0];
}

@end
