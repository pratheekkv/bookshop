package com.sap.bookshop.handlers;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Component;

import com.sap.cds.Result;
import com.sap.cds.ResultBuilder;
import com.sap.cds.ql.Select;
import com.sap.cds.ql.cqn.CqnSelect;
import com.sap.cds.services.cds.CdsReadEventContext;
import com.sap.cds.services.cds.CqnService;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;
import static com.sap.cds.ResultBuilder.selectedRows;

import cds.gen.adminservice.Books_;
import cds.gen.bookshop1.Bookshop1_;
import cds.gen.adminservice.AdminService_;
import cds.gen.bookshop1.Books;
@Component
@ServiceName(AdminService_.CDS_NAME)
public class AdminServiceHandler implements EventHandler{

    private static Logger logger = LoggerFactory.getLogger(AdminServiceHandler.class);

    @Autowired
    @Qualifier(Bookshop1_.CDS_NAME)
    CqnService bupa;

    @Autowired
    private ApplicationContext applicationContext;

    @On(entity = Books_.CDS_NAME)
    void readSuppliers(CdsReadEventContext context) {
      try{
        CqnSelect select = Select.from(cds.gen.bookshop1.Books_.CDS_NAME).limit(100);
        List<Books> businessPartner = bupa.run(select).listOf(Books.class);
        context.setResult(ResultBuilder.selectedRows(businessPartner).inlineCount(businessPartner.size()).result());
      }catch(Exception e){
        logger.error("Exception Occurred during READ of AdminService.Books", e);
      }
  }

}
