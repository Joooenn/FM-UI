//
//  MyMD5.m
//  Shareling
//
//  Created by 深圳市深软信息技术有限公司 on 16/1/14.
//  Copyright © 2016年 深圳市深软信息技术有限公司. All rights reserved.
//

#import "LMD5.h"
#import <CommonCrypto/CommonDigest.h>

#define _FileHashDefaultChunkSizeForReadingData 1024*8
#define pi 3.14159265358979324

@implementation LMD5

#pragma mark - MD5加密
+ (NSString *) md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned)strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

#pragma mark - 文件MD5效验
+(BOOL)fileEffectWithMd5:(NSString *)md5 filePath:(NSString *)filePath {
    return [[self getFileMD5WithPath:filePath] isEqualToString:md5];
}
+(NSString*)getFileMD5WithPath:(NSString*)path
{
    return (__bridge NSString *)FileMD5HashCreateWithPath((__bridge CFStringRef)path, _FileHashDefaultChunkSizeForReadingData);
}
CFStringRef FileMD5HashCreateWithPath(CFStringRef filePath,size_t chunkSizeForReadingData) {
    
    // Declare needed variables
    CFStringRef result = NULL;
    CFReadStreamRef readStream = NULL;
    
    // Get the file URL
    CFURLRef fileURL =
    CFURLCreateWithFileSystemPath(kCFAllocatorDefault,
                                  (CFStringRef)filePath,
                                  kCFURLPOSIXPathStyle,
                                  (Boolean)false);
    if (!fileURL) goto done;
    
    readStream = CFReadStreamCreateWithFile(kCFAllocatorDefault,
                                            (CFURLRef)fileURL);
    
    if (!readStream) goto done;
    
    bool didSucceed = (bool)CFReadStreamOpen(readStream);
    
    if (!didSucceed) goto done;
    
    // Initialize the hash object
    CC_MD5_CTX hashObject;
    CC_MD5_Init(&hashObject);
    
    // Make sure chunkSizeForReadingData is valid
    if (!chunkSizeForReadingData) {
        chunkSizeForReadingData = _FileHashDefaultChunkSizeForReadingData;
    }
    
    // Feed the data to the hash object
    bool hasMoreData = true;
    while (hasMoreData) {
        uint8_t buffer[chunkSizeForReadingData];
        CFIndex readBytesCount = CFReadStreamRead(readStream,(UInt8 *)buffer,(CFIndex)sizeof(buffer));
        if (readBytesCount == -1) break;
        if (readBytesCount == 0) {
            hasMoreData = false;
            continue;
        }
        
        CC_MD5_Update(&hashObject,(const void *)buffer,(CC_LONG)readBytesCount);
    }
    
    // Check if the read operation succeeded
    didSucceed = !hasMoreData;
    
    // Compute the hash digest
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &hashObject);
    
    // Abort if the read operation failed
    if (!didSucceed) goto done;
    
    // Compute the string result
    char hash[2 * sizeof(digest) + 1];
    for (size_t i = 0; i < sizeof(digest); ++i) {
        snprintf(hash + (2 * i), 3, "%02x", (int)(digest[i]));
    }
    
    result = CFStringCreateWithCString(kCFAllocatorDefault,(const char *)hash,kCFStringEncodingUTF8);
    
done:
    if (readStream) {
        CFReadStreamClose(readStream);
        CFRelease(readStream);
    }
    if (fileURL) {
        CFRelease(fileURL);
    }
    return result;
}


#pragma mark - url编码
+(NSString *) urlencode: (NSString *) url
{
    NSArray *escapeChars = [NSArray arrayWithObjects:@";" , @"/" , @"?" , @":" ,
                            @"@" , @"&" , @"=" , @"+" ,
                            @"$" , @"," , @"[" , @"]",
                            @"#", @"!", @"'", @"(",
                            @")", @"*", nil];
    
    NSArray *replaceChars = [NSArray arrayWithObjects:@"%3B" , @"%2F" , @"%3F" ,
                             @"%3A" , @"%40" , @"%26" ,
                             @"%3D" , @"%2B" , @"%24" ,
                             @"%2C" , @"%5B" , @"%5D",
                             @"%23", @"%21", @"%27",
                             @"%28", @"%29", @"%2A", nil];
    
    int len = (unsigned)[escapeChars count];
    
    NSMutableString *temp = [url mutableCopy];
    
    int i;
    for(i = 0; i < len; i++)
    {
        
        [temp replaceOccurrencesOfString: [escapeChars objectAtIndex:i]
                              withString:[replaceChars objectAtIndex:i]
                                 options:NSLiteralSearch
                                   range:NSMakeRange(0, [temp length])];
    }
    
    NSString *out = [NSString stringWithString: temp];
    //[temp release];
    //[url release];
    return out;
}

#pragma mark - base64编码
+ (NSString *)base64EncodedStringFrom:(NSData *)data
{
    const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    
    if ([data length] == 0)
        return @"";
    
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

#pragma mark - SHA1加密
+ (NSString *) sha1:(NSString *)str;
{
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

#pragma mark - 创建数字签名
+(NSString *)createSignWithDictionary:(NSMutableDictionary *)signInfo
{
    if (!signInfo[@"appKey"] || [signInfo[@"appKey"] isEqualToString:@""]) {
        [signInfo setValue:_App_Key forKey:@"appKey"];
    }
    if (!signInfo[@"v"] || [signInfo[@"v"] isEqualToString:@""]) {
        [signInfo setValue:_Verson forKey:@"v"];
    }
    //加入时间生成动态签名动态
    //    if (!signInfo[@"timestamp"] || [signInfo[@"timestamp"] isEqualToString:@""]) {
    //        NSDateFormatter *df = [[NSDateFormatter alloc] init];
    //        [df setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    //        NSString *timestamp = [df stringFromDate:[NSDate date]];
    //        [signInfo setValue:timestamp forKey:@"timestamp"];
    //    }
    
    NSArray *keyArr = [signInfo allKeys];
    keyArr = [keyArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        NSComparisonResult result = [obj1 compare:obj2 options:NSCaseInsensitiveSearch];
        return result==NSOrderedDescending;
    }];
    
    NSMutableString *str = [NSMutableString string];
    
    for (NSString *key in keyArr) {
        [str appendFormat:@"%@%@", key, signInfo[key]];
    }
    //拼接AppSecret，头部与尾部
    NSString *signStr = [NSString stringWithFormat:@"%@%@%@", _App_Secret, str, _App_Secret];
    
    //sha1加密
    return [[self sha1:signStr] uppercaseString];
}

#pragma mark - 判断邮箱格式的正则表达式
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
#pragma mark - 判断邮政编码的正则表达式
+ (BOOL) validateMail:(NSString *)mail
{
    NSString *mailRegex = @"[1-9]\\d{5}(?!\\d)";
    NSPredicate *mailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mailRegex];
    return [mailTest evaluateWithObject:mail];
}
#pragma mark - 验证码正则
+ (BOOL) checkCode:(NSString *)code{
    
    NSString *codeRegex = @"^\\d{n}$";
    NSPredicate *codeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", codeRegex];
    return [codeTest evaluateWithObject:code];
}
#pragma mark - 判断密码的正则表达式
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,16}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}
#pragma mark - 判断密码强度函数
/*
 声明：包含大写/小写/数字/特殊字符
 两种以下密码强度低
 两种密码强度中
 大于两种密码强度高
 密码强度标准根据需要随时调整
 */
//条件
+(int)judgePasswordStrength:(NSString*)_password
{
    NSMutableArray* resultArray = [[NSMutableArray alloc] init];
    
    NSArray* termArray1 = [[NSArray alloc] initWithObjects:@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z", nil];
    
    NSArray* termArray2 = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", nil];
    
    NSArray* termArray3 = [[NSArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
    
    NSArray* termArray4 = [[NSArray alloc] initWithObjects:@"~",@"`",@"@",@"#",@"$",@"%",@"^",@"&",@"*",@"(",@")",@"-",@"_",@"+",@"=",@"{",@"}",@"[",@"]",@"|",@":",@";",@"“",@"'",@"‘",@"<",@",",@".",@">",@"?",@"/",@"、", nil];
    
    NSString* result1 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray1 Password:_password]];
    NSString* result2 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray2 Password:_password]];
    NSString* result3 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray3 Password:_password]];
    NSString* result4 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray4 Password:_password]];
    
    [resultArray addObject:[NSString stringWithFormat:@"%@",result1]];
    [resultArray addObject:[NSString stringWithFormat:@"%@",result2]];
    [resultArray addObject:[NSString stringWithFormat:@"%@",result3]];
    [resultArray addObject:[NSString stringWithFormat:@"%@",result4]];
    
    int intResult=0;
    for (int j=0; j<[resultArray count]; j++)
    {
        if ([[resultArray objectAtIndex:j] isEqualToString:@"1"])
        {
            intResult++;
        }
    }
    
    NSString* resultString = [NSString string];
    int passwordStrength = -1;
    if (intResult <2)
    {
        resultString = @"密码强度低，建议修改";
        passwordStrength = 0;
    }
    else if (intResult == 2&&[_password length]>=6)
    {
        resultString = @"密码强度一般";
        passwordStrength = 1;
    }
    if (intResult > 2&&[_password length]>=6)
    {
        resultString = @"密码强度高";
        passwordStrength = 2;
    }
    
    return passwordStrength;
}
// 判断是否包含
+(BOOL) judgeRange:(NSArray*) _termArray Password:(NSString*) _password
{
    NSRange range;
    BOOL result = NO;
    for (int i=0; i<[_termArray count]; i++)
    {
        range = [_password rangeOfString:[_termArray objectAtIndex:i]];
        if (range.location != NSNotFound)
        {
            result = YES;
        }
    }
    return result;
}
#pragma 正则匹配手机号

+ (BOOL)checkTelNumber:(NSString*) telNumber

{
    
    NSString *pattern =@"^1+[3578]+\\d{9}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    
    return isMatch;
    
}
//判断手机号码格式，这个用起来有问题，用另外一个
+(BOOL)checkPhoneNumInput:(NSString *)phone {
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    NSString * CE = @"^(177)[0-9]{8}$";
    //  ((^(177)[0-9]{8}$))
    
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    phone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestce = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CE];
    BOOL res1 = [regextestmobile evaluateWithObject:phone];
    BOOL res2 = [regextestcm evaluateWithObject:phone];
    BOOL res3 = [regextestcu evaluateWithObject:phone];
    BOOL res4 = [regextestct evaluateWithObject:phone];
    BOOL res5 = [regextestce evaluateWithObject:phone];
    if (res1 || res2 || res3 || res4 || res5) {
        return YES;
    } else {
        return NO;
    }
}

+(NSString *)getWeekStringWithDate:(NSDate *)date {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitWeekday;
    comps = [calendar components:unitFlags fromDate:date];
    
    NSInteger week = [comps weekday];
    NSString *weekStr;
    switch (week) {
        case 1:
            weekStr = NSLocalizedString(@"星期日", nil);
            break;
        case 2:
            weekStr = NSLocalizedString(@"星期一", nil);
            break;
        case 3:
            weekStr = NSLocalizedString(@"星期二", nil);
            break;
        case 4:
            weekStr = NSLocalizedString(@"星期三", nil);
            break;
        case 5:
            weekStr = NSLocalizedString(@"星期四", nil);
            break;
        case 6:
            weekStr = NSLocalizedString(@"星期五", nil);
            break;
        case 7:
            weekStr = NSLocalizedString(@"星期六", nil);
            break;
    }
    return weekStr;
}
+(NSString *)getUserAgent
{
    NSString *os=[NSString stringWithFormat:@"%@-%@-%@",[UIDevice currentDevice].model,[UIDevice currentDevice].systemName,[UIDevice currentDevice].systemVersion];
    NSString *app=@"Tracker-2.0";
    NSString *map=@"";
    if([self isInChina])
    {
        map=@"gaodiMap";
    }else
    {
        map=@"GoogleMap";
    }
    NSString *str=[NSString stringWithFormat:@"%@;%@;%@",os,app,map];
    return str;
}

+(BOOL)isInChina
{
    BOOL result = NO;
    
    //NSString* localeStr = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0];
    if([[[NSTimeZone localTimeZone] name] rangeOfString:@"Asia/Chongqing"].location == 0 ||
       [[[NSTimeZone localTimeZone] name] rangeOfString:@"Asia/Harbin"].location == 0 ||
       [[[NSTimeZone localTimeZone] name] rangeOfString:@"Asia/Hong_Kong"].location == 0 ||
       [[[NSTimeZone localTimeZone] name] rangeOfString:@"Asia/Macau"].location == 0 ||
       [[[NSTimeZone localTimeZone] name] rangeOfString:@"Asia/Shanghai"].location == 0 ||
       [[[NSTimeZone localTimeZone] name] rangeOfString:@"Asia/Taipei"].location == 0)
    {
        result = YES;
    }
    return result;
}

+ (BOOL)isChina{
    if([[self currentLanguage] compare:@"zh-Hans" options:NSCaseInsensitiveSearch]==NSOrderedSame || [[self currentLanguage] compare:@"zh-Hant" options:NSCaseInsensitiveSearch]==NSOrderedSame)
    {
        return YES;
    }else{
        return NO;
    }
}

+ (NSString*)currentLanguage
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *currentLang = [languages objectAtIndex:0];
    return currentLang;
}
+(BOOL)isPureInt:(NSString *)string withNum:(int) num
{
    if(string.length!=num)
    {
        return NO;
    }
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

+(BOOL)isPureInt:(NSString *)string{
    
    if (string.length==0) {
        return NO;
    }
    
    NSScanner *scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

#pragma mark - 坐标偏移算法
+ (CLLocationCoordinate2D)locationTransFromWGSToGCJ:(CLLocationCoordinate2D)wgLoc
{
    
    const double a = 6378245.0;
    const double ee = 0.00669342162296594323;
    
    CLLocationCoordinate2D mgLoc;
    //    if (outOfChina(wgLoc.lat, wgLoc.lng))
    //    {
    //        mgLoc = wgLoc;
    //        return mgLoc;
    //    }
    
    if (![LMD5 isChina]) {
        mgLoc = wgLoc;
        return mgLoc;
    }
    double dLat = transformLat(wgLoc.longitude - 105.0, wgLoc.latitude - 35.0);
    double dLon = transformLon(wgLoc.longitude - 105.0, wgLoc.latitude - 35.0);
    double radLat = wgLoc.latitude / 180.0 * pi;
    double magic = sin(radLat);
    magic = 1 - ee * magic * magic;
    double sqrtMagic = sqrt(magic);
    dLat = (dLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * pi);
    dLon = (dLon * 180.0) / (a / sqrtMagic * cos(radLat) * pi);
    double lat = wgLoc.latitude + dLat;
    double lon = wgLoc.longitude + dLon;
    mgLoc.latitude = lat;
    mgLoc.longitude = lon;
    
    return mgLoc;
    
}

double transformLat(double x, double y)
{
    double ret = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * pi) + 20.0 *sin(2.0 * x * pi)) * 2.0 / 3.0;
    ret += (20.0 * sin(y * pi) + 40.0 * sin(y / 3.0 * pi)) * 2.0 / 3.0;
    ret += (160.0 * sin(y / 12.0 * pi) + 320 * sin(y * pi / 30.0)) * 2.0 / 3.0;
    return ret;
}

double transformLon(double x, double y)
{
    double ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x * pi)) * 2.0 / 3.0;
    ret += (20.0 * sin(x * pi) + 40.0 * sin(x / 3.0 * pi)) * 2.0 / 3.0;
    ret += (150.0 * sin(x / 12.0 * pi) + 300.0 * sin(x / 30.0 * pi)) * 2.0 / 3.0;
    return ret;
}

@end
