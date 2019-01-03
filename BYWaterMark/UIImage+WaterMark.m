//
//  UIImage+WaterMark.m
//  CPPCC
//
//  Created by Apple on 2018/12/29.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

#import "UIImage+WaterMark.h"

@implementation UIImage (WaterMark)

-(UIImage *)addWaterMarkImage:(UIImage *)image
                imagePosition:(WaterMarkPosition)imgPosition
         imageWidthProportion:(CGFloat)imgProportion
                         text:(NSString *)text
                 textPosition:(WaterMarkPosition)textPosition
                     textFont:(UIFont *)font
                    textColor:(UIColor *)textColor {
    if (!image) {
        return [self addWaterMarkText:text textPosition:textPosition textFont:font textColor:textColor];
    } else if (!text) {
        return [self addWaterMarkImage:image imagePosition:imgPosition imageWidthProportion:imgProportion];
    } else {
        UIImage *waterImage = [self addWaterMarkImage:image imagePosition:imgPosition imageWidthProportion:imgProportion];
        return [waterImage addWaterMarkText:text textPosition:textPosition textFont:font textColor:textColor];
    }
}

-(UIImage *)addWaterMarkImage:(UIImage *)image imagePosition:(WaterMarkPosition)imgPosition imageWidthProportion:(CGFloat)imgProportion {
    CGSize size = self.size;
    CGFloat waterImageWidth = size.width/imgProportion;
    CGFloat waterImageHeight = image.size.height * (waterImageWidth/image.size.width);
    CGRect waterRect = CGRectZero;
    switch (imgPosition) {
        case WaterMarkPositionLeftTop:
            waterRect = CGRectMake(5, 5, waterImageWidth, waterImageHeight);
            break;
            
        case WaterMarkPositionRightTop:
            waterRect = CGRectMake(size.width-waterImageWidth-5, 5, waterImageWidth, waterImageHeight);
            break;
            
        case WaterMarkPositionLeftBottom:
            waterRect = CGRectMake(5, size.height-waterImageHeight-5, waterImageWidth, waterImageHeight);
            break;
            
        case WaterMarkPositionRightBottom:
            waterRect = CGRectMake(size.width-waterImageWidth-5, size.height-waterImageHeight-5, waterImageWidth, waterImageHeight);
            
        default:
            waterRect = CGRectMake(size.width/2-waterImageWidth/2, size.height/2-waterImageHeight/2, waterImageWidth, waterImageHeight);
            break;
    }
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0) {
        UIGraphicsBeginImageContextWithOptions([self size], NO, 0.0);
    }
#else
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 4.0) {
        UIGraphicsBeginImageContext([self size]);
    }
#endif
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    [image drawInRect:waterRect];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

-(UIImage *)addWaterMarkText:(NSString *)text
                textPosition:(WaterMarkPosition)textPosition
                    textFont:(UIFont *)font
                   textColor:(UIColor *)textColor {
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    UIGraphicsBeginImageContext(self.size);
    [self drawInRect:CGRectMake(0, 0, width, height)];
    UIFont *waterMarkFont = [UIFont fontWithName:font.fontName size:font.pointSize * width/[UIScreen mainScreen].bounds.size.width];
    NSDictionary *attribution = @{NSForegroundColorAttributeName:textColor?:[UIColor blackColor], NSFontAttributeName:waterMarkFont};
    CGSize textSize = [text boundingRectWithSize:self.size options:NSStringDrawingUsesLineFragmentOrigin attributes:attribution context:nil].size;
    CGRect textRect = CGRectZero;
    switch (textPosition) {
        case WaterMarkPositionLeftTop:
            textRect = CGRectMake(5, 5, textSize.width, textSize.height);
            break;
        
        case WaterMarkPositionLeftBottom:
            textRect = CGRectMake(5, height-5-textSize.height, textSize.width, textSize.height);
            break;
        
        case WaterMarkPositionRightTop:
            textRect = CGRectMake(width-textSize.width-5, 5, textSize.width, textSize.height);
            break;
            
        case WaterMarkPositionRightBottom:
            textRect = CGRectMake(width-textSize.width-5, height-5-textSize.height, textSize.width, textSize.height);
            break;
            
        default:
            textRect = CGRectMake(width/2-textSize.width/2, height/2-textSize.height/2, textSize.width, textSize.height);
            break;
    }
    [text drawInRect:textRect withAttributes:attribution];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return resultImage;
}


@end
