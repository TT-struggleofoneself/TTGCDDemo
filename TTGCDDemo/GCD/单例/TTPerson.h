//
//  XMGPerson.h
//  10-掌握-单粒模式
//
//  Created by xiaomage on 15/7/8.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTPerson : NSObject
/** 名字 */
@property (nonatomic, strong) NSString *name;

+ (instancetype)sharedPerson;
@end
