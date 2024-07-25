using { sap.common.Languages as CommonLanguages } from '@sap/cds/common';

using { my.bookshop as my } from '../db/index';

using Bookshop1 from '../srv/external/Bookshop1';

@path : 'admin'
service AdminService 
{
    annotate Orders {
        OrderNo
            @mandatory
            @title : '{i18n>OrderNumber}';
        total
            @readonly;
    }

    @odata.draft.enabled
    entity Books as projection on my.Books actions {
            action addToOrder ( order_ID : UUID, quantity : Integer ) returns Orders;
        };

    entity Authors as projection on my.Authors;

    @odata.draft.enabled entity Orders as select from my.Orders;

    entity ExternalBooks as projection on Bookshop1.Books;

    entity ExternalGenres as projection on Bookshop1.Genres;
}

annotate AdminService.Authors with @requires :[ 'privileged-user' ]; 

annotate AdminService.Orders with @restrict: [
     { grant: ['READ','UPDATE'],to: 'user',
       where: 'buyer = $user' } ]; 

