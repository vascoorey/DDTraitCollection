//
//  ViewController.m
//  DDTraitCollection
//
//  Created by Vasco d'Orey on 23/03/15.
//  Copyright (c) 2015 Delta Dog. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+DDTraitCollection.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%@", self.traitCollection);
    [self dd_registerForTraitCollectionUpdates];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    NSLog(@"Old: %@", previousTraitCollection);
    NSLog(@"New: %@", self.traitCollection);
}

@end
