//
//  SecurityTest.m
//  API Demo
//
//  Created by 杨毅辉 on 15/5/14.
//  Copyright (c) 2015年 yangyh1012. All rights reserved.
//

#import "SecurityTest.h"

/*说明：
 
 */
@implementation SecurityTest

- (void)onevcat {
    
    /*说明：
     MD5的Challenge-Response验证方法可以满足绝大部分非机密级别的应用了。
     为了防止截取MD5伪造身份完成认证，再加入一个Challenge-Response机制，
     客户端请求验证时，由服务器随机一个串给客户端进行挑战，客户端使用密码的散列值与从服务器取得的串组合得到新的散列值，
     将此散列值提交给服务器生成的散列值进行应答验证，若两个散列一致则通过，否则失效。
     
     如果希望能够得到更加安全的散列算法，可以选择SHA-256，SHA-384或者SHA-512等还未被攻破的散列。
     
     对于iPhone SDK来说，常用的散列算法都在头文件中均有说明。
     而libcommonCrypto.dylib和Security.framework中也都提供了相当多的安全方法，
     涉及网络应用的app开发的话，不论是作为自身修养的提升还是对自己的代码负责，都应当对安全问题有基本的认识和思索...
     
     */
}

@end
