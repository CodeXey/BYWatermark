//
//  UIImage+WaterMark.h
//  CPPCC
//
//  Created by Apple on 2018/12/29.
//  Copyright © 2018 Apple Inc. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WaterMarkPosition) {
    WaterMarkPositionLeftTop,
    WaterMarkPositionRightTop,
    WaterMarkPositionLeftBottom,
    WaterMarkPositionRightBottom,
    WaterMarkPositionCenter
};

@interface UIImage (WaterMark)

/**
 传入图片和文字,生成添加水印的图片

 @param image 传入的水印图片
 @param imgPosition 水印图片的位置
 @param imgProportion 水印图片与背景图片的宽的比例
 @param text 传入的水印文字
 @param textPosition 水印文字的位置
 @param textColor 水印文字的颜色
 @return 添加了水印之后的图片
 */
-(UIImage *)addWaterMarkImage:(UIImage *)image
                imagePosition:(WaterMarkPosition)imgPosition
         imageWidthProportion:(CGFloat)imgProportion
                         text:(NSString *)text
                 textPosition:(WaterMarkPosition)textPosition
                     textFont:(UIFont *)font
                    textColor:(UIColor *)textColor;

-(UIImage *)addWaterMarkImage:(UIImage *)image
                imagePosition:(WaterMarkPosition)imgPosition
         imageWidthProportion:(CGFloat)imgProportion;

-(UIImage *)addWaterMarkText:(NSString *)text
                textPosition:(WaterMarkPosition)textPosition
                    textFont:(UIFont *)font
                   textColor:(UIColor *)textColor;

@end
