
#import "NSString+URLEncoding.h"

@implementation NSString (URLEncoding)


- (NSString *)URLEncodedString {
    
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes
                                                     (kCFAllocatorDefault,
                                                      (CFStringRef)self,
                                                      NULL,
                                                      CFSTR("!*'();:@&=+$,/?%#[]"),
                                                      kCFStringEncodingUTF8));
    return result;
}

- (NSString*)URLDecodedString {
    
    NSString *result = ( NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding
                                                      (kCFAllocatorDefault,
                                                       (CFStringRef)self,
                                                       CFSTR(""),
                                                       kCFStringEncodingUTF8));
    return result;
}

@end
