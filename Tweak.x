/*
 * Tweak.x
 * NoRisk
 *
 * Created by Christian Kosman <support@tripleaxis.net> on 12/18/2019.
 * Copyright © 2019 ckosmic <support@tripleaxis.net>. All rights reserved.
 */

#import <Cephei/HBPreferences.h>

static BOOL isEnabled;
static NSInteger numItems;

HBPreferences *preferences;
static UIColor *rColor;
static UIColor *wColor;


@interface CKConversation : NSObject {
	NSArray* _recipients;
}
	@property (assign,nonatomic) NSString * displayName; 
	@property (nonatomic,copy) NSArray * recipientStrings; 
	-(void)setDisplayName:(NSString *)arg1;
	-(void)setPreviewText:(NSString *)arg1;
@end

@interface CKConversationList : NSObject
	-(id)conversations;
@end

@interface CKConversationListController : UITableViewController
	@property (assign,nonatomic) CKConversationList * conversationList;
	@property (nonatomic,retain) UIView * view;
@end

@interface CKConversationListTableView : UITableView
	@property (nonatomic,readonly) CALayer * layer;
@end

@interface CKMessagesController : UISplitViewController {
	CKConversation* _currentConversation;
}
	@property (nonatomic,retain) CKConversationListController * conversationListController;
	-(CKConversation *)currentConversation;
	-(BOOL)isSensitive:(CKConversation *)convo;
@end

@interface CKLabel : UILabel
	-(void)setTextColor:(UIColor *)arg1 ;
@end

@interface CKConversationListStandardCell : UIView
	@property (nonatomic,retain) CKConversation * conversation;
	@property (nonatomic,readonly) CKLabel * fromLabel;
	@property (nonatomic,assign) CGFloat alpha;
@end

@interface CKAvatarTitleCollectionReusableView : UICollectionReusableView 
	@property (nonatomic,retain) CKLabel * titleLabel;
@end

@interface CKMessageEntryContentView : UIScrollView
	@property (assign,nonatomic) CKConversation * conversation;
@end



BOOL isSensitive(CKConversation *convo) {
	NSArray *numbers = (NSArray *)(convo.recipientStrings);
	for(int i = 0; i < numItems; i++) {
		NSString* key = [NSString stringWithFormat:@"number%d", i];
		NSString* value = [preferences objectForKey:key];
		for(NSString *num in numbers) {
			if([num isEqualToString:value])
				return YES;
		}
	}
	return NO;
}

// Conversations list tweak
%hook CKConversationListStandardCell

-(void)setConversation:(CKConversation *)convo {
	%orig;

	if(convo && isEnabled) {
		BOOL effective = isSensitive(self.conversation);
		if(effective) {
			self.fromLabel.textColor = rColor;
		} else {
			self.fromLabel.textColor = wColor;
		}
	}
}

%end

// Text input tweak
%hook CKMessageEntryContentView

-(void)setPlaceholderText:(NSString *)arg1 {
	BOOL effective = isSensitive(self.conversation);
	if(effective && isEnabled)
		%orig(@"Sensitive Chat");
	else
		%orig;
}

%end





%ctor {
	preferences = [[HBPreferences alloc] initWithIdentifier:@"com.ckosmic.cmarkprefs"];
	[preferences registerDefaults:@{
		@"numItems": @0
	}];

	[preferences registerBool:&isEnabled default:YES forKey:@"isEnabled"];
	[preferences registerInteger:(NSInteger *)&numItems default:0 forKey:@"numItems"];

	rColor = [UIColor colorWithRed: 1.0f green: 0.0f blue: 0.0f alpha: 1.0f];
	wColor = [UIColor colorWithRed: 1.0f green: 1.0f blue: 1.0f alpha: 1.0f];
}