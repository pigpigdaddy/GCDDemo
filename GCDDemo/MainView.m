//
//  MainView.m
//  GCDDemo
//
//  Created by 林峰 on 14-9-29.
//  Copyright (c) 2014年 pigpigdaddy. All rights reserved.
//

#import "MainView.h"

#define ROW_COUNT 5
#define COLUMN_COUNT 3
#define IMAGEVIEW_BASE_TAG 100

@implementation MainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initData];
        [self initView];
    }
    return self;
}

- (void)initData
{
    // 存储图片地址的数组
    self.dataArray = [[NSMutableArray alloc] init];
    for (int i = 0; i<ROW_COUNT*COLUMN_COUNT; i++) {
        [self.dataArray addObject:[NSString stringWithFormat:@"http://images.cnblogs.com/cnblogs_com/kenshincui/613474/o_%i.jpg", i]];
    }
}

- (void)initView
{
    // 创建scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:self.scrollView];
    
    // 创建用于显示的UIImageView
    for (int i = 0; i<ROW_COUNT; i++) {
        for (int j = 0; j<COLUMN_COUNT; j++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100*(j%COLUMN_COUNT)+5, 110*(i%ROW_COUNT)+5, 100, 110)];
            imageView.tag = IMAGEVIEW_BASE_TAG+j+i*3;
            [self.scrollView addSubview:imageView];
        }
    }
    self.scrollView.contentSize = CGSizeMake(320, 575);
    
    // 开始加载的按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [UIColor lightGrayColor];
    button.frame = CGRectMake(100, self.bounds.size.height-50,80, 30);
    [button setTitle:@"开始加载" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(loadImage) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}

- (void)downImage:(int)index{
    // 获取图片
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", [self.dataArray objectAtIndex:index]]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    UIImage *image = [UIImage imageWithData:data];
    
    // 获取主线程队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    // 在主线程中更新下载好的图片
    dispatch_sync(mainQueue, ^{
        UIImageView *imageView = (UIImageView *)[self viewWithTag:IMAGEVIEW_BASE_TAG + index];
        imageView.image = image;
    });
}


//- (void)loadImage
//{
//    // 创建一个串行队列
//    dispatch_queue_t serialQueue = dispatch_queue_create("mySerialQueue", DISPATCH_QUEUE_SERIAL);
//    for (int i = 0; i<ROW_COUNT*COLUMN_COUNT; i++) {
//        dispatch_async(serialQueue, ^{
//            [self downImage:i];
//        });
//    }
//}

-(void)loadImage{
    int count=ROW_COUNT*COLUMN_COUNT;
    
    //
    dispatch_queue_t globalQueue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //创建多个线程用于填充图片
    for (int i=0; i<count; ++i) {
        //异步执行队列任务
        dispatch_async(globalQueue, ^{
            [self downImage:i];
        });
    }
}


@end
