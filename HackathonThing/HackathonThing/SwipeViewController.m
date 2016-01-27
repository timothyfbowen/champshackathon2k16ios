//
//  SwipeViewController.m
//  HackathonThing
//
//  Created by Timothy F. Bowen on 1/27/16.
//  Copyright © 2016 Reigning Champs. All rights reserved.
//

#import "SwipeViewController.h"
#import <MDCSwipeToChoose/MDCSwipeToChoose.h>
#import "HTTPClient.h"
#import <SVProgressHud/SVProgressHud.h>


@interface SwipeViewController ()

@property (strong) NSArray *clientIDs;
@property (assign) NSInteger lastIndex;

@end

@implementation SwipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    // You can customize MDCSwipeToChooseView using MDCSwipeToChooseViewOptions.
    MDCSwipeToChooseViewOptions *options = [MDCSwipeToChooseViewOptions new];
    options.likedText = @"Dank";
    options.likedColor = [UIColor blueColor];
    options.nopeText = @"Stale";
    options.onPan = ^(MDCPanState *state){
        if (state.thresholdRatio == 1.f && state.direction == MDCSwipeDirectionLeft) {
            NSLog(@"Let go now to delete the photo!");
        }
    };
    [self getAthletes];
}

- (void)getAthletes {
    [[HTTPClient sharedClient] GET:@"/api/mobile/clients/573275" parameters:[[HTTPClient sharedClient] paramDictForParams:nil] success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"%@", responseObject);
        NSNumber *clientID = [[responseObject objectForKey:@"client_ids"] objectAtIndex:0];
        NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:53] forKey:@"coach-id"];
        NSDictionary *paramDict = [[HTTPClient sharedClient] paramDictForParams:dict];
        [[HTTPClient sharedClient] GET:[NSString stringWithFormat:@"http://qa.ncsasports.org:80/api/mobile/client/%@", clientID] parameters:paramDict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            self.clientIDs = [responseObject objectForKey:@"client_ids"];
            NSLog(@"%@", responseObject);
            [self populateViews];
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            NSLog(@"%@", [error localizedDescription]);
        }];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@", [error localizedDescription]);
        
    }];
}

- (NSArray *)fakeAthletes {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    return array;
}

#pragma mark - MDCSwipeToChooseDelegate Callbacks

// This is called when a user didn't fully swipe left or right.
- (void)viewDidCancelSwipe:(UIView *)view {
    NSLog(@"Couldn't decide, huh?");
}

// Sent before a choice is made. Cancel the choice by returning `NO`. Otherwise return `YES`.
- (BOOL)view:(UIView *)view shouldBeChosenWithDirection:(MDCSwipeDirection)direction {
    if (direction == MDCSwipeDirectionLeft) {
        return YES;
    } else {
        // Snap the view back and cancel the choice.
        [UIView animateWithDuration:0.16 animations:^{
            view.transform = CGAffineTransformIdentity;
            view.center = [view superview].center;
        }];
        return NO;
    }
}

- (void)populateViews {
    
}

// This is called then a user swipes the view fully left or right.
- (void)view:(UIView *)view wasChosenWithDirection:(MDCSwipeDirection)direction {
    if (direction == MDCSwipeDirectionLeft) {
        NSLog(@"Photo deleted!");
    } else {
        NSLog(@"Photo saved!");
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"auth-token"];
    [[HTTPClient sharedClient] setAuthToken:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
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
