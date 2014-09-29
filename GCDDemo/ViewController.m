//
//  ViewController.m
//  GCDDemo
//
//  Created by 林峰 on 14-9-29.
//  Copyright (c) 2014年 pigpigdaddy. All rights reserved.
//

#import "ViewController.h"
#import "MainView.h"

@interface ViewController ()

@property (nonatomic, strong)MainView *mainView;

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MainView *view = [[MainView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
