//
//  NNTagView.m
//  ProductTemplet
//
//  Created by Bin Shang on 2020/1/15.
//  Copyright © 2020 BN. All rights reserved.
//

#import "NNTagView.h"

@implementation NNTagView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        [self setUp];
    }
    return self;
}

// 初始化
- (void)setUp{
    // 默认颜色
    _textColorNormal = [UIColor darkGrayColor];
    _textColorSelected = [UIColor whiteColor];
    _backgroundColorSelected = [UIColor redColor];
    _backgroundColorNormal = [UIColor whiteColor];
    
    _fontSize = 13;
    _index = 0;
    _hasDefaultIndex = false;
    _canSelectedIndex = false;
    // 创建标签按钮
    [self createTagButton];
}

- (void)setFontSize:(CGFloat)fontSize{
    _fontSize = fontSize;
    // 重新创建标签
    [self resetTagButton];
}

// 重写set属性
- (void)setTagArray:(NSMutableArray *)tagArray{
    _tagArray = tagArray;
    
    // 重新创建标签
    [self resetTagButton];
}

- (void)setTextColorSelected:(UIColor *)textColorSelected{
    _textColorSelected = textColorSelected;
    // 重新创建标签
    [self resetTagButton];
}

- (void)setTextColorNormal:(UIColor *)textColorNormal{
    _textColorNormal = textColorNormal;
    // 重新创建标签
    [self resetTagButton];
}

- (void)setBackgroundColorSelected:(UIColor *)backgroundColorSelected{
    _backgroundColorSelected = backgroundColorSelected;
    // 重新创建标签
    [self resetTagButton];
}

- (void)setBackgroundColorNormal:(UIColor *)backgroundColorNormal{
    _backgroundColorNormal = backgroundColorNormal;
    // 重新创建标签
    [self resetTagButton];
}

#pragma mark - Private

// 重新创建标签
- (void)resetTagButton{
    // 移除之前的标签
    for (UIButton* btn  in self.subviews) {
        [btn removeFromSuperview];
    }
    // 重新创建标签
    [self createTagButton];
}

// 创建标签按钮
- (void)createTagButton{
    // 按钮高度
    CGFloat btnH = 20;
    // 距离左边距
    CGFloat leftX = 0;
    // 距离上边距
    CGFloat topY = 0;
    // 按钮左右间隙
    CGFloat marginX = 8;
    // 按钮上下间隙
    CGFloat marginY = 8;
    // 文字左右间隙
    CGFloat fontMargin = 8;
    
    for (int i = 0; i < _tagArray.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.adjustsImageWhenHighlighted = false;
        btn.frame = CGRectMake(marginX + leftX, topY, 100, btnH);
        btn.tag = 100+i;
        // 默认选中第一个
        if (i == self.index && self.hasDefaultIndex && self.canSelectedIndex) {
            btn.selected = YES;
        }
        
        // 按钮文字
        [btn setTitle:_tagArray[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:self.fontSize];

        //------ 默认样式
        [btn setTitleColor:self.textColorNormal forState:UIControlStateNormal];
        [btn setBackgroundImage:[self imageWithColor:self.backgroundColorNormal] forState:UIControlStateNormal];

        //-----  选中样式
        [btn setTitleColor:self.textColorSelected forState:UIControlStateSelected];
        [btn setBackgroundImage:[self imageWithColor:self.backgroundColorSelected] forState:UIControlStateSelected];
        
        // 设置按钮的边距、间隙
        [self setTagButtonMargin:btn fontMargin:fontMargin];
        
        // 处理换行
        if (btn.frame.origin.x + btn.frame.size.width + marginX > self.frame.size.width) {
            // 换行
            topY += btnH + marginY;
            // 重置
            leftX = 0;
            btn.frame = CGRectMake(marginX + leftX, topY, 100, btnH);
            
            // 设置按钮的边距、间隙
            [self setTagButtonMargin:btn fontMargin:fontMargin];
        }
        // 圆角
        btn.layer.cornerRadius = btn.frame.size.height / 2.f;
        btn.layer.masksToBounds = YES;
        
        // 边框
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        btn.layer.borderWidth = 0.5;
        
        //----- 选中事件
        [btn addTarget:self action:@selector(selectdButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        leftX += btn.frame.size.width + marginX;
        
        if (i == _tagArray.count - 1) {
            CGRect frame = self.frame;
            frame.size.height = CGRectGetMaxY(btn.frame);
            self.frame = frame;
        }
    }
    
//     检测按钮状态，最少选中一个
    [self checkButtonState];
}

// 设置按钮的边距、间隙
- (void)setTagButtonMargin:(UIButton*)btn fontMargin:(CGFloat)fontMargin{
    // 按钮自适应
    [btn sizeToFit];
        
    // 重新计算按钮文字左右间隙
    CGRect frame = btn.frame;
    frame.size.width += fontMargin*2;
    frame.size.height = btn.frame.size.height*2;
    btn.frame = frame;
}

// 检测按钮状态，最少选中一个
- (void)checkButtonState{
    int selectCount = 0;
    UIButton *selectedBtn = nil;
    for(int i = 0; i < _tagArray.count; i++){
        UIButton* btn = (UIButton*)[self viewWithTag:100+i];
        if(btn.selected){
            selectCount++;
            selectedBtn = btn;
        }
    }
    if (selectCount == 1) {
        // 只有一个就把这一个给禁用手势
        selectedBtn.userInteractionEnabled = NO;
    } else {
        // 解除禁用手势
        for(int i=0;i < _tagArray.count; i++){
            UIButton* btn = (UIButton*)[self viewWithTag:100+i];
            if(!btn.userInteractionEnabled){
                btn.userInteractionEnabled = YES;
            }
        }
    }
}

// 根据颜色生成UIImage
- (UIImage*)imageWithColor:(UIColor*)color{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 开始画图的上下文
    UIGraphicsBeginImageContext(rect.size);
    
    // 设置背景颜色
    [color set];
    // 设置填充区域
    UIRectFill(CGRectMake(0, 0, rect.size.width, rect.size.height));
    
    // 返回UIImage
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - Event

// 标签按钮点击事件
- (void)selectdButton:(UIButton*)btn{
    if (!self.canSelectedIndex) { return; }
    btn.selected = !btn.selected;
    
    // 检测按钮状态，最少选中一个
    [self checkButtonState];
}


@end
