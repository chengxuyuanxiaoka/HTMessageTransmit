//
//  HTForwardingTarget.m
//  HTMessageTransmit
//
//  Created by 一米阳光 on 17/3/15.
//  Copyright © 2017年 一米阳光. All rights reserved.
//

#import "HTForwardingTarget.h"
#import "HTForwardInvocation.h"

@implementation HTForwardingTarget

//第三步，生成方法签名，然后系统用这个方法签名生成NSInvocation对象
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSString *selectedStr = NSStringFromSelector(aSelector);
    if ([selectedStr isEqualToString:@"setupDatasWithTitle:"]) {
        NSMethodSignature *sign = [NSMethodSignature signatureWithObjCTypes:"v@:@"];
        return sign;
    }
    return [super methodSignatureForSelector:aSelector];
}

//NSInvocation对象封装了最原始的消息和参数
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    HTForwardInvocation *forwardInvocation = [[HTForwardInvocation alloc] init];
    anInvocation.selector =  NSSelectorFromString(@"setMsg:");
    if ([forwardInvocation respondsToSelector:[anInvocation selector]]) {
        [anInvocation invokeWithTarget:forwardInvocation];
    } else {
        [super forwardInvocation:anInvocation];
    }
}

@end













