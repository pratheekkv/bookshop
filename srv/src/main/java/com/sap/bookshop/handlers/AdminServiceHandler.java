package com.sap.bookshop.handlers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import com.sap.cds.Result;
import com.sap.cds.services.cds.CdsReadEventContext;
import com.sap.cds.services.cds.CqnService;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;

import cds.gen.bookshop1.Books_;
import cds.gen.adminservice.AdminService_;
import cds.gen.adminservice.ExternalBooks_;
@Component
@ServiceName(AdminService_.CDS_NAME)
public class AdminServiceHandler implements EventHandler{

    @Autowired
    @Qualifier(Books_.CDS_NAME)
    CqnService bupa;

     @On(entity = ExternalBooks_.CDS_NAME)
  Result readSuppliers(CdsReadEventContext context) {
    return bupa.run(context.getCqn());
  }

}
