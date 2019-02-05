#import <substrate.h>
#import <mach-o/dyld.h>

int (*orig_100C5EDBC)(void);

int sub_100C5EDBC(void)
{
    return -100;
}

int (*orig_100890A4C)(void);

int sub_100890A4C(void)
{
    return 0x2335;
}

%ctor
{
    @autoreleasepool
    {
        unsigned long test1 = _dyld_get_image_vmaddr_slide(0) + 0x100C5EDBC;
        MSHookFunction((void *)test1, (void *)sub_100C5EDBC, (void **)&orig_100C5EDBC);

	unsigned long test2 = _dyld_get_image_vmaddr_slide(0) + 0x100890A4C;
        	MSHookFunction((void *)test2, (void *)sub_100890A4C, (void **)&orig_100890A4C);

		
    }
}

