//
//  Capsule.h
//  MultiSelectSwitch
//
//  Created by qq on 2017/2/18.
//  Copyright © 2017年 qq. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface Capsule : UIControl
@property(strong,nonatomic)IBInspectable UIColor* bgColor;
@property(strong,nonatomic)IBInspectable UIColor* fillColor;
@property(strong,nonatomic)IBInspectable UIColor* textColor;
@property(strong,nonatomic)IBInspectable UIColor* thumbColor;
@property(strong,nonatomic)IBInspectable UIColor* thumbShadowColor;
@property(assign,nonatomic)IBInspectable CGFloat thumbRadius;
@property(assign,nonatomic)IBInspectable CGFloat thumbShadowWidth;
@property(strong,nonatomic)IBInspectable UIColor* thumbBorderColor;


@property(assign,nonatomic)IBInspectable CGFloat fontSize;
@property(assign,nonatomic)IBInspectable CGFloat capsuleHeight;
@property(assign,nonatomic)IBInspectable int selIndex;
@property(assign,nonatomic)IBInspectable CGFloat baseOffset;
@property(strong,nonatomic)NSArray<NSString*>* titles;
@end
