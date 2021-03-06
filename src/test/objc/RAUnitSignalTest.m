//
// React - a library for functional-reactive-like programming
// Copyright (c) 2011, Three Rings Design, Inc. - All rights reserved.
// http://github.com/threerings/react/blob/master/LICENSE

#import "RAUnitSignalTest.h"
#import "RAUnitSignal.h"
#import "RAConnectionGroup.h"
#import "RAConnection.h"

@implementation RAUnitSignalTest

- (void)testEmission {
    RAUnitSignal *sig = [[RAUnitSignal alloc] init];
    __block int x = 0;
    [sig connectUnit:^{ x++; }];
    [sig emit];
    [sig emit];
    STAssertEquals(x, 2, nil);
}

- (void)testMultipleListeners {
    RAUnitSignal *sig = [[RAUnitSignal alloc] init];
    __block int x = 0;
    [sig connectUnit:^{ x++; }];
    [sig connectUnit:^{ x++; }];
    [sig emit];
    STAssertEquals(x, 2, nil);
}

- (void)testDisconnecting {
    RAUnitSignal *sig = [[RAUnitSignal alloc] init];
    __block int x = 0;
    __block int y = 0;
    [[sig connectUnit:^{ x++; }] once];
    [sig connectUnit:^{ y++; }];
    RAConnection *conn = [sig connectUnit:^{ x++; }];
    [sig emit];
    STAssertEquals(x, 2, nil);
    STAssertEquals(y, 1, nil);
    [sig emit];
    STAssertEquals(x, 3, nil);
    STAssertEquals(y, 2, nil);
    [conn disconnect];
    [sig emit];
    STAssertEquals(x, 3, nil);
    STAssertEquals(y, 3, nil);
}

- (void)testGroup {
    RAConnectionGroup *group = [[RAConnectionGroup alloc] init];
    RAUnitSignal *sig = [[RAUnitSignal alloc] init];
    __block int x = 0;
    [group addConnection:[sig connectUnit:^{ x++; }]];
    [group addConnection:[sig connectUnit:^{ x++; }]];
    [sig connectUnit:^{ x++; }];
    [sig emit];
    STAssertEquals(x, 3, nil);
    [group disconnectAll];
    [sig emit];
    STAssertEquals(x, 4, nil);
}

- (void)testAddInEmission {
    RAUnitSignal *sig = [[RAUnitSignal alloc] init];
    __block int x = 0;
    [sig connectUnit:^{ x++; }];
    [[sig connectUnit:^{
        x++;
        [[sig connectUnit:^{ x++; }] once];
    }] once];
    [[sig connectUnit:^{ x++; }] once];
    [sig emit];
    STAssertEquals(x, 3, @"3 initially added fired");
    [sig emit];
    STAssertEquals(x, 5, @"Added in block and new added fired");
    [sig emit];
    STAssertEquals(x, 6, @"Block adder fires");
}

- (void)testPriority {
    RAUnitSignal *sig = [[RAUnitSignal alloc] init];
    __block int x = 0;
    [sig withPriority:2 connectUnit:^{ STAssertEquals(x++, 0, nil); }];
    [sig connectUnit:^{ x++; }];
    [sig withPriority:1 connectUnit:^{ STAssertEquals(x++, 1, nil); }];
    [sig emit];
    STAssertEquals(x, 3, nil);
}

- (void)testDisconnectDuringEmission {
    RAUnitSignal *sig = [[RAUnitSignal alloc] init];
    __block int x = 0;
    
    RAConnection* conn = [sig connectUnit:^{ x++; }];
    [sig withPriority:1 connectUnit:^{ [conn disconnect]; }];
    [sig emit];
    STAssertEquals(x, 0, nil);
    [sig disconnectAll];
    
    [sig connectUnit:^{ [sig disconnectAll]; }];
    [sig connectUnit:^{ x++; }];
    [sig emit];
    STAssertEquals(x, 0, nil);
}

@end
