#import "CardculatorCCModule.h"

@implementation CardculatorCCModule

//Return the icon of your module here
- (UIImage *)iconGlyph
{
	return [UIImage imageNamed:@"CCIcon" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
}

//Return the color selection color of your module here
- (UIColor *)selectedColor
{
	return [UIColor blueColor];
}

- (BOOL)isSelected
{
  return NO;
}

- (void)setSelected:(BOOL)selected
{
  [super refreshState];
  [[NSNotificationCenter defaultCenter] 
        postNotificationName:@"PresentCalculator" 
        object: nil];
}

@end
