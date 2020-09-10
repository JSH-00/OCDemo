//
//  protocolDelegate.h
//  helloTest
//
//  Created by JSH on 2020/7/16.
//  Copyright © 2020 JSH. All rights reserved.
//

#ifndef protocolDelegate_h
#define protocolDelegate_h

//1.new file -->Objective-C File-->选择Protocol，创建Protocol文件
//protocol文件只有.h文件，只声明方法。
#import <Foundation/Foundation.h>

@protocol protocolDelegate <NSObject>
@required
//必须实现的方法
- (void)eat;
- (void)drink;

// 可选实现的方法
@optional
- (void)readBook;
- (void)writeCode;
@end

#endif /* protocolDelegate_h */
