#include <mach-o/dyld.h>
#include <stdio.h>

%hook I3GDeviceInfo
+(id)getJailbreakInfo {
return (id)CFSTR("NO");
}
%end

%hook ams2Library
-(long long) a3142:(id)arg1 { return %orig - 10; }
%end

%hook BTWCGXMLParser
-(bool) isJailBroken {
  return false;
}

-(id)checkRooting:(id)arg1 {
	return (id)CFSTR("0");
}

%end

%hook Codeguard
+(bool) isJailBroken {
return false;
}
%end


%hook AppDelegate 
-(void) scsc {
;
}

-(void) fgc {
;
}

-(void) igc {
;
}
%end