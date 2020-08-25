//
//  RenderView.h
//  MetalBasicBuffer
//
//  Created by admin on 2020/8/25.
//  Copyright © 2020 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
//导入MetalKit工具包
@import MetalKit;
NS_ASSUME_NONNULL_BEGIN

@interface RenderView : NSObject<MTKViewDelegate>
//初始化一个MTKView
- (nonnull instancetype)initWithMetalKitView:(nonnull MTKView *)mtkView;
@end

NS_ASSUME_NONNULL_END
