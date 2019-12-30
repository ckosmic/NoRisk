#line 1 "Tweak.x"








#import <Cephei/HBPreferences.h>

static BOOL isEnabled;
static NSInteger numItems;

HBPreferences *preferences;
static UIColor *rColor;
static UIColor *wColor;
static UIColor *bColor;
static UIColor *dColor;


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
	@property (nonatomic,readonly) UITraitCollection * traitCollection;
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



#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class CKMessageEntryContentView; @class CKConversationListStandardCell; 
static void (*_logos_orig$_ungrouped$CKConversationListStandardCell$setConversation$)(_LOGOS_SELF_TYPE_NORMAL CKConversationListStandardCell* _LOGOS_SELF_CONST, SEL, CKConversation *); static void _logos_method$_ungrouped$CKConversationListStandardCell$setConversation$(_LOGOS_SELF_TYPE_NORMAL CKConversationListStandardCell* _LOGOS_SELF_CONST, SEL, CKConversation *); static void (*_logos_orig$_ungrouped$CKMessageEntryContentView$setPlaceholderText$)(_LOGOS_SELF_TYPE_NORMAL CKMessageEntryContentView* _LOGOS_SELF_CONST, SEL, NSString *); static void _logos_method$_ungrouped$CKMessageEntryContentView$setPlaceholderText$(_LOGOS_SELF_TYPE_NORMAL CKMessageEntryContentView* _LOGOS_SELF_CONST, SEL, NSString *); 

#line 86 "Tweak.x"


static void _logos_method$_ungrouped$CKConversationListStandardCell$setConversation$(_LOGOS_SELF_TYPE_NORMAL CKConversationListStandardCell* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, CKConversation * convo) {
	_logos_orig$_ungrouped$CKConversationListStandardCell$setConversation$(self, _cmd, convo);

	if(convo && isEnabled) {
		BOOL effective = isSensitive(self.conversation);
		if(dColor == nil) dColor = self.fromLabel.textColor;
		if(effective) {
			self.fromLabel.textColor = rColor;
		} else {
			
			self.fromLabel.textColor = dColor;
		}
	}
}






static void _logos_method$_ungrouped$CKMessageEntryContentView$setPlaceholderText$(_LOGOS_SELF_TYPE_NORMAL CKMessageEntryContentView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSString * arg1) {
	BOOL effective = isSensitive(self.conversation);
	if(effective && isEnabled)
		_logos_orig$_ungrouped$CKMessageEntryContentView$setPlaceholderText$(self, _cmd, @"Sensitive Chat");
	else
		_logos_orig$_ungrouped$CKMessageEntryContentView$setPlaceholderText$(self, _cmd, arg1);
}







static __attribute__((constructor)) void _logosLocalCtor_60a54890(int __unused argc, char __unused **argv, char __unused **envp) {
	preferences = [[HBPreferences alloc] initWithIdentifier:@"com.ckosmic.cmarkprefs"];
	[preferences registerDefaults:@{
		@"numItems": @0
	}];

	[preferences registerBool:&isEnabled default:YES forKey:@"isEnabled"];
	[preferences registerInteger:(NSInteger *)&numItems default:0 forKey:@"numItems"];

	rColor = [UIColor colorWithRed: 1.0f green: 0.0f blue: 0.0f alpha: 1.0f];
	wColor = [UIColor colorWithRed: 1.0f green: 1.0f blue: 1.0f alpha: 1.0f];
	bColor = [UIColor colorWithRed: 0.0f green: 0.0f blue: 0.0f alpha: 1.0f];
}
static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$CKConversationListStandardCell = objc_getClass("CKConversationListStandardCell"); MSHookMessageEx(_logos_class$_ungrouped$CKConversationListStandardCell, @selector(setConversation:), (IMP)&_logos_method$_ungrouped$CKConversationListStandardCell$setConversation$, (IMP*)&_logos_orig$_ungrouped$CKConversationListStandardCell$setConversation$);Class _logos_class$_ungrouped$CKMessageEntryContentView = objc_getClass("CKMessageEntryContentView"); MSHookMessageEx(_logos_class$_ungrouped$CKMessageEntryContentView, @selector(setPlaceholderText:), (IMP)&_logos_method$_ungrouped$CKMessageEntryContentView$setPlaceholderText$, (IMP*)&_logos_orig$_ungrouped$CKMessageEntryContentView$setPlaceholderText$);} }
#line 135 "Tweak.x"
