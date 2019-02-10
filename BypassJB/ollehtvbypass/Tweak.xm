#import <substrate.h>
#import <mach-o/dyld.h>

%hook SystemCheckManager 
-(bool)isJailBreak {
	return false;
}


%end
	
int (*orig_100191B50)(void);

int sub_100191B50(void)
{
    return 0;
}

%ctor
{
    @autoreleasepool
    {
        unsigned long test1 = _dyld_get_image_vmaddr_slide(0) + 0x100191B50;
        MSHookFunction((void *)test1, (void *)sub_100191B50, (void **)&orig_100191B50);
    }
}