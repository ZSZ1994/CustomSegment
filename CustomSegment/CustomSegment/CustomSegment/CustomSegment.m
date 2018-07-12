//
//  CustomSegment.m
//  yxx_ios
//
//  Created by 朱松泽 on 2017/9/28.
//  Copyright © 2017年 GDtech. All rights reserved.
//

#import "CustomSegment.h"
CustomSegmentBlock myBlock;
@interface CustomSegment ()
@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIView *cursorLine;
@property (nonatomic, strong) NSArray *itemNameArray;
@end
@implementation CustomSegment

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray actionBlock:(CustomSegmentBlock)block{
    if (self = [super initWithFrame:frame]) {
        self.itemNameArray = titleArray;
        myBlock = block;
        _bottomLineColor = [UIColor lightGrayColor];
        _itemFont = [UIFont systemFontOfSize:14];
        _itemTextDefaultColor = [UIColor grayColor];
        _itemTextSelectedColor = [UIColor blueColor];
        _itemBackGroundColor = [UIColor whiteColor];
        CGFloat buttonWidth = frame.size.width/titleArray.count;
        CGFloat buttonHeight = frame.size.height;
        for (int i = 0; i < titleArray.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(i*(buttonWidth), 0, buttonWidth, buttonHeight);
            button.titleLabel.font = _itemFont;
            [button setTitleColor:_itemTextDefaultColor forState:UIControlStateNormal];
            [button setTitleColor:_itemTextSelectedColor forState:UIControlStateSelected];
            [button setBackgroundColor:_itemBackGroundColor];
            if (i==0) {
                button.selected = YES;
            }
            button.tag = 100+i;
            [button setTitle:titleArray[i] forState:0];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.buttonArray addObject:button];
            [self addSubview:button];
            [self addSubview:self.line];
            
            self.line.frame = CGRectMake(0, CGRectGetHeight(frame)-1, CGRectGetWidth(frame), 1);

        }
        _cursorLineWidth = frame.size.width/titleArray.count;
        self.cursorLine.frame = CGRectMake(0, frame.size.height-2.5, self.cursorLineWidth, 1.5);
        [self addSubview:self.cursorLine];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    

    }

#pragma mark --- action
- (void)buttonAction:(UIButton *)sender {
    
    for (UIButton *button in self.buttonArray) {
        button.selected = NO;
    }
    sender.selected = YES;
    [self.buttonArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *currentBtn = (UIButton *)obj;
        if (currentBtn == sender) {
            [UIView animateWithDuration:0.3 animations:^{
//                CGFloat cursorWidth = self.frame.size.width/self.buttonArray.count;
                CGFloat buttonWidth = CGRectGetWidth(sender.frame);
                CGFloat buttonX = idx * buttonWidth;
                
                CGFloat lineX = buttonX + (buttonWidth-self.cursorLineWidth)/2;
                self.cursorLine.frame = CGRectMake(lineX, self.frame.size.height-2.5, self.cursorLineWidth, 1.5);
            }];
            *stop = YES;
        }
    }];
    myBlock(sender.titleLabel.text,self.itemNameArray);
}
#pragma mark --- lazy load

- (NSMutableArray *)buttonArray {
    
    if (_buttonArray == nil) {
        _buttonArray = [NSMutableArray arrayWithCapacity:3];
    }
    
    return _buttonArray;
}

- (void)setBottomLineColor:(UIColor *)bottomLineColor {
    _bottomLineColor = bottomLineColor;
    self.line.backgroundColor = _bottomLineColor;
}

- (void)setItemFont:(UIFont *)itemFont {
    _itemFont = itemFont;
    [self.buttonArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = (UIButton *)obj;
        btn.titleLabel.font = itemFont;
    }];
}

- (void)setItemTextDefaultColor:(UIColor *)itemTextDefaultColor {
    _itemTextDefaultColor = itemTextDefaultColor;
    [self.buttonArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = (UIButton *)obj;
        [btn setTitleColor:itemTextDefaultColor forState:UIControlStateNormal];
    }];
}

- (void)setItemTextSelectedColor:(UIColor *)itemTextSelectedColor {
    _itemTextSelectedColor = itemTextSelectedColor;
    [self.buttonArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = (UIButton *)obj;
        [btn setTitleColor:itemTextSelectedColor forState:UIControlStateSelected];
    }];
}

- (void)setItemBackGroundColor:(UIColor *)itemBackGroundColor {
    _itemBackGroundColor = itemBackGroundColor;
    [self.buttonArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = (UIButton *)obj;
        [btn setBackgroundColor:itemBackGroundColor];
    }];
}

-(UIView *)line {
    if (_line == nil) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = self.bottomLineColor;
    }
    return _line;
}

- (UIView *)cursorLine {
    if (_cursorLine == nil) {
        _cursorLine = [[UIView alloc] init];
        _cursorLine.backgroundColor = self.bottomLineColor;
    }
    return _cursorLine;
}

- (void)setCursorLineColor:(UIColor *)cursorLineColor {
    _cursorLineColor = cursorLineColor;
    
    self.cursorLine.backgroundColor = cursorLineColor;
}

- (void)setCursorLineWidth:(CGFloat)cursorLineWidth {
    _cursorLineWidth = cursorLineWidth;
    CGRect lineOriFrame = self.cursorLine.frame;
    CGFloat buttonWidth = CGRectGetWidth(self.frame)/self.buttonArray.count;
    CGFloat lineX = (buttonWidth - cursorLineWidth)/2;
    lineOriFrame = CGRectMake(lineX, CGRectGetMinY(lineOriFrame), cursorLineWidth, 1);
    self.cursorLine.frame = lineOriFrame;
}

- (void)setBottomLineHidden:(BOOL)bottomLineHidden {
    
    _bottomLineHidden = bottomLineHidden;
    self.line.hidden = _bottomLineHidden;
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    UIButton *clickButton = self.buttonArray[currentIndex];
    [self buttonAction:clickButton];
}

- (NSArray *)itemNameArray {
    if (!_itemNameArray) {
        
        _itemNameArray = [[NSArray alloc] init];
    }
    return _itemNameArray;
}
@end
