//
//  NSString+LSExt.h
//
//  Created by song on 15/8/25.
//  Copyright © 2015年 song. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Size)

//计算字符串尺寸
-(CGSize)sizeOfTextWithMaxSize:(CGSize)maxSize font:(UIFont*)font;
+(CGSize)sizeWithText:(NSString*)text maxSize:(CGSize)maxSize font:(UIFont*)font;

//计算文件或目录大小
-(long long)fileSizeWithFilePath;

@end
