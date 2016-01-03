//
//  BFBaseRecordCell.m
//  BFViewFactory
//
//  Created by readboy1 on 15/12/25.
//  Copyright © 2015年 Readboy. All rights reserved.
//

#import "BFBaseRecordCell.h"

@implementation BFBaseRecordCell

- (void)setupCellModel:(BFCellModel *)model{
};


- (UIImage *)clipImage:(UIImage *)image fromImage:(UIImage *)shapeImg {
    
    CGImageRef imageRef = shapeImg.CGImage;
    
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(imageRef), CGImageGetHeight(imageRef), CGImageGetBitsPerComponent(imageRef), CGImageGetBitsPerPixel(imageRef), CGImageGetBytesPerRow(imageRef), CGImageGetDataProvider(imageRef), NULL, false);
    
    CGImageRef masked = CGImageCreateWithMask(image.CGImage, mask);
    
    return [UIImage imageWithCGImage:masked];
}

@end
