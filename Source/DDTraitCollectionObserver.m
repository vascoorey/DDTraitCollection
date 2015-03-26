//
//  DDTraitCollectionObserver.m
//  DDTraitCollection
//
//  Created by Vasco d'Orey on 25/03/15.
//  Copyright (c) 2015 Delta Dog. All rights reserved.
//

#import "DDTraitCollectionObserver.h"
#import "DDTraitCollection.h"

@interface DDTraitCollectionObserver ()

@property (nonatomic, strong) NSMapTable *observers;

@end

@implementation DDTraitCollectionObserver

#pragma mark -
#pragma mark Initialization

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }

    _observers = [NSMapTable strongToWeakObjectsMapTable];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidChangeOrientation:)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];

    [self performSelector:@selector(refreshCurrentTraitCollection) withObject:nil afterDelay:0];

    return self;
}

#pragma mark -
#pragma mark Singleton Accessor

+ (instancetype)sharedObserver {
    static id _shared = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{ _shared = [[self alloc] init]; });

    return _shared;
}

#pragma mark -
#pragma mark Public API

- (void)addObserver:(NSObject *)observer {
    NSParameterAssert([observer respondsToSelector:@selector(traitCollectionDidChange:)]);

    typeof(observer) __weak weakObserver = observer;
    NSUInteger observerCount = self.observers.count;

    [self.observers setObject:weakObserver forKey:@(observerCount)];
}

#pragma mark -
#pragma mark Notifications

- (void)applicationDidChangeOrientation:(NSNotification *)notification {
    [self refreshCurrentTraitCollection];
}

#pragma mark -
#pragma mark Private

- (void)refreshCurrentTraitCollection {
    DDTraitCollection *previousTraitCollection = self.currentTraitCollection;

    DDTraitCollection *newTraitCollection = [DDTraitCollection traitCollectionForCurrentEnvironment];

    if (![previousTraitCollection containsTraitsInCollection:(UITraitCollection *)newTraitCollection]) {
        self.currentTraitCollection = newTraitCollection;

        [self notifyObserversOfChangeFromPreviousTraitCollection:(UITraitCollection *)previousTraitCollection];
    }
}

- (void)notifyObserversOfChangeFromPreviousTraitCollection:(UITraitCollection *)traitCollection {
    NSEnumerator *objectEnumerator = [self.observers objectEnumerator];

    for (NSObject<UITraitEnvironment> *observer in objectEnumerator) {
        [observer traitCollectionDidChange:traitCollection];
    }
}

@end
