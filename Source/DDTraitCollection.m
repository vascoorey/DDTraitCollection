//
//  DDTraitCollection.m
//  DDTraitCollection
//
//  Created by Vasco d'Orey on 25/03/15.
//  Copyright (c) 2015 Delta Dog. All rights reserved.
//

#import "DDTraitCollection.h"

@implementation DDTraitCollection

#pragma mark -
#pragma mark Class Loading

static BOOL _iOS7;

+ (void)load {
    _iOS7 = [[[UIDevice currentDevice] systemVersion] floatValue] < 8.0;
}

#pragma mark -
#pragma mark Class Methods

+ (UITraitCollection *)traitCollectionWithUserInterfaceIdiom:(UIUserInterfaceIdiom)idiom {
    return _iOS7 ? [[self alloc] initWithUserInterfaceIdiom:idiom] : [UITraitCollection traitCollectionWithUserInterfaceIdiom:idiom];
}

+ (UITraitCollection *)traitCollectionWithDisplayScale:(CGFloat)scale {
    return _iOS7 ? [[self alloc] initWithDisplayScale:scale] : [UITraitCollection traitCollectionWithDisplayScale:scale];
}

+ (UITraitCollection *)traitCollectionWithHorizontalSizeClass:(UIUserInterfaceSizeClass)horizontalSizeClass {
    return _iOS7 ? [[self alloc] initWithHorizontalSizeClass:horizontalSizeClass]
                 : [UITraitCollection traitCollectionWithHorizontalSizeClass:horizontalSizeClass];
}

+ (UITraitCollection *)traitCollectionWithVerticalSizeClass:(UIUserInterfaceSizeClass)verticalSizeClass {
    return _iOS7 ? [[self alloc] initWithVerticalSizeClass:verticalSizeClass] : [UITraitCollection traitCollectionWithVerticalSizeClass:verticalSizeClass];
}

+ (UITraitCollection *)traitCollectionWithTraitsFromCollections:(NSArray *)traitCollections {
    if (_iOS7) {
        CGFloat scale = 0.0;
        UIUserInterfaceIdiom idiom = UIUserInterfaceIdiomUnspecified;
        UIUserInterfaceSizeClass horizontalSizeClass = UIUserInterfaceSizeClassUnspecified;
        UIUserInterfaceSizeClass verticalSizeClass = UIUserInterfaceSizeClassUnspecified;

        for (DDTraitCollection *traitCollection in traitCollections) {
            if (traitCollection.displayScale != 0.0) {
                scale = traitCollection.displayScale;
            }

            if (traitCollection.userInterfaceIdiom != UIUserInterfaceIdiomUnspecified) {
                idiom = traitCollection.userInterfaceIdiom;
            }

            if (traitCollection.horizontalSizeClass != UIUserInterfaceSizeClassUnspecified) {
                horizontalSizeClass = traitCollection.horizontalSizeClass;
            }

            if (traitCollection.verticalSizeClass != UIUserInterfaceSizeClassUnspecified) {
                verticalSizeClass = traitCollection.verticalSizeClass;
            }
        }

        return (UITraitCollection *)
            [[self alloc] initWithUserInterfaceIdiom:idiom displayScale:scale horizontalSizeClass:horizontalSizeClass verticalSizeClass:verticalSizeClass];
    } else { return [UITraitCollection traitCollectionWithTraitsFromCollections:traitCollections]; }
}

+ (instancetype)traitCollectionForCurrentEnvironment {
    UIUserInterfaceIdiom idiom = UI_USER_INTERFACE_IDIOM();
    CGFloat displayScale = [UIScreen mainScreen].scale;
    UIUserInterfaceSizeClass horizontalSizeClass = idiom == UIUserInterfaceIdiomPad ? UIUserInterfaceSizeClassRegular : UIUserInterfaceSizeClassCompact;
    UIUserInterfaceSizeClass verticalSizeClass = idiom == UIUserInterfaceIdiomPad ? UIUserInterfaceSizeClassRegular : ({
        UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation) ? UIUserInterfaceSizeClassRegular
                                                                                                 : UIUserInterfaceSizeClassCompact;
    });

    return
        [[self alloc] initWithUserInterfaceIdiom:idiom displayScale:displayScale horizontalSizeClass:horizontalSizeClass verticalSizeClass:verticalSizeClass];
}

#pragma mark -
#pragma mark Initialization

- (instancetype)initWithUserInterfaceIdiom:(UIUserInterfaceIdiom)idiom {
    self = [super init];
    if (!self) {
        return nil;
    }

    _userInterfaceIdiom = idiom;

    return self;
}

- (instancetype)initWithDisplayScale:(CGFloat)scale {
    self = [super init];
    if (!self) {
        return nil;
    }

    _displayScale = scale;

    return self;
}

- (instancetype)initWithHorizontalSizeClass:(UIUserInterfaceSizeClass)horizontalSizeClass {
    self = [super init];
    if (!self) {
        return nil;
    }

    _horizontalSizeClass = horizontalSizeClass;

    return self;
}

- (instancetype)initWithVerticalSizeClass:(UIUserInterfaceSizeClass)verticalSizeClass {
    self = [super init];
    if (!self) {
        return nil;
    }

    _verticalSizeClass = verticalSizeClass;

    return self;
}

- (instancetype)initWithUserInterfaceIdiom:(UIUserInterfaceIdiom)idiom
                              displayScale:(CGFloat)scale
                       horizontalSizeClass:(UIUserInterfaceSizeClass)horizontalSizeClass
                         verticalSizeClass:(UIUserInterfaceSizeClass)verticalSizeClass {
    self = [super init];
    if (!self) {
        return nil;
    }

    _userInterfaceIdiom = idiom;
    _displayScale = scale;
    _horizontalSizeClass = horizontalSizeClass;
    _verticalSizeClass = verticalSizeClass;

    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (!self) {
        return nil;
    }

    _userInterfaceIdiom = [[aDecoder decodeObjectOfClass:[self class] forKey:NSStringFromSelector(@selector(userInterfaceIdiom))] integerValue];
    _displayScale = [[aDecoder decodeObjectOfClass:[self class] forKey:NSStringFromSelector(@selector(displayScale))] floatValue];
    _horizontalSizeClass = [[aDecoder decodeObjectOfClass:[self class] forKey:NSStringFromSelector(@selector(horizontalSizeClass))] integerValue];
    _verticalSizeClass = [[aDecoder decodeObjectOfClass:[self class] forKey:NSStringFromSelector(@selector(verticalSizeClass))] integerValue];

    return self;
}

#pragma mark -
#pragma mark Public API

- (BOOL)containsTraitsInCollection:(UITraitCollection *)trait {
    BOOL containsTraits = YES;

    if (trait.userInterfaceIdiom != UIUserInterfaceSizeClassUnspecified) {
        containsTraits &= trait.userInterfaceIdiom == self.userInterfaceIdiom || self.userInterfaceIdiom == UIUserInterfaceSizeClassUnspecified;
    }

    if (trait.displayScale != 0.0) {
        containsTraits &= [@(trait.displayScale) isEqualToNumber:@(self.displayScale)] || self.displayScale == 0.0;
    }

    if (trait.horizontalSizeClass != UIUserInterfaceSizeClassUnspecified) {
        containsTraits &= trait.horizontalSizeClass == self.horizontalSizeClass || self.horizontalSizeClass == UIUserInterfaceSizeClassUnspecified;
    }

    if (trait.verticalSizeClass != UIUserInterfaceSizeClassUnspecified) {
        containsTraits &= trait.verticalSizeClass == self.verticalSizeClass || self.verticalSizeClass == UIUserInterfaceSizeClassUnspecified;
    }

    return containsTraits;
}

#pragma mark -
#pragma mark NSObject

- (NSString *)description {
    return [NSString stringWithFormat:@"< Idiom: %@, Scale: %f, Horizontal: %@, Vertical: %@ >",
                                      self.userInterfaceIdiom == UIUserInterfaceIdiomPad ? @"iPad" : @"iPhone", self.displayScale,
                                      self.horizontalSizeClass == UIUserInterfaceSizeClassCompact ? @"Compact" : @"Regular",
                                      self.verticalSizeClass == UIUserInterfaceSizeClassCompact ? @"Compact" : @"Regular"];
}

#pragma mark -
#pragma mark NSCopying

- (instancetype)copyWithZone:(NSZone *)zone {
    return [[[self class] allocWithZone:zone] initWithUserInterfaceIdiom:self.userInterfaceIdiom
                                                            displayScale:self.displayScale
                                                     horizontalSizeClass:self.horizontalSizeClass
                                                       verticalSizeClass:self.verticalSizeClass];
}

#pragma mark -
#pragma mark Encoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:@(self.userInterfaceIdiom) forKey:NSStringFromSelector(@selector(userInterfaceIdiom))];
    [aCoder encodeObject:@(self.displayScale) forKey:NSStringFromSelector(@selector(displayScale))];
    [aCoder encodeObject:@(self.horizontalSizeClass) forKey:NSStringFromSelector(@selector(horizontalSizeClass))];
    [aCoder encodeObject:@(self.verticalSizeClass) forKey:NSStringFromSelector(@selector(verticalSizeClass))];
}

#pragma mark -
#pragma mark NSSecureCoding

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end
