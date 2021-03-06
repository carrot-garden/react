//
// React - a library for functional-reactive-like programming
// Copyright (c) 2011, Three Rings Design, Inc. - All rights reserved.
// http://github.com/threerings/react/blob/master/LICENSE

#import "RAFloatSignal.h"
#import "RAFloatReactor+Protected.h"

@implementation RAFloatSignal
- (void)emitEvent:(float)event {
    [self dispatchEvent:event];
}
@end
