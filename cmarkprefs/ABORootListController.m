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
	openURL:[NSURL URLWithString:@"http://paypal.me/ckosmic"]];
}

-(void)openGithub {
	[[UIApplication sharedApplication]
	openURL:[NSURL URLWithString:@"https://github.com/ckosmic/NoRisk"]];
}

@end
