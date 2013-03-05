#import <Foundation/Foundation.h>

@class LEPMessageHeader;

@interface LEPAbstractMessage : NSObject <NSCoding, NSCopying> {
	LEPMessageHeader * _header;
}

@property (nonatomic, strong, readonly) LEPMessageHeader * header;

@end
