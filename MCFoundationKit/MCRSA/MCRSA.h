//
//  MCRSA.h
//  MCFoundationKit
//
//  Created by wang maocai on 2020/7/29.
//  Copyright © 2020 mc. All rights reserved.
//

/**
 * 1.cd 到一个文件夹，比如RSA。
 * cd /Users/xxxx/Desktop/RSA
 *
 * 2.执行Mac自带的openssl命令。
 * openssl
 *
 * 3.生成私钥
 * genrsa -out rsa_private_key.pem 1024
 *
 * 4.将私钥转成PKCS8的格式（必须转）格式转好后立刻复制
 * 切记后面使用的私钥加密解密就是执行命令行之后终端打印的私钥，而不是执行命令行之后重新生成的私钥，（网上一些命令行是错误的，一定要注意）。
 * pkcs8 -topk8 -inform PEM -in rsa_private_key.pem -outform PEM -nocrypt
 * 复制上图的私钥保存。
 
 * 5.生成公钥。
 * rsa -in rsa_private_key.pem -pubout -out rsa_public_key.pem
 *
 * RSA 文件中已经对结果做了base64加密解密。
 *
 * 工程中需要引入Security.framework
 */

#import <Foundation/Foundation.h>

@interface MCRSA : NSObject

// return base64 encoded string
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;
// return raw data
+ (NSData *)encryptData:(NSData *)data publicKey:(NSString *)pubKey;
// return base64 encoded string
+ (NSString *)encryptString:(NSString *)str privateKey:(NSString *)privKey;
// return raw data
+ (NSData *)encryptData:(NSData *)data privateKey:(NSString *)privKey;

// decrypt base64 encoded string, convert result to string(not base64 encoded)
+ (NSString *)decryptString:(NSString *)str publicKey:(NSString *)pubKey;
+ (NSData *)decryptData:(NSData *)data publicKey:(NSString *)pubKey;
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;
+ (NSData *)decryptData:(NSData *)data privateKey:(NSString *)privKey;

@end
