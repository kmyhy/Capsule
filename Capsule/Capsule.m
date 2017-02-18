//
//  Capsule.m
//  MultiSelectSwitch
//
//  Created by qq on 2017/2/18.
//  Copyright © 2017年 qq. All rights reserved.
//

#import "Capsule.h"

@implementation Capsule

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self setup];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setup];
    }
    return self;
}
-(instancetype)init{
    CGRect rect = CGRectMake(0, 0, 220, 220);
    self = [self initWithFrame:rect];
    return self;
}
-(void)setup{
    self.bgColor= [UIColor colorWithRed:0xd1/255.0 green:0xd1/255.0 blue:0xd1/255.0 alpha:1];
    self.titles = @[@"大",@"中",@"小"];
    self.selIndex = 01;
    self.fontSize = 14;
    self.textColor= [UIColor whiteColor];
    
    self.thumbColor = [UIColor whiteColor];
    self.thumbRadius = 28;
    self.thumbShadowWidth = 4;
    self.backgroundColor = [UIColor clearColor];
    self.capsuleHeight = 20;
    
    self.fillColor = [UIColor colorWithRed:0x21/255.0 green:0xcb/255.0 blue:0xa7/255.0 alpha:1];
    
    self.baseOffset = -1;//设置基线偏移值，取值为 NSNumber （float）,正值往上偏移，负值往下偏移。但好像只有负值有效
    self.thumbBorderColor = [UIColor lightGrayColor];
    
}
-(void)setSelIndex:(int)selIndex{
    if(selIndex != _selIndex){
        if(selIndex <= 0){
            _selIndex = 0;
        }else if(selIndex >= _titles.count){
            _selIndex = (int)_titles.count -1;
        }else{
            _selIndex = selIndex;
        }
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}
- (void)drawRect:(CGRect)rect {
    [self drawCapsuleWithFrame:rect];
}

- (void)drawCapsuleWithFrame: (CGRect)frame
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    frame = CGRectInset(frame, _thumbShadowWidth, _thumbShadowWidth);
    
    CGFloat textWidth = CGRectGetWidth(frame)/_titles.count;
    UIColor* color = _bgColor;

    //// 绘制胶囊体背景色
    NSShadow* shadow = [[NSShadow alloc] init];
    [shadow setShadowColor: UIColor.darkGrayColor];
    [shadow setShadowOffset: CGSizeMake(1.1, 1.1)];
    [shadow setShadowBlurRadius: _thumbShadowWidth];
    
    
    UIBezierPath* capsule_bgPath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(frame), CGRectGetMidY(frame) - _capsuleHeight/2, CGRectGetWidth(frame),_capsuleHeight) cornerRadius: ceil(_capsuleHeight/2)];
    [color setFill];
    [capsule_bgPath fill];
    
    //// 绘制胶囊体填充色
    CGFloat fillWidth = (_selIndex+1)*textWidth;
    UIBezierPath* capsule_fillPath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(frame), CGRectGetMidY(frame)-_capsuleHeight/2, fillWidth-10,_capsuleHeight) cornerRadius: _capsuleHeight/2];
    [_fillColor setFill];
    [capsule_fillPath fill];
    
    
    //// 绘制文本
    
    for(int i = 0;i < _titles.count;i++){
        
        CGRect textRect = CGRectMake(CGRectGetMinX(frame)+i*textWidth, CGRectGetMidY(frame)-_fontSize/2-4,textWidth,CGRectGetHeight(frame));
        NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
        textStyle.lineBreakMode = NSLineBreakByClipping;
        textStyle.alignment = NSTextAlignmentCenter;
        
        
        NSDictionary* attributes = @{NSFontAttributeName: [UIFont systemFontOfSize: _fontSize], NSForegroundColorAttributeName: _textColor, NSParagraphStyleAttributeName: textStyle,NSBaselineOffsetAttributeName: @(_baseOffset)};
        
        [_titles[i] drawInRect: textRect withAttributes: attributes];
    }
    
    //// 绘制手柄
    CGFloat thumbLeft = fillWidth-_thumbRadius*2;
    if(thumbLeft<CGRectGetMinX(frame)){
        thumbLeft=CGRectGetMinX(frame);
    }
    CGRect thumbRect= CGRectMake(thumbLeft, CGRectGetMidY(frame)-_thumbRadius, _thumbRadius*2, _thumbRadius*2);
    UIBezierPath* thumbPath = [UIBezierPath bezierPathWithOvalInRect: thumbRect];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, [shadow.shadowColor CGColor]);
    [_thumbColor setFill];
    [thumbPath fill];
    CGContextRestoreGState(context);
    
    [_thumbBorderColor setStroke];
    thumbPath.lineWidth = 1;
    [thumbPath stroke];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if(touches.count == 1){
        CGPoint touchPos = [[touches anyObject] locationInView:self];
        
        int i = touchPos.x/(CGRectGetWidth(self.frame)/_titles.count);
        
        self.selIndex = i;
        [self setNeedsDisplay];

    }
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if(touches.count == 1){
        CGPoint touchPos = [[touches anyObject] locationInView:self];
        
        int i = touchPos.x/(CGRectGetWidth(self.frame)/_titles.count);
        
        self.selIndex = i;
        [self setNeedsDisplay];
    }
}

@end
