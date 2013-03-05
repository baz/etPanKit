#import <EtPanKit/LEPAbstractAttachment.h>

@class LEPIMAPFetchAttachmentRequest;

@interface LEPIMAPAttachment : LEPAbstractAttachment <NSCoding, NSCopying> {
	NSString * _partID;
	int _encoding;
	size_t _size;
}

@property (nonatomic, strong, readonly) NSString * partID;
@property (nonatomic, assign, readonly) size_t size;

- (LEPIMAPFetchAttachmentRequest *) fetchRequest;

- (size_t) decodedSize;

@end
