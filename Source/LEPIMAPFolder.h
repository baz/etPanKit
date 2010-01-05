#import "LEPIMAPRequest.h"
#import "LEPConstants.h"

@class LEPIMAPFetchFolderMessagesRequest;
@class LEPAbstractMessage;

@interface LEPIMAPFolder : NSObject {
}

@property (nonatomic, readonly) NSString * uidValidity;

- (LEPIMAPRequest *) createFolderRequest:(NSString *)name;
- (LEPIMAPFetchFolderMessagesRequest *) fetchMessagesRequest;
- (LEPIMAPFetchFolderMessagesRequest *) fetchMessagesRequestFromSequenceNumber:(uint32_t)sequenceNumber;
- (LEPIMAPFetchFolderMessagesRequest *) fetchMessagesRequestFromUID:(uint32_t)uid;
- (LEPIMAPRequest *) appendMessageRequest:(LEPAbstractMessage *)message;
- (LEPIMAPRequest *) appendMessagesRequest:(NSArray * /* LEPAbstractMessage */)message;

@end

@interface LEPIMAPFetchFolderMessagesRequest : LEPIMAPRequest {
}

@property (nonatomic, readonly) NSArray * /* LEPIMAPMessage */ messages;

@end
