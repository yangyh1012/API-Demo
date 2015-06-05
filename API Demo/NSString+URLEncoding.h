
#import <Foundation/Foundation.h>

/**
 *  处理URL网址
 */
@interface NSString (URLEncoding)

/**
 *  转义网址中的特殊字符
 *
 *  @return 转义后的字符串
 */
- (NSString *)URLEncodedString;

/**
 *  url解码
 *
 *  @return 解码后的字符串
 */
- (NSString *)URLDecodedString;

@end
