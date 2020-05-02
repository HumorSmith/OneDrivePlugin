#import "OnedrivepluginPlugin.h"
#if __has_include(<onedriveplugin/onedriveplugin-Swift.h>)
#import <onedriveplugin/onedriveplugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "onedriveplugin-Swift.h"
#endif

@implementation OnedrivepluginPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftOnedrivepluginPlugin registerWithRegistrar:registrar];
}
@end
