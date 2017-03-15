//
//  HTResolveMethod.h
//  HTMessageTransmit
//
//  Created by 一米阳光 on 17/3/15.
//  Copyright © 2017年 一米阳光. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 声明协议，当HTResolveMethod或其子类自定义方法未实现时，保证程序不崩溃 ，并在控制台输出未实现的方法*/
@protocol ResolveMethodCrashDelegate <NSObject>

- (void)resolveMethodCrashWithSelName:(NSString *)selName;

@end

@interface HTResolveMethod : NSObject

@property (nonatomic, weak) id<ResolveMethodCrashDelegate> crashDelegate;
@property (nonatomic, copy) NSString *name;

- (void)setupDatasWithTitle:(NSString *)title;

@end
