using {sap.common.Languages as CommonLanguages} from '@sap/cds/common';
using {my.bookshop as my} from '../db/index';
using {sap.changelog as changelog} from 'com.sap.cds/change-tracking';

extend my.Orders with changelog.changeTracked;

@path : 'admin'
service AdminService @(requires : 'admin') {
    
  entity Books   as projection on my.Books  actions {
    action addToOrder(order_ID : UUID, quantity : Integer) returns Orders;
  };

  entity Authors as projection on my.Authors;
  entity Orders  as select from my.Orders;

}


// Enable Fiori Draft for Orders
annotate AdminService.Orders with @odata.draft.enabled;
annotate AdminService.Books with @odata.draft.enabled;


