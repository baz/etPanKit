#import <EtPanKit/LEPAbstractAttachment.h>

@interface LEPAttachment : LEPAbstractAttachment <NSCoding, NSCopying> {
    NSData * _data;
}

@property (nonatomic, retain) NSData * data;

+ (NSString *) mimeTypeFromFilename:(NSString *)filename;

- (id) initWithContentsOfFile:(NSString *)filename;

+ (LEPAttachment *) attachmentWithContentsOfFile:(NSString *)filename;

+ (LEPAbstractAttachment *) attachmentWithHTMLString:(NSString *)html; // with alternative by default
+ (LEPAttachment *) attachmentWithHTMLString:(NSString *)html withTextAlternative:(BOOL)hasAlternative;

+ (LEPAttachment *) attachmentWithString:(NSString *)stringValue;

@end
