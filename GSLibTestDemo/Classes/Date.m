//
//  Model_Date.m
//  model
//
//  Created by mac on 2019/6/12.
//  Copyright © 2019 Lee. All rights reserved.
//

#import "Date.h"

@implementation Date

+ (Date *)shareDate{
    static Date * date;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        date = [[Date alloc] init];
    });
    return date;
}
//@"YYYY-MM-dd HH:mm:ss SSS"
+(NSString *)getNowTimeTimestamp3:(NSString *)timer{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:timer]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    
    return timeSp;
}


// 时间戳转日期
+ (NSString *)stringWithTimeIntervalSince1970:(NSTimeInterval)timeInterval formatString:(NSString *)formatString
{
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatString];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

// 时间戳转时间
+ (NSDate *)dateWithTimeIntervalSince1970:(NSTimeInterval)timeInterval
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    return confromTimesp;
}
//时间戳转字符串
+(NSString *)timeStampConversionNSString:(NSString *)timeStamp
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp longLongValue]/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}


//获取当前时间2020.02.27
+ (NSString *)getCurrentTime{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

//字符串转时间
+(NSDate *)nsstringConversionNSDate:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *datestr = [dateFormatter dateFromString:dateStr];
    return datestr;
}
// 时间转时间戳
+ (NSTimeInterval)timeIntervalWtihDate:(NSDate *)date{
    return [date timeIntervalSince1970];
}

// 日期格式化成字符串
+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

// 字符串格式化成日期
+ (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter dateFromString:dateString];
}

// 获取时间差
+ (NSTimeInterval)getTimeDifference:(NSDate *)firstDate secondDate:(NSDate *)secondDate
{
    NSTimeInterval seconds = [firstDate timeIntervalSinceDate:secondDate];
    return seconds;
}

+(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(NSInteger)month{
    NSDateComponents *comps = [[NSDateComponents alloc]init];
    [comps setMonth:month];
    NSCalendar *calender = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *mdate = [calender dateByAddingComponents:comps toDate:date options:0];
    
    return mdate;
}

// 获得时间差字符串
+ (NSString *)getTimeDifferenceString:(NSTimeInterval)timeInterval initiallyString:(NSString *)initiallyString
{
    if (timeInterval >= 86400) {
        int days = (int)timeInterval / 86400;
        int hours = (int)timeInterval % 86400 / 3600;
        int minuters = (int)timeInterval % 3600 / 60;
        int seconds = (int)timeInterval % 60;
        return [NSString stringWithFormat:@"%@%d天%d小时%d分钟%d秒",initiallyString,days,hours,minuters,seconds];
    }else if (timeInterval < 86400 && timeInterval >= 3600) {
        int hours = (int)timeInterval / 3600;
        int minuters = (int)timeInterval % 3600 / 60;
        int seconds = (int)timeInterval % 60;
        return [NSString stringWithFormat:@"%@%d小时%d分总%d秒",initiallyString,hours,minuters,seconds];
    }else if (timeInterval < 3600 && timeInterval >= 60) {
        int minuters = (int)timeInterval / 60;
        int seconds = (int)timeInterval % 60;
        return [NSString stringWithFormat:@"%@%d分钟%d秒",initiallyString,minuters,seconds];
    }else if (timeInterval < 60 && timeInterval > 0) {
        int seconds = (int)timeInterval % 60;
        return [NSString stringWithFormat:@"%@%d秒",initiallyString,seconds];
    }
    return nil;
}

+ (NSString *)stringformatterTimeDifferenceStringWithTimeInterval:(NSTimeInterval)timeInterval
{
    NSDate *timeIntervalDate = [Date dateWithTimeIntervalSince1970:timeInterval];
    NSTimeInterval difference_timeInterval = [Date getTimeDifference:[NSDate date] secondDate:timeIntervalDate];
    NSTimeInterval fabsSeconds = fabs(difference_timeInterval);
    
    if (fabsSeconds < 60) {
        return @"刚刚";
    }
    
    if (fabsSeconds < 3600 && fabsSeconds >= 60) {
        NSInteger minuters = (NSInteger)fabsSeconds / 60;
        return [NSString stringWithFormat:@"%ld分钟前",(long)minuters];
    }
    
    if (fabsSeconds < 86400 && fabsSeconds >= 3600) {
        NSInteger hours = (NSInteger)fabsSeconds / 3600;
        return [NSString stringWithFormat:@"%ld小时前",(long)hours];
    }
    
    if (fabsSeconds >= 86400) {
        NSInteger days = (NSInteger)fabsSeconds / 86400;
        return [NSString stringWithFormat:@"%ld天前",(long)days];
    }
    
    return @"";
}

/**
 * @brief 判断某个时间是否在当天的fromHour和toHour之间
 */
+ (BOOL)date:(NSDate*)date isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour {
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger hour = [currentCalendar ordinalityOfUnit:NSCalendarUnitHour inUnit:NSCalendarUnitDay forDate:date];
    if (hour > fromHour && hour < toHour) {
        return YES;
    }
    return NO;
}

/**
 * @brief 判断某个时间是否在当月中的fromDay和toDay之间 包含两边
 */
+ (BOOL)date:(NSDate*)date isBetweenFromDay:(NSInteger)fromDay toDay:(NSInteger)toDay {
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger day = [currentCalendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    if (day > fromDay && day < toDay) {
        return YES;
    }
    return NO;
}


/**
 *  判断时间 是不是在某个时间段
 */
+ (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate
{
    if ([date compare:beginDate] ==NSOrderedAscending)
        return NO;
    if ([date compare:endDate] ==NSOrderedDescending)
        return NO;
    return YES;
}

/**
 *  仿微信列表日期 时间戳格式化字符串
 */
+ (NSString *)model_getMessageListDateStringFromTimeInterval:(NSTimeInterval)timeInterval isMS:(BOOL)isMS
{
    if (isMS) {
        timeInterval = timeInterval / 1000;
    }
    return [Date dateStringDealBy:timeInterval isList:YES];
}

/**
 *  仿微信消息页日期 时间戳格式化字符串
 */
+ (NSString *)model_getMessageDateStringFromTimeInterval:(NSTimeInterval)timeInterval isMS:(BOOL)isMS
{
    if (isMS) {
        timeInterval = timeInterval / 1000;
    }
    return [Date dateStringDealBy:timeInterval isList:NO];
}

/**
 *  仿微信朋友圈日期 时间戳格式化字符串
 */
+ (NSString *)model_getWechatLineStringFromTimeInterval:(NSTimeInterval)timeInterval isMS:(BOOL)isMS
{
    if (isMS) {
        timeInterval = timeInterval / 1000;
    }
    if (timeInterval >= 86400) {
        int days = (int)timeInterval / 86400;
        if (days == 1) {
            return @"昨天";
        }
        return [NSString stringWithFormat:@"%d天前",days];
    }else if (timeInterval < 86400 && timeInterval >= 3600) {
        int hours = (int)timeInterval / 3600;
        return [NSString stringWithFormat:@"%d小时前",hours];
    }else if (timeInterval < 3600 && timeInterval >= 60) {
        int minuters = (int)timeInterval / 60;
        return [NSString stringWithFormat:@"%d分钟前",minuters];
    }else if (timeInterval < 60) {
        return @"刚刚";
    }
    return @"";
}

+ (NSString *)dateStringDealBy:(NSTimeInterval)timeInterval isList:(BOOL)isList
{
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDate* currentDate = [NSDate date];
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; // NSGregorianCalendar
    NSInteger day = [currentCalendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    NSInteger currentDay = [currentCalendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:currentDate];
    NSInteger dvalue = currentDay - day;
    
    NSInteger year = [currentCalendar ordinalityOfUnit:NSCalendarUnitYear inUnit:NSCalendarUnitEra forDate:date];
    NSInteger currentYear = [currentCalendar ordinalityOfUnit:NSCalendarUnitYear inUnit:NSCalendarUnitEra forDate:currentDate];
    
    NSInteger month = [currentCalendar ordinalityOfUnit:NSCalendarUnitMonth inUnit:NSCalendarUnitYear forDate:date];
    NSInteger currentMonth = [currentCalendar ordinalityOfUnit:NSCalendarUnitMonth inUnit:NSCalendarUnitYear forDate:currentDate];
    
    NSString *listDateFormat = @"yy/M/d";
    NSString *dateFormat;
    NSString *weekFormat;
    
    dateFormat = @"yyyy年M月d日 HH:mm";
    weekFormat = @"EEEE";
    
    /*
     en
     dateFormat = @"MMM d, yyyy HH:mm";
     weekFormat = @"EEE";
     */
        
    if (isList) {
        if (year == currentYear) {
            if (month == currentMonth) {
                if (dvalue < 1) {
                    return [Date stringWithDate:date format:@"HH:mm"];
                } else if (dvalue < 2) {
                    return @"昨天";
                } else if (dvalue < 7) {
                    return [Date stringWithDate:date format:weekFormat];
                } else {
                    return [Date stringWithDate:date format:listDateFormat];
                }
            } else {
                return [Date stringWithDate:date format:listDateFormat];
            }
        } else {
            return [Date stringWithDate:date format:listDateFormat];
        }
    } else {
        if (year == currentYear) {
            if (month == currentMonth) {
                if (dvalue < 1) {
                    return [Date stringWithDate:date format:@"HH:mm"];
                } else if (dvalue < 2) {
                    return [NSString stringWithFormat:@"昨天 %@", [Date stringWithDate:date format:@"HH:mm"]];
                } else if (dvalue < 7) {
                    return [NSString stringWithFormat:@"%@ %@",[Date stringWithDate:date format:weekFormat], [Date stringWithDate:date format:@"HH:mm"]] ;
                } else {
                    return [Date stringWithDate:date format:dateFormat];
                }
            } else {
                return [Date stringWithDate:date format:dateFormat];
            }
        } else {
            return [Date stringWithDate:date format:dateFormat];
        }
    }
}

/**
 *  仿QQ日期 时间戳格式化字符串
 */
+ (NSString *)model_getQQDateStringFromTimeInterval:(NSTimeInterval)timeInterval isMS:(BOOL)isMS
{
    if (isMS) {
        timeInterval = timeInterval / 1000;
    }
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSCalendar *calendar = [ NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear ;
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *myCmps = [calendar components:unit fromDate:date];
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc ] init];
    NSDateComponents *comp =  [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:date];
    
    if (nowCmps.year != myCmps.year) {
        dateFmt.dateFormat = @"yyyy/MM/dd";
    }
    else{
        if (nowCmps.day==myCmps.day) {
            dateFmt.AMSymbol = @"上午";
            dateFmt.PMSymbol = @"下午";
            dateFmt.dateFormat = @"aaa hh:mm";
        } else if((nowCmps.day-myCmps.day)==1) {
            dateFmt.AMSymbol = @"上午";
            dateFmt.PMSymbol = @"下午";
            dateFmt.dateFormat = @"昨天";
        } else {
            if ((nowCmps.day-myCmps.day) <=7) {
                switch (comp.weekday) {
                    case 1:
                        dateFmt.dateFormat = @"星期日";
                        break;
                    case 2:
                        dateFmt.dateFormat = @"星期一";
                        break;
                    case 3:
                        dateFmt.dateFormat = @"星期二";
                        break;
                    case 4:
                        dateFmt.dateFormat = @"星期三";
                        break;
                    case 5:
                        dateFmt.dateFormat = @"星期四";
                        break;
                    case 6:
                        dateFmt.dateFormat = @"星期五";
                        break;
                    case 7:
                        dateFmt.dateFormat = @"星期六";
                        break;
                    default:
                        break;
                }
            }else {
                dateFmt.dateFormat = @"yyyy/MM/dd";
            }
        }
    }
    return [dateFmt stringFromDate:date];
}

+ (NSString *)timeFormatted:(NSInteger)totalSeconds{
    NSInteger seconds = totalSeconds % 60;
    NSInteger minutes = (totalSeconds / 60) % 60;
    NSInteger hours = totalSeconds / 3600;
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hours, (long)minutes, (long)seconds];
}

+ (BOOL)objectIsEmpty:(id)object {
    if (!object) {
        return YES;
    }
    
    if ([object isKindOfClass:[NSArray class]]) {
        NSArray *ar = (NSArray *)object;
        if (ar.count == 0) {
            return YES;
        }
    }
    
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)object;
        if (dic.allKeys.count == 0) {
            return YES;
        }
    }
    
    if (object == nil) {
        return YES;
    }
    
    if ([object isEqual:[NSNull null]]) {
        return YES;
    }
    
    if ([object isEqual:[NSNull class]]) {
        return YES;
    }
    
    if ([[NSString stringWithFormat:@"%@",object] isEqualToString:@"<null>"]) {
        return YES;
    }
    
    if ([[NSString stringWithFormat:@"%@",object] isEqualToString:@"null"]) {
        return YES;
    }
    
    if ([[NSString stringWithFormat:@"%@",object] isEqualToString:@"(null)"]) {
        return YES;
    }
    
    if ([NSString stringWithFormat:@"%@",object].length == 0) {
        return YES;
    }
    
    return NO;
}
@end
