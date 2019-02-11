#import <substrate.h>
#import <mach-o/dyld.h>

%hook NSFileManager
- (BOOL)fileExistsAtPath:(NSString *)path {
		if([path isEqualToString:@"/bin/bash"]) {
					return NO;
				} else if([path isEqualToString:@"/bin/sh"]) {
					return NO;
				} else if([path isEqualToString:@"/Applications/Cydia.app"]) {
					return NO;
				} else {
					return %orig;
					}
				}		
%end


int (*orig_1003178BC)(void);

int sub_1003178BC(void)
{
    return 1;
}



%ctor
{
    @autoreleasepool
    {
        unsigned long test1 = _dyld_get_image_vmaddr_slide(0) + 0x1003178BC;
        MSHookFunction((void *)test1, (void *)sub_1003178BC, (void **)&orig_1003178BC);		
    }
}