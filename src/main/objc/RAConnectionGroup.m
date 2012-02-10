//
// React - a library for functional-reactive-like programming
// Copyright (c) 2011, Three Rings Design, Inc. - All rights reserved.
// http://github.com/threerings/react/blob/master/LICENSE

#import "RAConnectionGroup.h"
#import "RAConnection.h"
#import "RAReactor.h"
#import "RABoolReactor.h"
#import "RADoubleReactor.h"
#import "RAFloatReactor.h"
#import "RAIntReactor.h"
#import "RAObjectReactor.h"

@implementation RAConnectionGroup {
    NSMutableSet *_conns;
}

- (id)init {
    if (!(self = [super init])) return nil;
    _conns = [[NSMutableSet alloc] init];
    return self;
}

- (void)disconnectAll {
    for (RAConnection *conn in _conns) {
        [conn disconnect];
    }
    [_conns removeAllObjects];
}

- (void)addConnection:(RAConnection*)conn {
    [_conns addObject:conn];
}

- (void)removeConnection:(RAConnection*)conn {
    [_conns removeObject:conn];
}

- (RAConnection*) onReactor:(RAReactor*)reactor connectUnit:(RAUnitBlock)block {
    return [reactor connectUnit:block];
}

- (RAConnection*) onReactor:(RAReactor*)reactor withPriority:(int)priority connectUnit:(RAUnitBlock)block {
    return [reactor withPriority:priority connectUnit:block];
}

- (RAConnection*) onBoolReactor:(RABoolReactor*)reactor connectSlot:(RABoolSlot)block {
    return [reactor connectSlot:block];
}

- (RAConnection*) onBoolReactor:(RABoolReactor*)reactor withPriority:(int)priority connectSlot:(RABoolSlot)block {
    return [reactor withPriority:priority connectSlot:block];
}

- (RAConnection*) onDoubleReactor:(RADoubleReactor*)reactor connectSlot:(RADoubleSlot)block {
      return [reactor connectSlot:block];
}

- (RAConnection*) onDoubleReactor:(RADoubleReactor*)reactor withPriority:(int)priority connectSlot:(RADoubleSlot)block {
    return [reactor withPriority:priority connectSlot:block];
}

- (RAConnection*) onFloatReactor:(RAFloatReactor*)reactor connectSlot:(RAFloatSlot)block {
     return [reactor connectSlot:block];
}

- (RAConnection*) onFloatReactor:(RAFloatReactor*)reactor withPriority:(int)priority connectSlot:(RAFloatSlot)block {
    return [reactor withPriority:priority connectSlot:block];
}

- (RAConnection*) onIntReactor:(RAIntReactor*)reactor connectSlot:(RAIntSlot)block {
    return [reactor connectSlot:block];
}

- (RAConnection*) onIntReactor:(RAIntReactor*)reactor withPriority:(int)priority connectSlot:(RAIntSlot)block {
    return [reactor withPriority:priority connectSlot:block];
}

- (RAConnection*) onObjectReactor:(RAObjectReactor*)reactor connectSlot:(RAObjectSlot)block {
    return [reactor connectSlot:block];
}

- (RAConnection*) onObjectReactor:(RAObjectReactor*)reactor withPriority:(int)priority connectSlot:(RAObjectSlot)block {
   return [reactor withPriority:priority connectSlot:block];
}
@end
