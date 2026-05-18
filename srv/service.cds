using {tutorial.db as db} from '../db/schema';

service BookstoreService {
    entity Books      as projection on db.Books;
    entity Authors    as projection on db.Authors;
    entity Chapters   as projection on db.Chapters;
    entity BookStatus as projection on db.BookStatus;
}

// Can be annotated direcly in the annotations.cds file
annotate BookstoreService.Books with @odata.draft.enabled;
