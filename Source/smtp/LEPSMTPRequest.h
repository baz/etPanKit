#import <Foundation/Foundation.h>

@protocol LEPSMTPRequestDelegate;
@class LEPSMTPSession;

@interface LEPSMTPRequest : NSOperation {
	id <LEPSMTPRequestDelegate> __unsafe_unretained _delegate;
	NSError * _error;
	LEPSMTPSession * _session;
	BOOL _started;
}

@property (unsafe_unretained) id <LEPSMTPRequestDelegate> delegate;

@property (nonatomic, readonly, copy) NSError * error;
@property (nonatomic, strong) LEPSMTPSession * session;

// progress
@property (nonatomic, assign, readonly) size_t currentProgress;
@property (nonatomic, assign, readonly) size_t maximumProgress;

- (void) startRequest;
- (void) cancel;

// can be overridden
- (void) mainRequest;
- (void) mainFinished;

@end

@protocol LEPSMTPRequestDelegate

- (void) LEPSMTPRequest_finished:(LEPSMTPRequest *)op;

@end
