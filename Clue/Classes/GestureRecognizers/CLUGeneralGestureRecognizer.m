//
//  CLUGeneralGestureRecognizer.m
//  Clue
//
//  Created by Ahmed Sulaiman on 6/7/16.
//  Copyright © 2016 Ahmed Sulaiman. All rights reserved.
//

#import "CLUGeneralGestureRecognizer.h"

@interface CLUGeneralGestureRecognizer()

@property (nonatomic) NSMutableArray *movedTouchesBuffer;
@property (nonatomic) id <CLUInteractionObserverDelegate> observerDelegate;

@end

@implementation CLUGeneralGestureRecognizer

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    _movedTouchesBuffer = [[NSMutableArray alloc] init];
    return self;
}

- (void)reset {
    [super reset];
    [_movedTouchesBuffer removeAllObjects];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self setState:UIGestureRecognizerStatePossible];
    if (_observerDelegate) {
        [_observerDelegate touchesBegan:touches];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    [_movedTouchesBuffer addObjectsFromArray:[touches allObjects]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self setState:UIGestureRecognizerStateEnded];
    if (_observerDelegate) {
        if ([_movedTouchesBuffer count] > 0) {
            [_observerDelegate touchesMoved:_movedTouchesBuffer];
        }
        [_observerDelegate touchesEnded:touches];
    }
}

- (void)setObserverDelegate:(id <CLUInteractionObserverDelegate>)delegate {
    _observerDelegate = delegate;
}

- (void)removeObserverDelegate {
    _observerDelegate = nil;
}

@end
