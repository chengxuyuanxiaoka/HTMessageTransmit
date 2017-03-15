//
//  NSArray+PreventCrossTheBorder.m
//  HTMessageTransmit
//
//  Created by 一米阳光 on 17/3/14.
//  Copyright © 2017年 一米阳光. All rights reserved.
//

#import "NSArray+PreventCrossTheBorder.h"
#import <objc/runtime.h>

@implementation NSArray (PreventCrossTheBorder)

- (void)prevent_exchangeIMP {
    Method originalMethod = class_getInstanceMethod([NSArray class], @selector(objectAtIndex:));
    Method swappedMethod = class_getInstanceMethod([self class], @selector(prevent_objectAtIndex:));
    method_exchangeImplementations(originalMethod, swappedMethod);
    NSString *strs = NSStringFromSelector(@selector(objectAtIndex:));
    NSArray *abc = @[@"dg"];
    [abc objectAtIndex:0];
}

- (id)prevent_objectAtIndex:(NSUInteger)index {
    NSLog(@"卧槽，数组崩溃了");
    return [self prevent_objectAtIndex:index];
}

@end


























