//
//  ViewController.m
//  HackathonThing
//
//  Created by Timothy F. Bowen on 1/27/16.
//  Copyright © 2016 Reigning Champs. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "HTTPClient.h"
#import <MDCSwipeToChoose/MDCSwipeToChoose.h>
#import "SwipeViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Login";
    double height = (self.view.frame.size.height / 3.0) * 2.0;
    double add = 40.0;
    self.view.backgroundColor = [UIColor whiteColor];
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, height, self.view.frame.size.width - 40, 30)];
    //textField.backgroundColor = [UIColor redColor];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.view addSubview:textField];
    self.loginTextField = textField;
    height += add;
    
    UITextField *password = [[UITextField alloc] initWithFrame:CGRectMake(20, height, self.view.frame.size.width - 40, 30)];
    [self.view addSubview:password];
    password.borderStyle = UITextBorderStyleRoundedRect;
    password.autocapitalizationType = UITextAutocapitalizationTypeNone;
    password.autocorrectionType = UITextAutocorrectionTypeNo;
    password.secureTextEntry = YES;
    self.passwordTextField = password;
    
    height += add;
    
    UIButton *login = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    login.frame = CGRectMake(self.view.frame.size.width / 2.0 - 80, height, 160, 30);
    [login setTitle:@"Login" forState:UIControlStateNormal];
    //login.backgroundColor = [UIColor redColor];
    login.titleLabel.textColor = [UIColor blackColor];
    
    [self.view addSubview:login];
    [login addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
}

- (void)login {
    [self.view resignFirstResponder];
    NSDictionary *params = [[HTTPClient sharedClient] paramDictForParams:[NSDictionary dictionaryWithObjectsAndKeys:self.loginTextField.text, @"email_or_username", self.passwordTextField.text, @"password", nil]];
    [[HTTPClient sharedClient] POST:@"api/mobile/coach_session" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[HTTPClient sharedClient] setAuthToken:[responseObject objectForKey:@"auth_token"]];
        [self pushMainView];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@", [error localizedDescription]);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@", [error localizedDescription]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];
    //NSString *login = self.loginTextField.text;
    
}
- (void)pushMainView {
    [self.navigationController pushViewController:[[SwipeViewController alloc] init] animated:YES];
}

#define kOFFSET_FOR_KEYBOARD 220.0

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        for (UIView *view in self.view.subviews) {
            if (view.isFirstResponder && [view isKindOfClass:[UITextField class]]) {
                return;
            }
        }
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{

    //move the main view, so that the keyboard does not hide it.
    if  (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }

}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
    if([[HTTPClient sharedClient] authToken]) {
        [self pushMainView];
    }
    [super viewWillAppear:animated];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
