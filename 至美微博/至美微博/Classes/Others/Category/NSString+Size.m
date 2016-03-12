//
//  NSString+LSExt.m
//  QQ聊天界面
//
//  Created by song on 15/8/25.
//  Copyright © 2015年 song. All rights reserved.
//


@implementation NSString (Size)
-(CGSize)sizeOfTextWithMaxSize:(CGSize)maxSize font:(UIFont*)font
{
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}
+(CGSize)sizeWithText:(NSString*)text maxSize:(CGSize)maxSize font:(UIFont*)font
{
    return [text sizeOfTextWithMaxSize:maxSize font:font];
}
-(long long)fileSizeWithFilePath
{
    long long totalSize=0;
    NSFileManager *fileManger=[NSFileManager  defaultManager];
    //path为空
    if (self==nil) return totalSize;
    BOOL isDirectory=NO;
    BOOL exists=YES;
    exists=[fileManger fileExistsAtPath:self isDirectory:&isDirectory];
    //文件或目录不存在
    if (!exists) return totalSize;
    if (isDirectory) {//是目录
        NSArray *paths=[fileManger contentsOfDirectoryAtPath:self error:NULL];
        for (NSString *subpath in paths) {
            NSString *completeSubpath=[self stringByAppendingPathComponent:subpath];
            //递归
            totalSize+=[completeSubpath fileSizeWithFilePath];
            
        }
    }else {//是文件
        NSDictionary *dict=[fileManger attributesOfItemAtPath:self error:NULL];
        long long size=(long long)dict[NSFileSize];
        totalSize+=size;
    }
    return totalSize/1000.0/1000.0;
}

@end
