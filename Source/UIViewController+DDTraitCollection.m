//
//  UIViewController+DDTraitCollection.m
//  DDTraitCollection
//
//  Created by Vasco d'Orey on 23/03/15.
//  Copyright (c) 2015 Delta Dog. All rights reserved.
//

#import "UIViewController+DDTraitCollection.h"
#import "DDTraitCollection.h"
#import "DDTraitCollectionObserver.h"
#import <objc/runtime.h>

#pragma mark -
#pragma mark UIViewController (DDTraitCollection)

@implementation UIViewController (DDTraitCollection)

#pragma mark -
#pragma mark Load

+ (void)load {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [DDTraitCollectionObserver sharedObserver];

            Class class = [self class];

            [self swizzleClass:class originalSelector:@selector(traitCollection) swizzledSelector:@selector(dd_traitCollection)];
        });
    }
}

+ (void)swizzleClass:(Class)theClass originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector {
    Method originalMethod = class_getInstanceMethod(theClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(theClass, swizzledSelector);

    BOOL didAddMethod = class_addMethod(theClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));

    if (didAddMethod) {
        class_replaceMethod(theClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else { method_exchangeImplementations(originalMethod, swizzledMethod); }
}

+ (DDTraitCollectionObserver *)traitObserver {
    return objc_getAssociatedObject(self, @selector(traitObserver));
}

#pragma mark -
#pragma mark Swizzled Methods

- (UITraitCollection *)dd_traitCollection {
    return (UITraitCollection *)[DDTraitCollectionObserver sharedObserver].currentTraitCollection;
}

#pragma mark -
#pragma mark Public API

- (void)dd_registerForTraitCollectionUpdates {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        BOOL isRegistered = objc_getAssociatedObject(self, @selector(dd_registerForTraitCollectionUpdates)) != nil;

        if (!isRegistered) {
            [[DDTraitCollectionObserver sharedObserver] addObserver:self];

            objc_setAssociatedObject(self, @selector(dd_registerForTraitCollectionUpdates), @YES, OBJC_ASSOCIATION_RETAIN);
        }
    }
}

@end
