#include "ABORootListController.h"

@implementation ABORootListController
- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

-(void)openPayPal {
	[[UIApplication sharedApplication]
	openURL:[NSURL URLWithString:@"http://paypal.me/ckosmic"]
	options:@{}
	completionHandler:nil];
}

-(void)openGithub {
	[[UIApplication sharedApplication]
	openURL:[NSURL URLWithString:@"http://github.com/ckosmic"]
	options:@{}
	completionHandler:nil];
}

@end
