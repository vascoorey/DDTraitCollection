//
//  DDTraitCollectionObserver.h
//  DDTraitCollection
//
//  Created by Vasco d'Orey on 25/03/15.
//  Copyright (c) 2015 Delta Dog. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDTraitCollection;

@interface DDTraitCollectionObserver : NSObject

#pragma mark -
#pragma mark Singleton Accessor

+ (instancetype)sharedObserver;

#pragma mark -
#pragma mark Properties

@property (nonatomic, strong) DDTraitCollection *currentTraitCollection;

#pragma mark -
#pragma mark Public API

- (void)addObserver:(NSObject *)observer;

@end
