//
//  ViewController.m
//  MetalBasicBuffer
//
//  Created by admin on 2020/8/25.
//  Copyright © 2020 admin. All rights reserved.
//

#import "ViewController.h"
#import "RenderView.h"
@interface ViewController ()
{
    MTKView *_view;
    RenderView *_renderer;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.获取MTKView
    _view = [[MTKView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) device:MTLCreateSystemDefaultDevice()];
    
    [self.view addSubview:_view];
    //一个MTLDevice 对象就代表这着一个GPU,通常我们可以调用方法MTLCreateSystemDefaultDevice()来获取代表默认的GPU单个对象.
    if(!_view.device)
    {
        NSLog(@"Metal is not supported on this device");
        return;
    }
    
    //2.创建CCRender
    _renderer = [[RenderView alloc] initWithMetalKitView:_view];
    if(!_renderer)
    {
        NSLog(@"Renderer failed initialization");
        return;
    }
    //用视图大小初始化渲染器
    [_renderer mtkView:_view drawableSizeWillChange:_view.drawableSize];
    //设置MTKView代理
    _view.delegate = _renderer;
}


@end
