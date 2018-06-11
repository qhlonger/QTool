//
//  ViewController.m
//  QTool
//
//  Created by pingguo on 2018/5/13.
//  Copyright © 2018年 hl. All rights reserved.
//

#import "ViewController.h"
#import "NotiDotManager.h"
#import "UIView+NotiDot.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *main;
@property (weak, nonatomic) IBOutlet UIButton *mine;
@property (weak, nonatomic) IBOutlet UIButton *msg;
@property (weak, nonatomic) IBOutlet UIButton *mine1;
@property (weak, nonatomic) IBOutlet UIButton *mine2;
@property (weak, nonatomic) IBOutlet UIButton *msg2;
@property (weak, nonatomic) IBOutlet UIButton *msg1;
@property(nonatomic, strong) NotiDotManager *mgr;

@property(nonatomic, weak) UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mgr = [NotiDotManager sharedManager];
    
    self.main.q_notiNode = [self.mgr getNodeByID:@"main"];
    self.msg.q_notiNode = [self.mgr getNodeByID:@"msg"];
    self.msg1.q_notiNode = [self.mgr getNodeByID:@"msg1"];
    self.msg2.q_notiNode = [self.mgr getNodeByID:@"msg2"];
    self.mine1.q_notiNode = [self.mgr getNodeByID:@"mine1"];
    self.mine2.q_notiNode = [self.mgr getNodeByID:@"mine2"];
    self.mine.q_notiNode = [self.mgr getNodeByID:@"mine"];
    
    NSLog(@"%d",self.main.q_notiNode.count);
    NSLog(@"%d",self.msg.q_notiNode.count);
    NSLog(@"%d",self.msg1.q_notiNode.count);
    NSLog(@"%d",self.msg2.q_notiNode.count);
    NSLog(@"%d",self.mine1.q_notiNode.count);
    NSLog(@"%d",self.mine2.q_notiNode.count);
    NSLog(@"%d",self.mine.q_notiNode.count);
    
}
- (IBAction)add:(id)sender {
    self.btn.q_notiNode.count++;
    [[NotiDotManager sharedManager]refreshNode:self.btn.q_notiNode];
}
- (IBAction)sub:(id)sender {
    self.btn.q_notiNode.count > 0 ? self.btn.q_notiNode.count--:nil;
    [[NotiDotManager sharedManager]refreshNode:self.btn.q_notiNode];
//    [self.btn updateDot];
}


- (IBAction)btnC:(id)sender {
    self.btn = sender;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
