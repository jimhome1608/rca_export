unit Export_Text;

interface

const
     delimiter = ',';

     CRLF = #13 + #10;

     EXPORT_HEADER =
        '<?xml version="1.0" standalone="no"?>'                                             + CRLF +
        ''                                                                                  + CRLF +
        '<!DOCTYPE propertyList SYSTEM "http://reaxml.realestate.com.au/propertyList.dtd">' + CRLF +
        ''                                                                                  + CRLF +
        '<propertyList date="%s" username="%s" password="%s">'                              + CRLF ;

     EXPORT_FOOTER =
        '</propertyList>'                                                                   + CRLF ;

     EXPORT_LINE =
        '  <%s modTime="%s" status="%s">'                                                   + CRLF +
        '    <agentID>%s</agentID>'                                                         + CRLF +
        '    <uniqueID>%s</uniqueID>'                                                       + CRLF +
        // COMMERCIAL_LISTING_TYPE = SALE OR LEASE
        '%s'                                                                                +
        // EXPORT_AUTHORITY
        '%s'                                                                                +
        // EXPORT_LISTING_AGENT
        '%s'                                                                                +
        // EXPORT_DATE_AVAILABLE
        '%s'                                                                                +
        // EXPORT_RENT_PRICE
        '%s'                                                                                +
        // EXPORT_COMMERCIAL_RENT_PRICE
        '%s'                                                                                +
        // EXPORT_SALE_PRICE
        '%s'                                                                                +
        '    <address display="%s">'                                                        + CRLF +
        '      <subNumber></subNumber> '                                                     + CRLF +
        '      <streetNumber>%s</streetNumber>'                                             + CRLF +
        '      <street>%s</street>'                                                         + CRLF +
        '      <suburb>%s</suburb>'                                                         + CRLF +
        '      <state>%s</state>'                                                           + CRLF +
        '      <postcode>%s</postcode>'                                                     + CRLF +
        '    </address>'                                                                    + CRLF +
        '    <municipality></municipality>'                                                 + CRLF +
        '    <streetDirectory type="melways">'                                              + CRLF +
        '      <page>%s</page>'                                                             + CRLF +
        '      <reference>%s</reference>'                                                   + CRLF +
        '    </streetDirectory>'                                                            + CRLF +
        '    <holiday value="no" />'                                                            + CRLF +
        '    <underOffer value="%s" />'+ CRLF +
        ' %s '+  // several lines releating to business.
        ' %s '+ // EXPORT_CATEGORY. ie: ruralCategory name="..." or category name="House"
        ' %s '+ // EXPORT_BUSINESS_SUBCATEGORY
        '    <headline>%s</headline>'                                                       + CRLF +
        '    <description>%s</description>'                                                 + CRLF +
        // EXPORT_RESIDENTIAL_FEATURES
        '%s'                                                                                +
        // EXPORT_SOLD_DETAILS
        '%s'                                                                                +
        '    <landDetails>'                                                                 + CRLF +
        '      <area unit="squareMeter">%s</area>'                                          + CRLF +
        '    </landDetails>'                                                                + CRLF +
        // EXPORT_BUILDING_DETAILS
        '%s'                                                                                +
        // EXPORT_INSPECTION_TIMES
        '    <inspectionTimes>'                                                             + CRLF +
        '%s'                                                                                +
        '    </inspectionTimes>'                                                            + CRLF +
        // EXPORT_AUCTION_DATE
        '%s'                                                                                +
        //EXPORT_EXTERNAL_LINK
        '%s'                                                                                +
        //_videoLink
        '%s'                                                                                +
         //<media>   STATEMENT OF INFORMATION
        '%s'                                                                                +
        //EXPORT_OBJECTS
        '%s'                                                                                +
        // <offmarket>0</offmarket>
        '%s'                                                                                +        
        // closing </residential> tag
        '  </%s>'                                                                           + CRLF +
        '';
        
     EXPORT_BUS_LEASE_END =   '<currentLeaseEndDate>%S</currentLeaseEndDate>'+ CRLF ;    //<currentLeaseEndDate>2004-01-10 12:30:00</currentLeaseEndDate>
     EXPORT_BUS_FURTHER_OPTIONS =   '<furtherOptions>%S</furtherOptions>'+ CRLF ;
     EXPORT_BUS_SALE_TERMS =   '<terms>%S</terms>'+ CRLF ;

     EXPORT_CATEGORY =
        '    <%s%s name="%s" />'                                                            + CRLF ;

     EXPORT_BUSINESS_CATEGORY =
        '    <businessCategory>%s</businessCategory>'                                       + CRLF ;

     EXPORT_BUSINESS_SUBCATEGORY =
        '    <businessSubCategory>%s</businessSubCategory>'                                 + CRLF ;

     EXPORT_AUTHORITY =
        '    <authority value="%s" />'                                                      + CRLF ;

     EXPORT_COMMERCIAL_AUTHORITY =
        '    <commercialAuthority value="%s" />'                                            + CRLF ;

     EXPORT_COMMERCIAL_LISTING_TYPE_SALE =
        '    <commercialListingType value="sale"/>'                                         + CRLF ;

     EXPORT_COMMERCIAL_LISTING_TYPE_LEASE =
        '    <commercialListingType value="lease"/>'                                        + CRLF ;

     EXPORT_COMMERCIAL_LISTING_TYPE_BOTH =
        '    <commercialListingType value="both"/>'                                        + CRLF ;

     EXPORT_LISTING_AGENT =
        '    <listingAgent id="%d">'                                                                + CRLF +
        '      <name>%s</name>'                                                             + CRLF +
        '      <telephone type="BH">%s</telephone>'                                         + CRLF +
        '      <telephone type="mobile">%s</telephone>'                                     + CRLF +
        '      <email>%s</email>'                                                           + CRLF +
        '    </listingAgent>'                                                               + CRLF ;


     EXPORT_COMMERCIAL_LISTING_TYPE =
        '    <commercialListingType value="%s" />'                                          + CRLF ;

     EXPORT_DATE_AVAILABLE =
        '    <dateAvailable>%s</dateAvailable>'                                             + CRLF ;

     EXPORT_RENT_PRICE =
        '    <rent period="week">%d</rent>'                                                 + CRLF +
        '    <bond>%d</bond>'                                                               + CRLF ;

     EXPORT_COMMERCIAL_RENT_PRICE =
        '    <commercialRent period="annual">%d</commercialRent>'                           + CRLF ;

     EXPORT_SALE_PRICE =
        '    <price display="yes">%d</price>'                                               + CRLF +
        '    <priceView>%s</priceView>'                                                     + CRLF ;
     EXPORT_NO_SUBSTITUTE_PRICE =
        //'    <price display="no"></price>'                                               + CRLF +
        '    <priceView></priceView>'                                                    + CRLF ;

     EXPORT_LAND_DEFAULT_CATEGORY = 'Residential';

     EXPORT_COMMERCIAL_DEFAULT_CATEGORY = 'Other';

     

     EXPORT_BUILDING_DETAILS =
        '    <buildingDetails>'                                                             + CRLF +
        '      <area unit="squareMeter">%s</area>'                                               + CRLF +   //
        '    </buildingDetails>'                                                            + CRLF ;

     EXPORT_INSPECTION_LINE =
        '      <inspection>%s%s</inspection>'                                               + CRLF ;

     EXPORT_AUCTION_DATE =
        '    <auction date="%s" />'                                                         + CRLF ;

     EXPORT_EXTERNAL_LINK =
        '    <externalLink href="%s" />'                                                    + CRLF ;

     EXPORT_VIDEOLINK_LINK =     //<videoLink href="http://www.realestate.com.au/videos/VictoriaSt.avi"/>
        '    <videoLink href="%s" />'                                                        + CRLF ;

     EXPORT_OBJECTS =
        '    <objects>'                                                                     + CRLF +
        '%s%s'                                                                              +
        '    </objects>'                                                                    + CRLF ;

     EXPORT_IMAGES_LINE =
        '      <img id="%s" modTime="%s" url="%s" />'                                       + CRLF ;

     IMAGE_NOT_AVAILABLE =
        'http://www.multilink.com.au/images/not_available.jpg'                              ;

     EXPORT_FLOORPLANS_LINE =
        '      <floorplan id="%d" modTime="%s" url="%s" />'                                 + CRLF ;

     EXPORT_WITHDRAWN_LINE =
        '  <%s modTime="%s" status="%s">'                                                   + CRLF +
        '    <agentID>%s</agentID>'                                                         + CRLF +
        '    <uniqueID>%s</uniqueID>'                                                       + CRLF +
        '  </%s>'                                                                           + CRLF +
        '';

     EXPORT_SOLD_DETAILS_DISPLAY_NO =
        '    <soldDetails>'                                  + CRLF +
        '      <date>%s</date>'                              + CRLF +
        '      <soldPrice display="no">%d</soldPrice>'   + CRLF +
        '    </soldDetails>'                                 + CRLF ;
     EXPORT_SOLD_DETAILS_DISPLAY_YES =
        '    <soldDetails>'                                  + CRLF +
        '      <date>%s</date>'                              + CRLF +
        '      <soldPrice display="yes">%d</soldPrice>'   + CRLF +
        '    </soldDetails>'                                 + CRLF ;



implementation

end.
