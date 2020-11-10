unit Export_SQL;

interface

const


     // this can be wrong where the same property ID is current from Office  XYZ but not on REA
     // and also moved to SOLD from another office for an REA listing.
     // qryProp does not load into current listings because it is not a REA listing
     // qryExport does load it
     sqlExport =
               'SELECT                                                       ' +
               '       ID,                                                   ' +
               '       OFFICE_ID,                                            ' +
               '       LAST_CHANGED,                                         ' +
               '       LAST_INSERT,                                          ' +
               '       LISTING_TYPE,                                          ' +
               '       INTERNET_ID, UNIQUE_REA_ID '+
               'FROM  DIST_EXPORT2 A  ' +
               'INNER JOIN  AGENT B ON ( A.OFFICE_ID =  B.AGENT_ID )      ' +
               'WHERE  DIST_ID = %d     ' +
               'ORDER BY OFFICE_ID, ID ' ;

     sqlPropDetail =
               'SELECT                                                       ' +
               '      A.ADDRESS,                                             ' +
               '      A.SUBURB,                                              ' +
               '      A.POSTCODE,                                            ' +
               '      A.PRICE,                                               ' +
               '      ISNULL(A.WEB_SEARCH_PRICE,0)AS WEB_PRICE,              ' + //new
               '      A.PROPERTY_TYPE,                                       ' +
               '      A.LAST_CHANGED,                                        ' +
               '      A.AUCTION_TIME,                                        ' +
               '      A.AUCTION_DATE,                                        ' +
               '      A.SALES_METHOD,                                        ' +
               '      A.USER_ID,                                             ' +
               '      A.LISTER,                                              ' +
               '      A.CONTACT_USER_ID1,                                    ' +
               '      A.CONTACT_USER_ID2,                                    ' +
               '      A.CONTACT_USER_ID3,                                    ' +
               '      A.CONTACT_USER_ID4,                                    ' +
               '      A.CONTACT_USER_ID5,                                    ' +
               '      A.CONTACT_USER_ID6,                                    ' +
               '      A.MAP_REF,                                             ' +
               '      A.EXPIRY_DATE,                                         ' +
               '      A.PROPERTY_STATES,                                     ' +
               '      A.SOLD_PRICE,                                          ' +
               '      A.LAST_SOLD,                                           ' +
               '      A.PRICE_DESCRIPTION,                                   ' +
               '      A.ADDRESS_DESCRIPTION,                                 ' +
               '      A.PRICE_PER_YEAR,                                      ' +
               '      A.RENT_PERIOD,                                         ' +
               '      IsNull(A.BOND,0) AS BOND,                              ' +
               '      A.BUS_SALE_TERMS,                                         ' +
               '      A.BUS_TAKINGS,                                         ' +
               '      A.BUS_ANNUAL_RETURN,                                         ' +
               '      A.BUS_ANNUAL_NET_PROFIT,                                         ' +
               '      A.BUS_CURRENT_RENT,                                         ' +
               '      A.BUS_LEASE_END,                                         ' +
               '      A.BUS_FURTHER_OPTIONS,                                         ' +
               '      A.BUS_CATEGORY1,                                         ' +
               '      A.BUS_SUBCATEGORY1,                                         ' +
               '      A.BUS_CATEGORY2,                                         ' +
               '      A.BUS_SUBCATEGORY2,                                         ' +
               '      A.BUS_CATEGORY3,                                         ' +
               '      A.BUS_SUBCATEGORY3, ' +
               '      A.BUS_GST, ' +
               '      A.UNDEROFFER, ' +
               '      isnull(off_market,0) as off_market, '+
               '      A.InterNetID, '+
               '      A.UNIQUE_REA_ID, '+
               '      IsNull(A.DO_NOT_DISCLOSE,0) as   DO_NOT_DISCLOSE, ' +
               '      A.DISTRIBUTOR1, A.DISTRIBUTOR2,A.DISTRIBUTOR3,A.DISTRIBUTOR4,A.DISTRIBUTOR5,A.DISTRIBUTOR6, ' +
               '      A.DISTRIBUTOR7,A.DISTRIBUTOR8,A.DISTRIBUTOR9,A.DISTRIBUTOR10, ' +
               '      B.HOW_TO_INSPECT,                                      ' +
               '      B.OFI_START1,                                          ' +
               '      B.OFI_START2,                                          ' +
               '      B.OFI_START3,                                          ' +
               '      B.OFI_START4,                                          ' +
               '      B.OFI_START5,                                          ' +
               '      B.OFI_START6,                                          ' +
               '      B.OFI_END1,                                            ' +
               '      B.OFI_END2,                                            ' +
               '      B.OFI_END3,                                            ' +
               '      B.OFI_END4,                                            ' +
               '      B.OFI_END5,                                            ' +
               '      B.OFI_END6,                                            ' +
               '      B.PROPERTY_FEATURES,                                            ' +
               '      C.MUNICIPALITY,                                        ' +
               '      C.LAND_AREA,                                           ' +
               '      C.LAND_AREA_QUANTITY,                                  ' +
               '      C.BUILDING_AREA,                                       ' +
               '      C.FLOOR_AREA,                                          ' +
               '      C.NUM_ROOMS,                                           ' +
               '      C.NUM_BEDROOMS,                                        ' +
               '      C.PRECIS_DESCRIPTION,                                  ' +
               '      C.GARAGE,                                              ' +
               '      C.AIRCOND,                                             ' +
               '      C.BATHROOM1,                                           ' +
               '      C.HEATING,                                             ' +
               '      C.HWS,                                                 ' +
               '      C.ADVERTISING_TITLE,                                   ' +
               '      C.NUMBER_OF_ROOMS,                                     ' +
               '      C.NUMBER_OF_BEDROOMS,                                  ' +
               '      C.NUMBER_OF_BATHROOMS,                                 ' +
               '      C.NUMBER_OF_GARAGES,                                   ' +
               '      C.NUMBER_OF_CAR_SPACES,                                ' +
               '      C.NUMBER_OF_CAR_PORTS,                                 ' +
               '      C.NUMBER_OF_TOILETS,                                   ' +
               '      E.TRANSLATED_ID                                   ' +
               'FROM                                                         ' +
               '                PROP                            A            ' +
               'INNER JOIN                                                   ' +
               '                PROP_VENDOR                     B            ' +
               '    ON                                                       ' +
               '                ( A.ID                  =       B.ID        )' +
               '        AND                                                  ' +
               '                ( A.OFFICE_ID           =       B.OFFICE_ID )' +
               'INNER JOIN                                                   ' +
               '                PROP_DESC                       C            ' +
               '    ON                                                       ' +
               '                ( A.ID                  =       C.ID        )' +
               '        AND                                                  ' +
               '                ( A.OFFICE_ID           =       C.OFFICE_ID )' +
               'INNER JOIN                                                   ' +
               '                DIST_AGENCY_ID_TRANSLATION      E            ' +
               '    ON                                                       ' +
               '                ( A.OFFICE_ID           =       E.OFFICE_ID )' +

               'WHERE                                                        ' +
               '      A.ID                 =    %d                           ' +
               '  AND                                                        ' +
               '      A.OFFICE_ID          =    %d                           ' +
               '  AND                                                        ' +
               '      E.DIST_ID            =    %d                           ' ;


     sqlCheckPropSold =
               'SELECT                                                       ' +
               '      COUNT( * ) AS ID_COUNT                                 ' +
               'FROM PROP WHERE                                              ' +
               '      ID                   =    :ID                          ' +
               '  AND                                                        ' +
               '      OFFICE_ID            =    :OFFICE_ID                   ' +
               '  AND                                                        ' +
               '      PROPERTY_STATES      =    2                            ' ;

     sqlCheckPropSold_Valid =
               'SELECT                                                       ' +
               '      A.PROPERTY_TYPE,                                       ' +
               '      A.SALES_METHOD,                                        ' +
               '      A.SOLD_PRICE,                                          ' +
               '      A.LAST_SOLD,                                           ' +
               '      B.LAND_AREA,                                           ' +
               '      B.NUM_ROOMS,                                           ' +
               '      B.NUM_BEDROOMS,                                        ' +
               '      B.NUMBER_OF_ROOMS,                                     ' +
               '      B.NUMBER_OF_BEDROOMS,                                  ' +
               '      B.LAND_AREA_QUANTITY                                   ' +
               'FROM                                                         ' +
               '                PROP                            A            ' +
               'INNER JOIN                                                   ' +
               '                PROP_DESC                       B            ' +
               '    ON                                                       ' +
               '                ( A.ID                  =       B.ID        )' +
               '        AND                                                  ' +
               '                ( A.OFFICE_ID           =       B.OFFICE_ID )' +
               'WHERE                                                        ' +
               '      A.ID                 =    :ID                          ' +
               '  AND                                                        ' +
               '      A.OFFICE_ID          =    :OFFICE_ID                   ' ;

     sqlTranslatedAgentId =
               'SELECT                                                       ' +
               '      TRANSLATED_ID                                          ' +
               'FROM DIST_AGENCY_ID_TRANSLATION                              ' +
               'WHERE                                                        ' +
               '     OFFICE_ID             =    :OFFICE_ID                   ' +
               'AND                                                          ' +
               '     DIST_ID               =    :DIST_ID                     ' ;

     SQL_USERS =
               'SELECT                                                       ' +
               '      FULL_NAME,                                             ' +
               '      USER_PHONE_BH,                                         ' +
               '      USER_MOBILE,                                           ' +
               '      USER_EMAIL                                             ' +
               'FROM USERS                                                   ' +
               'WHERE                                                        ' +
               '     USER_OFFICE_ID        =    :USER_OFFICE_ID              ' +
               'AND                                                          ' +
               '     USER_ID               =    :USER_ID                     ' ;

     SQL_PROP_OFI =
               'SELECT                                                       ' +
               '       OFI_START,                                            ' +
               '       OFI_END                                               ' +
               'FROM PROP_OFI                                                ' +
               'WHERE                                                        ' +
               '       ID = :ID                                              ' +
               'AND                                                          ' +
               '       OFFICE_ID = :OFFICE_ID                                ' +
               'ORDER BY                                                     ' +
               '       OFI_START                                             ' ;

     SQL_PROP_DIST_CATEGORY =
               'SELECT                                                       ' +
               '       B.CATEGORY_NAME_DIST_CODE                             ' +
               'FROM                                                         ' +
               '       PROP_DIST_CATEGORY A                                  ' +
               'INNER JOIN                                                   ' +
               '       PROP_DIST_CATEGORY_NAME B                             ' +
               'ON                                                           ' +
               '       A.CATEGORY_NAME_ID = B.CATEGORY_NAME_ID               ' +
               'WHERE                                                        ' +
               '       A.ID = :ID                                            ' +
               'AND                                                          ' +
               '       A.OFFICE_ID = :OFFICE_ID                              ' +
               'AND                                                          ' +
               '       B.CATEGORY_NAME_DIST_ID = :CATEGORY_NAME_DIST_ID      ' +
               'ORDER BY                                                     ' +
               '       B.CATEGORY_NAME_LEVEL                                 ' ;

     SQL_PROP_IMAGE =
        'SELECT                                                              ' +
        '   IMAGE_ID,                                                        ' +
        '   IMAGE_ORDER                                                      ' +
        'FROM PROP_IMAGE                                                     ' +
        'WHERE                                                               ' +
        '   ID = :ID                                                         ' +
        'AND                                                                 ' +
        '   OFFICE_ID = :OFFICE_ID                                           ' +
        'AND                                                                 ' +
        '   CATEGORY = :CATEGORY                                             ' +
        'ORDER BY IMAGE_ORDER                                                ' ;

     SQL_PROP_IMAGE_FILE =
        'SELECT                                                              ' +
        '   IMAGE_FILE_ID,                                                   ' +
        '   IMAGE_FILE                                                       ' +
        'FROM                                                                ' +
        '   PROP_IMAGE_FILE                                                  ' +
        'WHERE                                                               ' +
        '   IMAGE_ID        = :IMAGE_ID                                      ' +
        'AND                                                                 ' +
        '   ID              = :ID                                            ' +
        'AND                                                                 ' +
        '   OFFICE_ID       = :OFFICE_ID                                     ' +
        'AND                                                                 ' +
        '   RESOLUTION_TYPE = :RESOLUTION_TYPE                               ' ;




implementation

end.
