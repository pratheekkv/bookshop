package com.sap.bookshop.handlers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Component;

import com.sap.cds.Result;
import com.sap.cds.services.cds.CdsReadEventContext;
import com.sap.cds.services.cds.CqnService;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;

import cds.gen.bookshop1.Books_;
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
    String[] beanNames = applicationContext.getBeanNamesForType(CqnService.class);

    // Print each bean name
    System.out.println("Beans of type CqnService:");
    for (String beanName : beanNames) {
        System.out.println(beanName);
    }
    // return null;
    return bupa.run(context.getCqn());
  }

}
