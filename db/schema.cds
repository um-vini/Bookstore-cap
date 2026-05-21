using {
    cuid,
    managed,
    sap.common.Currencies
} from '@sap/cds/common';

namespace bookshop.db;

// Domain model
entity Books : cuid, managed {
    title       : String  @mandatory;
    author      : Association to Authors;
    genre       : Association to Genres;
    publishedAt : Date;
    pages       : Integer;
    price       : Decimal(10, 2);
    currency    : Association to Currencies; // type Currencies from @sap/cds/common
    stock       : Integer @assert.range: [
        0,
        _
    ];
    status      : Association to BookStatus;
    // Composition from books to chapters
    Chapters    : Composition of many Chapters
                      on Chapters.book = $self;
}

entity Genres {
    key code        : Genre;
        description : String;
}

type Genre          : String enum {
    Fiction = 'Fiction';
    Science = 'Science';
    Cooking = 'Cooking';
    Fantasy = 'Fantasy';
    Hobby = 'Hobby';
    Adventure = 'Adventure';
    SelfHelp = 'Self-Help';
    NonFiction = 'Non-Fiction';
    Art = 'Art';
    Children = 'Children';
}

entity BookStatus {
    key code        : BookStatusCode;
        criticality : Integer;
        displayText : String;
}

type BookStatusCode : String(1) enum {
    Available = 'A';
    Low_Stock = 'L';
    Unavailable = 'U';
}

entity Authors : cuid, managed {
    name  : String @mandatory;
    books : Association to many Books
                on books.author = $self; // Books table keeps the information
// virtual bookCount : Integer;
}

entity Chapters : cuid, managed {
    key book   : Association to Books;
        number : Integer;
        title  : String;
        pages  : Integer;
}
