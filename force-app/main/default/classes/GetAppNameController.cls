public class GetAppNameController {
	
    @Auraenabled
    public static String getAppName(){
        List<Schema.DescribeTabSetResult> tabSetDesc = Schema.describeTabs();

		String currentAppName;

		// Loop through the tabset describes until we get to the current app's tabset
		for(Schema.DescribeTabSetResult tsr : tabSetDesc){
            if(tsr.isSelected()){
                currentAppName = JSON.serialize(tsr.getTabs());
                break;
           }

        }
        
        return currentAppName;
        
    }
}