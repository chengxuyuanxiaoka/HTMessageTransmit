//
//  HTResolveMethod.m
//  HTMessageTransmit
//
//  Created by 一米阳光 on 17/3/15.
//  Copyright © 2017年 一米阳光. All rights reserved.
//

#import "HTResolveMethod.h"
#import <objc/runtime.h>
#import "HTForwardingTarget.h"

@implementation HTResolveMethod
@dynamic name;

/**
 *  第一步:动态方法解析，征询接收者，看其是否能动态添加方法，来处理当前这个未知的选择子
 *  ①为name动态添加set和get方法
 *  ②setupDatasWithTitle:为动态添加方法。进入第二步，启动完整的消息转发机制
 *  ③未能为子类HTResolveSonMethod动态添加tapNextButtonWithTag:方法实现，进入第二步，启动完整的消息转发机制
 *
 */
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSString *selectorStr = NSStringFromSelector(sel);
    /**
     *  i(类型为int)
     *  v(类型为void)
     *  @(类型为id)
     *  :(类型为SEL)
     */
    if ([selectorStr isEqualToString:@"setName:"]) {
        class_addMethod(self, sel, (IMP)autoDictionarySetter, "v@:@");
    } else if ([selectorStr isEqualToString:@"name"]) {
        class_addMethod(self, sel, (IMP)autoDictionaryGetter, "@@:");
    }
    return [super resolveInstanceMethod:sel];
}

void autoDictionarySetter(id self,SEL _cmd,id value) {
    NSLog(@"name的set方法==%@",value);
}

id autoDictionaryGetter(id self,SEL _cmd) {
    return @"name的get方法";
}

/**
 *  第二歩:进入消息转发流程重定向
 *  ①将setupDatasWithTitle:转发到HTForwardingTarget类
 *  ②未找到能实现tapNextButtonWithTag:方法的对象，直接进入本类的第三歩
 */
- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSString *selectorStr = NSStringFromSelector(aSelector);
    if ([selectorStr isEqualToString:@"setupDatasWithTitle:"]) {
        HTForwardingTarget *forwardingTarget = [HTForwardingTarget new];
        return forwardingTarget;
    }
    return [super forwardingTargetForSelector:aSelector];
}

//第三步:生成方法签名，然后系统用这个方法签名生成NSInvocation对象，进入本类第四步
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *sign = [NSMethodSignature signatureWithObjCTypes:"v@:"];
    return sign;
}

//第四步:NSInvocation对象封装了最原始的消息和参数。
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [super forwardInvocation:anInvocation];
}

//第五步:抛出异常
- (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSString *selectedStr = NSStringFromSelector(aSelector);
    [self crashHandle:selectedStr];
}

- (void)crashHandle:(NSString *)selName {
    if (self.crashDelegate && [self.crashDelegate respondsToSelector:@selector(resolveMethodCrashWithSelName:)]) {
        [self.crashDelegate resolveMethodCrashWithSelName:selName];
    }
}

@end
