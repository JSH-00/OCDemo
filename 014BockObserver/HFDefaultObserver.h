//
//  HFDefaultObserver.h
//  DroneTutorialPage
//
//  Created by JSH on 2020/10/3.
//  Copyright © 2020 JSH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/message.h>
#import "NSObject+BlockObserver.h"
NS_ASSUME_NONNULL_BEGIN

@interface HFDefaultObserver : NSObject
@property (nonatomic, copy) HFKVOblock kvoBlock;
@property (nonatomic, copy) HFNotificationBlock notificationBlock;
@end

NS_ASSUME_NONNULL_END
