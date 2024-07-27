/* checksum : 1c16baf7d47329c13299733845d54855 */
@cds.external : true
@cds.persistence.skip : true
@Common.DraftRoot : {
  $Type: 'Common.DraftRootType',
  ActivationAction: 'Bookshop1.draftActivate',
  EditAction: 'Bookshop1.draftEdit',
  PreparationAction: 'Bookshop1.draftPrepare'
}
entity Bookshop1.Books {
  @Core.ComputedDefaultValue : true
  key ID : UUID not null;
  @odata.Precision : 7
  @odata.Type : 'Edm.DateTimeOffset'
  @UI.HiddenFilter : true
  @UI.ExcludeFromNavigationContext : true
  @Core.Immutable : true
  @Core.Computed : true
  @Common.Label : '{i18n>CreatedAt}'
  createdAt : Timestamp;
  /** {i18n>UserID.Description} */
  @UI.HiddenFilter : true
  @UI.ExcludeFromNavigationContext : true
  @Core.Immutable : true
  @Core.Computed : true
  @Common.Label : '{i18n>CreatedBy}'
  createdBy : String(255);
  @odata.Precision : 7
  @odata.Type : 'Edm.DateTimeOffset'
  @UI.HiddenFilter : true
  @UI.ExcludeFromNavigationContext : true
  @Core.Computed : true
  @Common.Label : '{i18n>ChangedAt}'
  modifiedAt : Timestamp;
  /** {i18n>UserID.Description} */
  @UI.HiddenFilter : true
  @UI.ExcludeFromNavigationContext : true
  @Core.Computed : true
  @Common.Label : '{i18n>ChangedBy}'
  modifiedBy : String(255);
  title : String(111);
  descr : String(1111);
  author : Association to one Bookshop1.Authors {  };
  author_ID : UUID;
  genre : Association to one Bookshop1.Genres {  };
  @Common.ValueList : {
    $Type: 'Common.ValueListType',
    Label: 'Genres',
    CollectionPath: 'Genres',
    Parameters: [
      {
        $Type: 'Common.ValueListParameterInOut',
        LocalDataProperty: genre_ID,
        ValueListProperty: 'ID'
      },
      {
        $Type: 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'name'
      }
    ]
  }
  genre_ID : Integer;
  stock : Integer;
  price : Decimal(9, 2);
  /** {i18n>CurrencyCode.Description} */
  @Common.Label : '{i18n>Currency}'
  currency : Association to one Bookshop1.Currencies {  };
  /** {i18n>CurrencyCode.Description} */
  @Common.Label : '{i18n>Currency}'
  @Common.ValueList : {
    $Type: 'Common.ValueListType',
    Label: '{i18n>Currency}',
    CollectionPath: 'Currencies',
    Parameters: [
      {
        $Type: 'Common.ValueListParameterInOut',
        LocalDataProperty: currency_code,
        ValueListProperty: 'code'
      },
      {
        $Type: 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'name'
      }
    ]
  }
  currency_code : String(3);
  rating : Decimal(2, 1);
  texts : Composition of many Bookshop1.Books_texts {  };
  localized : Association to one Bookshop1.Books_texts {  };
  @UI.Hidden : true
  key IsActiveEntity : Boolean not null default true;
  @UI.Hidden : true
  HasActiveEntity : Boolean not null default false;
  @UI.Hidden : true
  HasDraftEntity : Boolean not null default false;
  @UI.Hidden : true
  DraftAdministrativeData : Association to one Bookshop1.DraftAdministrativeData {  };
  SiblingEntity : Association to one Bookshop1.Books {  };
} actions {
  action addToOrder(
    ![in] : $self,
    order_ID : UUID,
    quantity : Integer
  ) returns Bookshop1.Orders;
  action draftPrepare(
    ![in] : $self,
    SideEffectsQualifier : LargeString
  ) returns Bookshop1.Books;
  action draftActivate(
    ![in] : $self
  ) returns Bookshop1.Books;
  action draftEdit(
    ![in] : $self,
    PreserveChanges : Boolean
  ) returns Bookshop1.Books;
};

@cds.external : true
@cds.persistence.skip : true
@PersonalData.DataSubjectRole : 'Author'
@PersonalData.EntitySemantics : 'DataSubject'
entity Bookshop1.Authors {
  @PersonalData.FieldSemantics : 'DataSubjectID'
  @Core.ComputedDefaultValue : true
  key ID : UUID not null;
  @odata.Precision : 7
  @odata.Type : 'Edm.DateTimeOffset'
  @UI.HiddenFilter : true
  @UI.ExcludeFromNavigationContext : true
  @Core.Immutable : true
  @Core.Computed : true
  @Common.Label : '{i18n>CreatedAt}'
  createdAt : Timestamp;
  /** {i18n>UserID.Description} */
  @UI.HiddenFilter : true
  @UI.ExcludeFromNavigationContext : true
  @Core.Immutable : true
  @Core.Computed : true
  @Common.Label : '{i18n>CreatedBy}'
  createdBy : String(255);
  @odata.Precision : 7
  @odata.Type : 'Edm.DateTimeOffset'
  @UI.HiddenFilter : true
  @UI.ExcludeFromNavigationContext : true
  @Core.Computed : true
  @Common.Label : '{i18n>ChangedAt}'
  modifiedAt : Timestamp;
  /** {i18n>UserID.Description} */
  @UI.HiddenFilter : true
  @UI.ExcludeFromNavigationContext : true
  @Core.Computed : true
  @Common.Label : '{i18n>ChangedBy}'
  modifiedBy : String(255);
  @PersonalData.IsPotentiallySensitive : true
  @Validation.Pattern : '^\p{Lu}.*'
  name : String(111);
  dateOfBirth : Date;
  dateOfDeath : Date;
  placeOfBirth : LargeString;
  placeOfDeath : LargeString;
  books : Association to many Bookshop1.Books {  };
};

@cds.external : true
@cds.persistence.skip : true
@Common.DraftRoot : {
  $Type: 'Common.DraftRootType',
  ActivationAction: 'Bookshop1.draftActivate',
  EditAction: 'Bookshop1.draftEdit',
  PreparationAction: 'Bookshop1.draftPrepare'
}
entity Bookshop1.Orders {
  @Core.ComputedDefaultValue : true
  key ID : UUID not null;
  @odata.Precision : 7
  @odata.Type : 'Edm.DateTimeOffset'
  @UI.HiddenFilter : true
  @UI.ExcludeFromNavigationContext : true
  @Core.Immutable : true
  @Core.Computed : true
  @Common.Label : '{i18n>CreatedAt}'
  createdAt : Timestamp;
  /** {i18n>UserID.Description} */
  @UI.HiddenFilter : true
  @UI.ExcludeFromNavigationContext : true
  @Core.Immutable : true
  @Core.Computed : true
  @Common.Label : '{i18n>CreatedBy}'
  createdBy : String(255);
  @odata.Precision : 7
  @odata.Type : 'Edm.DateTimeOffset'
  @UI.HiddenFilter : true
  @UI.ExcludeFromNavigationContext : true
  @Core.Computed : true
  @Common.Label : '{i18n>ChangedAt}'
  modifiedAt : Timestamp;
  /** {i18n>UserID.Description} */
  @UI.HiddenFilter : true
  @UI.ExcludeFromNavigationContext : true
  @Core.Computed : true
  @Common.Label : '{i18n>ChangedBy}'
  modifiedBy : String(255);
  @Common.Label : '{i18n>OrderNumber}'
  @Common.FieldControl : #Mandatory
  OrderNo : LargeString;
  Items : Composition of many Bookshop1.OrderItems {  };
  /** {i18n>UserID.Description} */
  @Common.Label : '{i18n>UserID}'
  buyer : String(255);
  @Core.Computed : true
  total : Decimal(9, 2);
  /** {i18n>CurrencyCode.Description} */
  @Common.Label : '{i18n>Currency}'
  currency : Association to one Bookshop1.Currencies {  };
  /** {i18n>CurrencyCode.Description} */
  @Common.Label : '{i18n>Currency}'
  @Common.ValueList : {
    $Type: 'Common.ValueListType',
    Label: '{i18n>Currency}',
    CollectionPath: 'Currencies',
    Parameters: [
      {
        $Type: 'Common.ValueListParameterInOut',
        LocalDataProperty: currency_code,
        ValueListProperty: 'code'
      },
      {
        $Type: 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'name'
      }
    ]
  }
  currency_code : String(3);
  @UI.Hidden : true
  key IsActiveEntity : Boolean not null default true;
  @UI.Hidden : true
  HasActiveEntity : Boolean not null default false;
  @UI.Hidden : true
  HasDraftEntity : Boolean not null default false;
  @UI.Hidden : true
  DraftAdministrativeData : Association to one Bookshop1.DraftAdministrativeData {  };
  SiblingEntity : Association to one Bookshop1.Orders {  };
} actions {
  action draftPrepare(
    ![in] : $self,
    SideEffectsQualifier : LargeString
  ) returns Bookshop1.Orders;
  action draftActivate(
    ![in] : $self
  ) returns Bookshop1.Orders;
  action draftEdit(
    ![in] : $self,
    PreserveChanges : Boolean
  ) returns Bookshop1.Orders;
};

@cds.external : true
@cds.persistence.skip : true
@UI.Identification : [
  {
    $Type: 'UI.DataField',
    Value: name
  }
]
entity Bookshop1.Genres {
  @Common.Label : '{i18n>Name}'
  name : String(255);
  @Common.Label : '{i18n>Description}'
  descr : String(1000);
  key ID : Integer not null;
  parent : Association to one Bookshop1.Genres {  };
  @Common.ValueList : {
    $Type: 'Common.ValueListType',
    Label: 'Genres',
    CollectionPath: 'Genres',
    Parameters: [
      {
        $Type: 'Common.ValueListParameterInOut',
        LocalDataProperty: parent_ID,
        ValueListProperty: 'ID'
      },
      {
        $Type: 'Common.ValueListParameterDisplayOnly',
        ValueListProperty: 'name'
      }
    ]
  }
  parent_ID : Integer;
  children : Composition of many Bookshop1.Genres {  };
  texts : Composition of many Bookshop1.Genres_texts {  };
  localized : Association to one Bookshop1.Genres_texts {  };
};

@cds.external : true
@cds.persistence.skip : true
@UI.Identification : [
  {
    $Type: 'UI.DataField',
    Value: name
  }
]
entity Bookshop1.Currencies {
  @Common.Label : '{i18n>Name}'
  name : String(255);
  @Common.Label : '{i18n>Description}'
  descr : String(1000);
  @Common.Text : name
  @Common.Label : '{i18n>CurrencyCode}'
  key code : String(3) not null;
  @Common.Label : '{i18n>CurrencySymbol}'
  symbol : String(5);
  @Common.Label : '{i18n>CurrencyMinorUnit}'
  minorUnit : Integer;
  texts : Composition of many Bookshop1.Currencies_texts {  };
  localized : Association to one Bookshop1.Currencies_texts {  };
};

@cds.external : true
@cds.persistence.skip : true
@Common.DraftNode : {
  $Type: 'Common.DraftNodeType',
  PreparationAction: 'Bookshop1.draftPrepare'
}
entity Bookshop1.OrderItems {
  @Core.ComputedDefaultValue : true
  key ID : UUID not null;
  parent : Association to one Bookshop1.Orders {  };
  parent_ID : UUID;
  book : Association to one Bookshop1.Books {  };
  @Common.FieldControl : #Mandatory
  book_ID : UUID;
  quantity : Integer;
  amount : Decimal(9, 2);
  @UI.Hidden : true
  key IsActiveEntity : Boolean not null default true;
  @UI.Hidden : true
  HasActiveEntity : Boolean not null default false;
  @UI.Hidden : true
  HasDraftEntity : Boolean not null default false;
  @UI.Hidden : true
  DraftAdministrativeData : Association to one Bookshop1.DraftAdministrativeData {  };
  SiblingEntity : Association to one Bookshop1.OrderItems {  };
} actions {
  action draftPrepare(
    ![in] : $self,
    SideEffectsQualifier : LargeString
  ) returns Bookshop1.OrderItems;
};

@cds.external : true
@cds.persistence.skip : true
@Common.Label : '{i18n>Draft_DraftAdministrativeData}'
entity Bookshop1.DraftAdministrativeData {
  @UI.Hidden : true
  @Common.Label : '{i18n>Draft_DraftUUID}'
  @Core.ComputedDefaultValue : true
  key DraftUUID : UUID not null;
  @odata.Precision : 7
  @odata.Type : 'Edm.DateTimeOffset'
  @Common.Label : '{i18n>Draft_CreationDateTime}'
  CreationDateTime : Timestamp;
  @Common.Label : '{i18n>Draft_CreatedByUser}'
  CreatedByUser : String(256);
  @UI.Hidden : true
  @Common.Label : '{i18n>Draft_DraftIsCreatedByMe}'
  DraftIsCreatedByMe : Boolean;
  @odata.Precision : 7
  @odata.Type : 'Edm.DateTimeOffset'
  @Common.Label : '{i18n>Draft_LastChangeDateTime}'
  LastChangeDateTime : Timestamp;
  @Common.Label : '{i18n>Draft_LastChangedByUser}'
  LastChangedByUser : String(256);
  @Common.Label : '{i18n>Draft_InProcessByUser}'
  InProcessByUser : String(256);
  @UI.Hidden : true
  @Common.Label : '{i18n>Draft_DraftIsProcessedByMe}'
  DraftIsProcessedByMe : Boolean;
};

@cds.external : true
@cds.persistence.skip : true
@Common.DraftNode : {
  $Type: 'Common.DraftNodeType',
  PreparationAction: 'Bookshop1.draftPrepare'
}
entity Bookshop1.Books_texts {
  @Core.ComputedDefaultValue : true
  key ID_texts : UUID not null;
  @Common.Label : '{i18n>LanguageCode}'
  locale : String(14);
  ID : UUID;
  title : String(111);
  descr : String(1111);
  @UI.Hidden : true
  key IsActiveEntity : Boolean not null default true;
  @UI.Hidden : true
  HasActiveEntity : Boolean not null default false;
  @UI.Hidden : true
  HasDraftEntity : Boolean not null default false;
  @UI.Hidden : true
  DraftAdministrativeData : Association to one Bookshop1.DraftAdministrativeData {  };
  SiblingEntity : Association to one Bookshop1.Books_texts {  };
} actions {
  action draftPrepare(
    ![in] : $self,
    SideEffectsQualifier : LargeString
  ) returns Bookshop1.Books_texts;
};

@cds.external : true
@cds.persistence.skip : true
entity Bookshop1.Genres_texts {
  @Common.Label : '{i18n>LanguageCode}'
  key locale : String(14) not null;
  @Common.Label : '{i18n>Name}'
  name : String(255);
  @Common.Label : '{i18n>Description}'
  descr : String(1000);
  key ID : Integer not null;
};

@cds.external : true
@cds.persistence.skip : true
entity Bookshop1.Currencies_texts {
  @Common.Label : '{i18n>LanguageCode}'
  key locale : String(14) not null;
  @Common.Label : '{i18n>Name}'
  name : String(255);
  @Common.Label : '{i18n>Description}'
  descr : String(1000);
  @Common.Text : name
  @Common.Label : '{i18n>CurrencyCode}'
  key code : String(3) not null;
};

@cds.external : true
@path : 'admin'
service Bookshop1 {};

