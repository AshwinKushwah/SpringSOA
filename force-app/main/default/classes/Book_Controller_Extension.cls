public class Book_Controller_Extension {
    
    public Book__c book { get; set;}
    private ApexPages.StandardController stdController;
    
    public Book_Controller_Extension(ApexPAges.StandardController stdController) {
        
        this.stdController = stdController;
        List<String> fieldNames = new List<String>();
        fieldNames.add('Title__c');
        fieldNames.add('Author__c');
        stdController.addFields(fieldNames);
        book = (Book__c) stdController.getRecord();
    }
    
    public Book_Controller_Extension(ApexPAges.StandardSetController stdSetController) {
        
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
    
}