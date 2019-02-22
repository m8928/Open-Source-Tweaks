/* FAKE: bool __cdecl -[PIODeviceProfiler isJailbroken](PIODeviceProfiler *self, SEL a2) */
#import <substrate.h>
#import <mach-o/dyld.h>


int (*orig_100440E50)(void);

int sub_100440E50(void)
{
    return 1;
}

%ctor
{
    @autoreleasepool
    {
	unsigned long test1 = _dyld_get_image_vmaddr_slide(0) + 0x100440E50;
        MSHookFunction((void *)test1, (void *)sub_100440E50, (void **)&orig_100440E50);
		
    }
}

