//
//  ViewController.h
//  HackathonThing
//
//  Created by Timothy F. Bowen on 1/27/16.
//  Copyright © 2016 Reigning Champs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak) UITextField *loginTextField;
@property (weak) UITextField *passwordTextField;
@property (weak) UIButton *loginButton;
@property (nonatomic, assign) BOOL viewMovedUp;

@end

