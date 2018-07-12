//
//  CustomSegment.h
//  yxx_ios
//
//  Created by 朱松泽 on 2017/9/28.
//  Copyright © 2017年 GDtech. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CustomSegmentBlock)(NSString *currentTitle,NSArray *itemTitleArray);
@interface CustomSegment : UIView
@property (nonatomic, strong) UIColor *itemBackGroundColor;
@property (nonatomic, strong) UIColor *itemTextDefaultColor;
@property (nonatomic, strong) UIColor *itemTextSelectedColor;
@property (nonatomic, strong) UIFont *itemFont;
@property (nonatomic, strong) UIColor *bottomLineColor;
/** <#name#> */
@property (nonatomic, assign) CGFloat cursorLineWidth;
/** <#注释#> */
@property (nonatomic, strong) UIColor *cursorLineColor;
/** <#name#> */
@property (nonatomic, assign) BOOL bottomLineHidden;

/** <#name#> */
@property (nonatomic, assign) NSInteger currentIndex;
- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray actionBlock:(CustomSegmentBlock)block;
@end
