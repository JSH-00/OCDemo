#pragma mark - "AppDelegate.h"
/*
 GCDWebServer 导入工程文件
 https://github.com/swisspol/GCDWebServer
 */
#pragma mark - "AppDelegate.h"
#import "GCDWebUploader.h"
@interface AppDelegate : NSObject <UIApplicationDelegate> {
  GCDWebUploader* _webUploader;
}
@end

#pragma mark - "AppDelegate.m"
@implementation AppDelegate

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
  NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
  _webUploader = [[GCDWebUploader alloc] initWithUploadDirectory:documentsPath];
  [_webUploader start];
  NSLog(@"Visit %@ in your web browser", _webUploader.serverURL);
  return YES;
}

@end

#pragma mark - "Podfile"

pod "GCDWebServer", "~> 3.0"
pod "GCDWebServer/WebUploader", "~> 3.0"
pod "GCDWebServer/WebDAV", "~> 3.0"
