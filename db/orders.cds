namespace my.bookshop;


using {
    Currency,
    User,
    managed,
    cuid
} from '@sap/cds/common';

entity Orders : cuid, managed {
    OrderNo  : String @title : '{i18n>OrderNumber}'  @mandatory; //> readable key
    Items    : Composition of many OrderItems
                   on Items.parent = $self;
    buyer    : User;
    total    : Decimal(9, 2)@readonly;
    currency : Currency;
}

entity OrderItems : cuid {
    parent    : Association to Orders;
    quantity  : Integer;
    amount    : Decimal(9, 2);
}