//
// React - a library for functional-reactive-like programming
// Copyright (c) 2011, Three Rings Design, Inc. - All rights reserved.
// http://github.com/threerings/react/blob/master/LICENSE

#import "RABoolSignal.h"
#import "RABoolReactor+Protected.h"

@implementation RABoolSignal
- (void)emitEvent:(BOOL)event {
    [self dispatchEvent:event];
}
@end
