#import <substrate.h>

%hook AppDelegate 
-(bool)checkIxSheild{
	return 0;
}
%end