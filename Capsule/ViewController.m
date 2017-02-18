//
//  ViewController.m
//  MultiSelectSwitch
//
//  Created by qq on 2017/2/18.
//  Copyright © 2017年 qq. All rights reserved.
//

#import "ViewController.h"
#import "Capsule.h"

@interface ViewController ()


@property (weak, nonatomic) IBOutlet Capsule *capsule;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Interface Builder 创建方式
    
    // 代码创建方式
    
    Capsule * aCapsule = [[Capsule alloc]initWithFrame:CGRectMake(62, 180, 250, 86)];
    aCapsule.thumbRadius = 37.5;
    aCapsule.capsuleHeight = 62;
    aCapsule.fillColor = [UIColor redColor];
    aCapsule.titles = @[@"静音",@"低",@"中",@"高"];
    [aCapsule addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview: aCapsule];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)valueChanged:(Capsule*)sender{
    NSLog(@"Capsule value changed:%d",sender.selIndex);
}
@end
