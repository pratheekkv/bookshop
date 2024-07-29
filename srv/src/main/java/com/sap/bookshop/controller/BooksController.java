package com.sap.bookshop.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.bind.annotation.RestController;

import cds.gen.bookshop1.Books;

@RestController("/books")
public class BooksController {


    List<Books> getBooks(){
        List<Books> books = new ArrayList<>();

        return books;
    }


}
