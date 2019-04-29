//
//Created by ESJsonFormatForMac on 19/04/29.
//

#import <Foundation/Foundation.h>
#import "NSObject+NSCoding.h"

@class BNAppInfoResultsModel;
@interface BNAppInfoRootModel : NSObject

@property (nonatomic, strong) NSArray *results;
@property (nonatomic, assign) NSInteger resultCount;

@end


@interface BNAppInfoResultsModel : NSObject

@property (nonatomic, copy) NSString *primaryGenreName;
@property (nonatomic, copy) NSString *artworkUrl100;
@property (nonatomic, copy) NSString *sellerUrl;
@property (nonatomic, copy) NSString *currency;
@property (nonatomic, copy) NSString *artworkUrl512;
@property (nonatomic, strong) NSArray *ipadScreenshotUrls;
@property (nonatomic, copy) NSString *fileSizeBytes;
@property (nonatomic, strong) NSArray *genres;
@property (nonatomic, strong) NSArray *languageCodesISO2A;
@property (nonatomic, copy) NSString *artworkUrl60;
@property (nonatomic, strong) NSArray *supportedDevices;
@property (nonatomic, copy) NSString *trackViewUrl;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *bundleId;
@property (nonatomic, copy) NSString *artistViewUrl;
@property (nonatomic, strong) NSArray *genreIds;
@property (nonatomic, strong) NSArray *appletvScreenshotUrls;
@property (nonatomic, assign) BOOL isGameCenterEnabled;
@property (nonatomic, copy) NSString *releaseDate;
@property (nonatomic, copy) NSString *wrapperType;
@property (nonatomic, assign) NSInteger trackId;
@property (nonatomic, copy) NSString *minimumOsVersion;
@property (nonatomic, copy) NSString *formattedPrice;
@property (nonatomic, assign) NSInteger primaryGenreId;
@property (nonatomic, copy) NSString *currentVersionReleaseDate;
@property (nonatomic, assign) NSInteger userRatingCount;
@property (nonatomic, assign) NSInteger artistId;
@property (nonatomic, copy) NSString *trackContentRating;
@property (nonatomic, copy) NSString *artistName;
@property (nonatomic, assign) NSInteger price;
@property (nonatomic, copy) NSString *trackCensoredName;
@property (nonatomic, copy) NSString *trackName;
@property (nonatomic, copy) NSString *kind;
@property (nonatomic, strong) NSArray *features;
@property (nonatomic, copy) NSString *contentAdvisoryRating;
@property (nonatomic, strong) NSArray *screenshotUrls;
@property (nonatomic, copy) NSString *releaseNotes;
@property (nonatomic, assign) BOOL isVppDeviceBasedLicensingEnabled;
@property (nonatomic, copy) NSString *sellerName;
@property (nonatomic, assign) CGFloat averageUserRating;
@property (nonatomic, strong) NSArray *advisories;

@end

