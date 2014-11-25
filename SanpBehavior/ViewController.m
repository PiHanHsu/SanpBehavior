//
//  ViewController.m
//  SanpBehavior
//
//  Created by PiHan Hsu on 2014/11/25.
//  Copyright (c) 2014年 PiHan Hsu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIAlertViewDelegate>

@property(nonatomic,strong) UIDynamicAnimator *animator;
@property(strong, nonatomic) UIView *alert;
//@property (nonatomic, copy) AlertViewControllerHandler handler;

@property (strong, nonatomic)UIAlertView *alertView;

@end

@implementation ViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)alertButtonPressed:(id)sender {
    
    //system alertView, can't change animation
    self.alertView = [[UIAlertView alloc]initWithTitle:@"Animation" message:@"test" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [self.alertView show];
    
}

- (IBAction)customViewPressed:(id)sender {
    
    //custom alertView with Animation
    self.alert = [[UIView alloc]initWithFrame:CGRectMake(100, 0, 200, 100)];
    self.alert.backgroundColor = [UIColor lightGrayColor];
    self.alert.layer.cornerRadius = 8.f;
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(60, 70, 80, 30)];
    button.backgroundColor =[ UIColor greenColor];
    button.layer.cornerRadius = 5.f;
    
    [button setTitle:@"dissmiss" forState:UIControlStateNormal];
    [self.alert addSubview:button];
    [button addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.alert];
    [self willShow];
}


-(void)willShow {
    // Use UIKit Dynamics to make the alertView appear.
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    UISnapBehavior *snapBehaviour = [[UISnapBehavior alloc] initWithItem:self.alert snapToPoint:self.view.center];
    //控制下落速度,數字越大越慢
    snapBehaviour.damping = .8f;
    [self.animator addBehavior:snapBehaviour];
    
}

-(void)dismiss: (id)sender {
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    UIGravityBehavior *gravityBehaviour = [[UIGravityBehavior alloc] initWithItems:@[self.alert]];
    //控制方向與速度. 0.0f -->正下方, 10.0f 速度 （數字越大越快）
    gravityBehaviour.gravityDirection = CGVectorMake(0.0f, 10.0f);
    [self.animator addBehavior:gravityBehaviour];
    
    UIDynamicItemBehavior *itemBehaviour = [[UIDynamicItemBehavior alloc] initWithItems:@[self.alert]];
    //控制轉動程度,2.0f-->數字越大轉動越大
    [itemBehaviour addAngularVelocity:2.0f forItem:self.alert];
    [self.animator addBehavior:itemBehaviour];
    

}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
