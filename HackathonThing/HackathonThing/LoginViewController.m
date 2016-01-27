//
//  LoginViewController.m
//  HackathonThing
//
//  Created by Timothy F. Bowen on 1/27/16.
//  Copyright © 2016 Reigning Champs. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)init {
    if (self = [super init]){
        UIView* baseView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                    0,
                                                                    [UIScreen mainScreen].bounds.size.width,
                                                                    [[UIScreen mainScreen] bounds].size.height)];
        self.view = baseView;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
