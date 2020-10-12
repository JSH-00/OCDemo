//
//  BlockObserver.h
//  DroneTutorialPage
//
//  Created by JSH on 2020/10/3.
//  Copyright © 2020 JSH. All rights reserved.
//

#ifndef BlockObserver_h
#define BlockObserver_h

#import <Foundation/Foundation.h>

typedef void(^HFKVOblock)(__weak id object, id oldValue, id newValue);
typedef void(^HFNotificationBlock)(NSNotification *notification);
@interface NSObject (BlockObserver)

- (void)HF_addObserverForKeyPath:(NSString *)keyPath block:(HFKVOblock)block;
- (void)HF_removeObserverBlocksForKeyPath:(NSString *)keyPath;
- (void)HF_removeAllObserverBlocks;

- (void)HF_addNotificationForName:(NSString *)name block:(HFNotificationBlock)block;
- (void)HF_removeNotificationBlocksForName:(NSString *)name;
- (void)HF_removeAllNotificationBlocks;

@end
#endif /* BlockObserver_h */
