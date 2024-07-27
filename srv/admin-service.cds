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
@cds.persistence.skip
@cds
    entity Books as projection on Bookshop1.Books { 
        ID,
        title,
        descr
    };
    
}


extend my.OrderItems {
  book_ID : type of Bookshop1.Books:ID; 
  book      : Association to Bookshop1.Books on book.ID = book_ID  @mandatory @assert.target;
}

// annotate AdminService.Authors with @requires :[ 'privileged-user' ]; 

// annotate AdminService.Orders with @restrict: [
//      { grant: ['READ','UPDATE'],to: 'user',
//        where: 'buyer = $user' } ]; 

