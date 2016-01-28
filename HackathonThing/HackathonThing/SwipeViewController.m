//
//  SwipeViewController.m
//  HackathonThing
//
//  Created by Timothy F. Bowen on 1/27/16.
//  Copyright © 2016 Reigning Champs. All rights reserved.
//

#import "SwipeViewController.h"
#import "HTTPClient.h"
#import <SVProgressHud/SVProgressHud.h>
#import "AthleteModel.h"
#import "AthleteView.h"


@interface SwipeViewController ()

@property (strong) NSArray *clientIDs;
@property (assign) NSInteger lastIndex;
@property (weak) UIView *bottomView;

@end

@implementation SwipeViewController

- (id) init {
    if(self = [super init]){
        self.title = @"Prospects";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lastIndex = 0;
    self.navigationController.navigationBarHidden = YES;
    // You can customize MDCSwipeToChooseView using MDCSwipeToChooseViewOptions.
    MDCSwipeToChooseViewOptions *options = [MDCSwipeToChooseViewOptions new];
    options.likedText = @"Pro!";
    options.likedColor = [UIColor blueColor];
    options.nopeText = @"Rookie";
    options.delegate = self;
    options.onPan = ^(MDCPanState *state){
        if (state.thresholdRatio == 1.f && state.direction == MDCSwipeDirectionLeft) {
            NSLog(@"Let go now to delete the photo!");
        }
    };
    self.options = options;
    [self getAthletes];
    /*
    for(int i = 0; i < 11; i++) {
        MDCSwipeToChooseView *view = [[MDCSwipeToChooseView alloc] initWithFrame:self.view.frame options:options];
        view.backgroundColor = [SwipeViewController randomColor];
        [self.view addSubview:view];
    }*/
}

- (void)getAthletes {
    [SVProgressHUD show];
    [[HTTPClient sharedClient] GET:@"/api/mobile/clients/573275" parameters:[[HTTPClient sharedClient] paramDictForParams:nil] success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        self.clientIDs = [responseObject objectForKey:@"client_ids"];
        [self populateViews];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
}


#pragma mark - MDCSwipeToChooseDelegate Callbacks

// This is called when a user didn't fully swipe left or right.
- (void)viewDidCancelSwipe:(UIView *)view {
    NSLog(@"Couldn't decide, huh?");
}

// Sent before a choice is made. Cancel the choice by returning `NO`. Otherwise return `YES`.
- (BOOL)view:(UIView *)view shouldBeChosenWithDirection:(MDCSwipeDirection)direction {
    return YES;
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
    NSInteger numberOfViews = 25;
    NSLog(@"%u", self.lastIndex + numberOfViews);
    NSLog(@"%u", self.lastIndex);
    NSInteger terminator = self.lastIndex + numberOfViews;
    __block int successes = 0;
    for(int i = self.lastIndex; i <= terminator; i++) {
        if (i >= [self.clientIDs count]) {
            break;
        }
        NSLog(@"%u", i);
        NSNumber *clientID = [self.clientIDs objectAtIndex:i];
        self.lastIndex = i;
        NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:53] forKey:@"coach-id"];
        NSDictionary *paramDict = [[HTTPClient sharedClient] paramDictForParams:dict];
        
        [[HTTPClient sharedClient] GET:[NSString stringWithFormat:@"http://qa.ncsasports.org:80/api/mobile/client/%@", clientID] parameters:paramDict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            AthleteModel *athlete = [[AthleteModel alloc] initWithDictionary:responseObject];
            AthleteView *view = [[AthleteView alloc] initWithAthlete:athlete andOptions:self.options];
            if(self.bottomView == nil) {
                [self.view addSubview:view];
            } else {
                [self.view insertSubview:view belowSubview:self.bottomView];
            }
            self.bottomView = view;
            [SVProgressHUD dismiss];
            successes += 1;
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            NSLog(@"%@", [error localizedDescription]);
            [SVProgressHUD dismiss];
        }];
    }
    [self performSelector:@selector(checkSuccess) withObject:nil afterDelay:3];
}

- (void)checkSuccess {
    NSLog(@"%@", [self.view subviews]);
}

// This is called then a user swipes the view fully left or right.
- (void)view:(UIView *)view wasChosenWithDirection:(MDCSwipeDirection)direction {
    AthleteModel *athlete = [(AthleteView *)view athlete];
    NSString *preference = nil;
    if (direction == MDCSwipeDirectionLeft) {
        preference = @"no_likey";
        NSLog(@"Photo deleted!");
    } else {
        preference = @"likey";
        NSLog(@"Photo saved!");
    }
    NSString *path = [NSString stringWithFormat:@"api/mobile/%@/%@", preference, athlete.clientID];
    [[HTTPClient sharedClient] POST:path parameters:[[HTTPClient sharedClient] paramDictForParams:nil] success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"Worked!!!!");
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"lol that didn't work at all");
        NSLog(@"%@", [error localizedDescription]);
    }];
    self.lastIndex += 1;
    NSNumber *clientID = [self.clientIDs objectAtIndex:self.lastIndex];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:53] forKey:@"coach-id"];
    NSDictionary *paramDict = [[HTTPClient sharedClient] paramDictForParams:dict];
    [[HTTPClient sharedClient] GET:[NSString stringWithFormat:@"http://qa.ncsasports.org:80/api/mobile/client/%@", clientID] parameters:paramDict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        AthleteModel *athlete = [[AthleteModel alloc] initWithDictionary:responseObject];
        AthleteView *view = [[AthleteView alloc] initWithAthlete:athlete andOptions:self.options];
        if(self.bottomView == nil) {
            [self.view addSubview:view];
        } else {
            [self.view insertSubview:view belowSubview:self.bottomView];
        }
        self.bottomView = view;
        [SVProgressHUD dismiss];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@", [error localizedDescription]);
        [SVProgressHUD dismiss];
    }];
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
