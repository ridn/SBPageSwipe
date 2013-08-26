#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@interface SBIconController
+ (id)sharedInstance;
- (void)scrollToIconListAtIndex:(int)arg1 animate:(BOOL)arg2;
- (BOOL)_iconListIndexIsValid:(int)arg1;
@end
%hook SBIconListPageControl
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent*)event
{
	%orig;
	UITouch* touch = [touches anyObject];
	CGPoint startPoint = [touch locationInView:(UIView *)self];
	CGPoint prevLocation = [touch previousLocationInView:(UIView *)self];
	
	//dont hate ;P
	int totalPages = 0;
	for(int i=0; [[objc_getClass("SBIconController") sharedInstance] _iconListIndexIsValid:i]; i++)
	{
		totalPages = i;
	}
	
	if(startPoint.x - prevLocation.x > 0)
	{
		[[objc_getClass("SBIconController") sharedInstance] scrollToIconListAtIndex:totalPages animate:YES];
	}else{
		[[objc_getClass("SBIconController") sharedInstance] scrollToIconListAtIndex:0 animate:YES];
	}

}
%end