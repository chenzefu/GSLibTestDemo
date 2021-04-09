//
//  Model_Date.h
//  model
//
//  Created by mac on 2019/6/12.
//  Copyright © 2019 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Date : NSObject

+ (Date *)shareDate;
+(NSString *)getNowTimeTimestamp3:(NSString *)timer;
/// 时间戳转日期
+ (NSString *)stringWithTimeIntervalSince1970:(NSTimeInterval)timeInterval formatString:(NSString *)formatString;
/// 时间戳转时间
+ (NSDate *)dateWithTimeIntervalSince1970:(NSTimeInterval)timeInterval;
/// 时间转时间戳
+ (NSTimeInterval)timeIntervalWtihDate:(NSDate *)date;
//获取当前时间    2020.02.27
+ (NSString *)getCurrentTime;
//时间戳转字符串
+(NSString *)timeStampConversionNSString:(NSString *)timeStamp;
///字符串转时间 @"2020-01-02 13:47:58"
+(NSDate *)nsstringConversionNSDate:(NSString *)dateStr;
/// 日期格式化成字符串
+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format;
/// 字符串格式化成日期
+ (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format;
/// 获取时间差
+ (NSTimeInterval)getTimeDifference:(NSDate *)firstDate secondDate:(NSDate *)secondDate;
/// 获得时间差字符串
+ (NSString *)getTimeDifferenceString:(NSTimeInterval)timeInterval initiallyString:(NSString *)initiallyString;
/// 格式化时间戳为字符串 输入:时间戳timeInterval秒 输出:刚刚 分钟前 小时前 天前
+ (NSString *)stringformatterTimeDifferenceStringWithTimeInterval:(NSTimeInterval)timeInterval;

+(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(NSInteger)month;


/// 判断时间 是不是在某个时间段
+ (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate;
/// @brief 判断某个时间是否在当天的fromHour和toHour之间
+ (BOOL)date:(NSDate*)date isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour;
/// @brief 判断某个时间是否在当月中的fromDay和toDay之间 包含两边
+ (BOOL)date:(NSDate*)date isBetweenFromDay:(NSInteger)fromDay toDay:(NSInteger)toDay;

/// 仿微信列表日期 时间戳格式化字符串
+ (NSString *)model_getMessageListDateStringFromTimeInterval:(NSTimeInterval)timeInterval isMS:(BOOL)isMS;
/// 仿微信消息页日期 时间戳格式化字符串
+ (NSString *)model_getMessageDateStringFromTimeInterval:(NSTimeInterval)timeInterval isMS:(BOOL)isMS;
/// 仿微信朋友圈日期 时间戳格式化字符串
+ (NSString *)model_getWechatLineStringFromTimeInterval:(NSTimeInterval)timeInterval isMS:(BOOL)isMS;

/// 仿QQ日期 时间戳格式化字符串
+ (NSString *)model_getQQDateStringFromTimeInterval:(NSTimeInterval)timeInterval isMS:(BOOL)isMS;

//把秒转时长
+ (NSString *)timeFormatted:(NSInteger)totalSeconds;

+ (BOOL)objectIsEmpty:(id)object;
@end

NS_ASSUME_NONNULL_END
