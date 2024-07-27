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


    @odata.draft.enabled entity Orders as select from my.Orders;

    entity Books as projection on Bookshop1.Books{
        ID,
        title,
        descr
    };
}

// annotate AdminService.Authors with @requires :[ 'privileged-user' ]; 

// annotate AdminService.Orders with @restrict: [
//      { grant: ['READ','UPDATE'],to: 'user',
//        where: 'buyer = $user' } ]; 

