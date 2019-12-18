#import <Preferences/PSSpecifier.h>
#import <Preferences/PSListController.h>
#import <Cephei/HBPreferences.h>

@interface PSEditableListController : PSListController
@end
@interface ABONewListController : PSEditableListController
@end

HBPreferences *preferences;

@implementation ABONewListController
- (id)specifiers {
	if (!_specifiers) {
		preferences = [[HBPreferences alloc] initWithIdentifier:@"com.ckosmic.cmarkprefs"];

		NSMutableArray *specArray = [[NSMutableArray alloc] init];
		NSInteger numItems = [preferences integerForKey:@"numItems"];

		for(int i = 0; i < numItems; i++) {
			NSString* title = [NSString stringWithFormat:@"Number %d:", i+1];
			NSString* key = [NSString stringWithFormat:@"number%d", i];

			PSSpecifier* specifier = [PSSpecifier preferenceSpecifierNamed:title
									    target:self
									       set:@selector(setPreferenceValue:specifier:)
									       get:@selector(readPreferenceValue:)
									    detail:Nil
									      cell:PSEditTextCell
									      edit:Nil];
			[specifier setProperty:@YES forKey:@"enabled"];
			[specifier setProperty:@"com.ckosmic.cmarkprefs" forKey:@"defaults"];
			[specifier setProperty:key forKey:@"key"];
			[specifier setProperty:NSStringFromSelector(@selector(removedSpecifier:)) forKey:PSDeletionActionKey];
			[specArray addObject:specifier];
		}
		PSSpecifier* addButton = [PSSpecifier preferenceSpecifierNamed:@"Add New Item..."
							target:self
							set:nil
							get:nil
							detail:nil
							cell:PSButtonCell
							edit:nil];
		[addButton setProperty:@YES forKey:@"enabled"];
		addButton.buttonAction = @selector(addNewItem:);
		[specArray addObject:addButton];

		for(PSSpecifier* spec in [self loadSpecifiersFromPlistName:@"RiskyNumbers" target:self]) {
			[specArray addObject:spec];
		}

		_specifiers = specArray;
	}
	return _specifiers;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	return UITableViewCellEditingStyleDelete;
}

- (void)addNewItem:(PSSpecifier*)specifier {
	NSInteger numItems = [preferences integerForKey:@"numItems"];
	numItems++;
	[preferences setInteger:numItems forKey:@"numItems"];
	[super reloadSpecifiers];
}

-(void)removedSpecifier:(PSSpecifier*)specifier{
	NSString *identifier = [specifier identifier];
	identifier = [identifier stringByReplacingOccurrencesOfString:@"number" withString:@""];
	int index = [identifier intValue];
	NSInteger numItems = [preferences integerForKey:@"numItems"];
	for(int i = index; i < numItems - 1; i++) {
		NSString* key = [NSString stringWithFormat:@"number%d", i];
		NSString* keyUpper = [NSString stringWithFormat:@"number%d", i + 1];
		NSString* upperValue = [preferences objectForKey:keyUpper];
		[preferences setObject:upperValue forKey:key];
	}
	NSString* key = [NSString stringWithFormat:@"number%d", (int)(numItems) - 1];
	[preferences removeObjectForKey:key];

	numItems--;
	[preferences setInteger:numItems forKey:@"numItems"];
	[super reloadSpecifiers];
}
@end