#import <substrate.h>
#import <mach-o/dyld.h>

%hook NSString 
- (BOOL)writeToFile:(NSString *)path  {
		if([path isEqualToString:@"/private/JailbreakTest.txt"]) {
					return NO;
				} 
		else {
					return %orig;
					}
				}
%end


%hook UIApplication 
- (BOOL)canOpenURL:(NSURL *)url {
    if([[url absoluteString] isEqualToString:@"cydia://package/com.example.package"]) {
		return NO;
				}

		else {
					return %orig;
					}
				}
%end

%hook NSFileManager
- (BOOL)fileExistsAtPath:(NSString *)path {
		if([path isEqualToString:@"/Applications/Cydia.app"]) {
					return NO;
				} else if([path isEqualToString:@"/Library/MobileSubstrate/MobileSubstrate.dylib"]) {
					return NO;
				} else if([path isEqualToString:@"/var/tmp/cydia.log"]) {
					return NO;
				} else if([path isEqualToString:@"/usr/libexec/ssh-keysign"]) {
					return NO;
				} else if([path isEqualToString:@"/etc/ssh/sshd_config"]) {
					return NO;
				} else if([path isEqualToString:@"/private/var/lib/apt/"]) {
					return NO;
				} else if([path isEqualToString:@"/bin/bash"]) {
					return NO;
				} else if([path isEqualToString:@"/bin/sh"]) {
					return NO;
				} else {
					return %orig;
					}
				}		
%end

int (*orig_10003FC2C)(void);

int sub_10003FC2C(void)
{
    return 0;
}

%ctor
{
    @autoreleasepool
    {
        unsigned long test1 = _dyld_get_image_vmaddr_slide(0) + 0x10003FC2C;
        MSHookFunction((void *)test1, (void *)sub_10003FC2C, (void **)&orig_10003FC2C);
		
    }
}