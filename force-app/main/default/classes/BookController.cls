public class BookController {
	
    private Book__c book;
    
    private List<Book__c> books;
    
    private final integer MAX_RECORDS_PER_PAGE = 5;
    
    public integer startingFrom {get; set;}
    
    private integer bookRecordCount;
    
    public BookController() {
       // String recordId = ApexPages.currentPage().getParameters().get('id');
       
         Id recordId = ApexPages.currentPage().getParameters().get('id');
        
        if(startingFrom == null) startingFrom = 0;
        
        if(recordId == null) {
            
            book = new Book__c();
            
        }
        
        else{
            
            book = [Select Name , Title__c, Author__c, Available__c from Book__c where Id = :recordId];
        }
        
        bookRecordCount = [Select Count() From Book__c];
    }
    
    public Book__c getBook () {
        return book;
    }
    
    public void setBook (Book__c book) {
		this.book = book;        
    }
    
    public List<Book__c> getBooks() {
        
        books = [Select Name , Title__c, Author__c, Available__c from Book__c Order By Title__c
                	LIMIT : MAX_RECORDS_PER_PAGE 
                	OFFSET : startingFrom];
        
        return books;
    }
    
    public PageReference save() {
        
        try {
            upsert book;
        } catch(DMLEXception ex) {
            
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 
                                                      ex.getMessage()));
            
            return ApexPages.currentPage();
        }
        
        PageReference pg = new ApexPages.StandardController(book).view();
        
        return pg;
        
        
    }
    
    public PageReference previous() {
        
        if(startingFrom <= 0) {
            startingFrom = 0;
        }
        else if(startingFrom >= bookRecordCount) {
            startingFrom = startingFrom - MAX_RECORDS_PER_PAGE;
        }
        else if(startingFrom < bookRecordCount){
             startingFrom = startingFrom - MAX_RECORDS_PER_PAGE;
        }
        
        return ApexPages.currentPage();
    }
    
    public PageReference next() {
        
        if((bookRecordCount - startingFrom) > MAX_RECORDS_PER_PAGE) {
            
            startingFrom = startingFrom + MAX_RECORDS_PER_PAGE;
        }
        
        return ApexPages.currentPage();
    }
    
    
    
    
}