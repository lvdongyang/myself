//
//  UIImage+Unit.m
//  NewTestPro
//
//  Created by 吕东阳 on 2018/11/1.
//  Copyright © 2018 吕东阳. All rights reserved.
//

#import "UIImage+Unit.h"

#import <objc/message.h>

@implementation UIImage (Unit)


/** load方法: 把类加载进内存的时候调用,只会调用一次 方法应先交换，再去调用 */
+ (void)load {
    // 1.获取 imageNamed方法地址 // class_getClassMethod（获取某个类的方法）
    Method imageNamedMethod = class_getClassMethod(self, @selector(imageNamed:));
    // 2.获取 ln_imageNamed方法地址
    Method ln_imageNamedMethod = class_getClassMethod(self, @selector(ln_imageNamed:));
    // 3.交换方法地址，相当于交换实现方式;「method_exchangeImplementations 交换两个方法的实现」
    method_exchangeImplementations(imageNamedMethod, ln_imageNamedMethod);
    
}
    
    

/** 看清楚下面是不会有死循环的 调用 imageNamed => ln_imageNamed 调用 ln_imageNamed => imageNamed */ // 加载图片 且 带判断是否加载成功
+ (UIImage *)ln_imageNamed:(NSString *)name {
    UIImage *image = [UIImage ln_imageNamed:name];
    if (image) {
        NSLog(@"runtime添加额外功能--加载成功");
        
    }
    else {
        NSLog(@"runtime添加额外功能--加载失败");
        
    }
    return image;
    
}


@end
