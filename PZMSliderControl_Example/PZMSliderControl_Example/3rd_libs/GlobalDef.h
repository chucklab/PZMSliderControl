//
//  GlobalDef.h
//

#ifndef GlobalDef_h
#define GlobalDef_h

#define SAFE_RELEASE(x)  do{if(x){[x release];x=nil;}}while(0)

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

/**
 *  主屏的宽
 */
#define DEF_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

/**
 *  主屏的高
 */
#define DEF_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

/**
 *  Verisons
 */

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

/**
 *  UI Utils
 */
#define Scale2X                     (DEF_SCREEN_WIDTH/320.0f)
#define NavigationBarHeight 44
#define StatusbarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define TabbarHeight  49

/**
 *  Colors
 */
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#endif
