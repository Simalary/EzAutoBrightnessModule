#import "EzAutoBrightness.h"

@interface UIImage ()
+ (UIImage *)imageNamed:(NSString *)name inBundle:(NSBundle *)bundle;
@end

@implementation EzAutoBrightness
- (UIImage *)iconGlyph {
	return [UIImage imageNamed:@"Icon" inBundle:[NSBundle bundleForClass:[self class]]];
}

- (UIColor *)selectedColor {
	return [UIColor yellowColor];
}

- (BOOL)isSelected {
	NSString *path = @"/var/mobile/Library/Preferences/com.apple.backboardd.plist";
	NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
	BOOL valueForSilent = [[dict valueForKey:@"BKEnableALS"] boolValue];
	if (valueForSilent) {
		self.autoBrightness = TRUE;
	} else {
		self.autoBrightness = FALSE;
	}
	return self.autoBrightness;
}

- (void)setSelected:(BOOL)selected {
	NSString *path = @"/var/mobile/Library/Preferences/com.apple.backboardd.plist";
	NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
	BOOL valueForSilent = [[dict valueForKey:@"BKEnableALS"] boolValue];
	if (valueForSilent) {
		NSString *sbPath = @"/var/mobile/Library/Preferences/com.apple.backboardd.plist";
		NSMutableDictionary *sbDict = [[NSMutableDictionary alloc] initWithContentsOfFile:sbPath];
		[sbDict setValue:[NSNumber numberWithBool:NO] forKey:@"BKEnableALS"];
		[sbDict writeToFile:sbPath atomically: YES];
		notify_post("com.apple.BackBoard/Prefs");
		notify_post("com.apple.backboardd/Prefs");
		notify_post("com.apple.backboardd");
		notify_post("com.apple.BackBoard");
		notify_post("com.apple.backboardd.BKEnableALS.changed");
		notify_post("com.apple.BackBoard.BKEnableALS.changed");
		CFPreferencesAppSynchronize(CFSTR("com.apple.backboardd"));
		CFPreferencesAppSynchronize(CFSTR("com.apple.BackBoard"));
		CFRelease(CFSTR("com.apple.backboardd"));
		CFRelease(CFSTR("com.apple.BackBoard"));
		selected = FALSE;
	} else {
		NSString *sbPath = @"/var/mobile/Library/Preferences/com.apple.backboardd.plist";
		NSMutableDictionary *sbDict = [[NSMutableDictionary alloc] initWithContentsOfFile:sbPath];
		[sbDict setValue:[NSNumber numberWithBool:YES] forKey:@"BKEnableALS"];
		[sbDict writeToFile:sbPath atomically: YES];
		notify_post("com.apple.BackBoard/Prefs");
		notify_post("com.apple.backboardd/Prefs");
		notify_post("com.apple.backboardd");
		notify_post("com.apple.BackBoard");
		notify_post("com.apple.backboardd.BKEnableALS.changed");
		notify_post("com.apple.BackBoard.BKEnableALS.changed");
		CFPreferencesAppSynchronize(CFSTR("com.apple.backboardd"));
		CFPreferencesAppSynchronize(CFSTR("com.apple.BackBoard"));
		CFRelease(CFSTR("com.apple.backboardd"));
		CFRelease(CFSTR("com.apple.BackBoard"));
		selected = TRUE;
	}
	self.autoBrightness = selected;
	[super refreshState];
}
@end
