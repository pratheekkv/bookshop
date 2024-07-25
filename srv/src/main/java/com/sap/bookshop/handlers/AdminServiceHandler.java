package com.sap.bookshop.handlers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Component;

import com.sap.cds.Result;
import com.sap.cds.ql.Select;
import com.sap.cds.ql.cqn.CqnSelect;
import com.sap.cds.services.cds.CdsReadEventContext;
import com.sap.cds.services.cds.CqnService;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;
import static com.sap.cds.ResultBuilder.selectedRows;

import cds.gen.bookshop1.Books_;
import cds.gen.bookshop1.Bookshop1;
import cds.gen.bookshop1.Bookshop1_;
import cds.gen.adminservice.AdminService_;
import cds.gen.adminservice.ExternalBooks_;
@Component
@ServiceName(AdminService_.CDS_NAME)
public class AdminServiceHandler implements EventHandler{

    @Autowired
    @Qualifier(Bookshop1_.CDS_NAME)
    CqnService bupa;

    @Autowired
    private ApplicationContext applicationContext;

    @On(entity = ExternalBooks_.CDS_NAME)
    Result readSuppliers(CdsReadEventContext context) {
     CqnSelect select = Select.from(Bookshop1_.CDS_NAME).limit(100);
     List<Bookshop1> businessPartner = bupa.run(select).listOf(Bookshop1.class);
     return null;
  }

}
