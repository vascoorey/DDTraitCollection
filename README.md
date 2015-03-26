# DDTraitCollection
UITraitCollections in iOS 7

# Goal
The goal is to have some of the useful `UITraitCollection` API available to iOS 7, in order to reduce branching codepaths when writing layout code.

# API
Currently the following API should be available to iOS 7:

* `-traitCollection` - The current `UITraitCollection` for the `UIView` or `UIViewController`, on iOS 7 an instance of `DDTraitCollection` will be returned (it *should* be API-compatible with `UITraitCollection`)
* `-traitCollectionDidChange:` - This method will be called in any iOS 7 `view` or `viewController` that has previously called `-dd_registerForTraitCollectionUpdates`

# Example
First and foremost, you should `#import <DDTraitCollection/UIView[Controller]+DDTraitCollection.h>` in any files where you would like to access the `traitCollection`

If you would like to create `UITraitCollection` (or `DDTraitCollection`) instances, you should `#import <DDTraitCollection/DDTraitCollection.h>`

Here is a quick example of how you could use this:

```objc
- (void)updateConstraints {
  UITraitCollection *currentTraitCollection = self.traitCollection;
  
  if(currentTraitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) {
    // Update constraints for compact horizontal size class
    ...
  } else {
    // Do stuff for regular
    ...
  }

  [super updateConstraints];
}
```

# Warning
If you need to create `UITraitCollection` instances in code shared between iOS7 and 8 you should do so via the `DDTraitCollection` class methods (using `UITraitCollection` in iOS 7 will just nil stuff out).

In iOS 7 it will return an instance of `DDTraitCollection` whereas in iOS 8 it will correctly return `UITraitCollection` instances.
