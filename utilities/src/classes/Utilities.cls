/**
 * 
 * This class contains static methods that are helpful for doing some tasks 
 **/
public class Utility {

    /** Id validation **/
    
    public static Boolean isIdValid( String stringValue, Schema.SObjectType sObjectType ) {
        
        Id sObjectId;
        if ( isId( stringValue ) ) sObjectId = ( Id )stringValue;
        
        return isIdValid( sObjectId, sObjectType );
    }
    
    public static Boolean isIdValid( Id sObjectId, Schema.SObjectType sObjectType ) {
        
        return !( (sObjectId == null) || (sObjectId.getSObjectType() != sObjectType) );
        
    }
    
    public static Boolean isId( String stringValue ) {
        
        return stringValue InstanceOf Id;
        
    }

	/* Random Sequence */
	
    public static String getGuid() {
        
        // https://salesforce.stackexchange.com/questions/76216/how-to-generate-guid-in-salesforce
        // Create a nice 128-bit "GUID-lookalike" with a simple digest
        // This has a resolution of 1ms, so you might need to make sure at least 1ms has elapsed between each call.
        String result = EncodingUtil.convertToHex( Crypto.generateDigest( 'MD5', Blob.valueOf( DateTime.now().getTime().format() ) ) );
        
        // This guarantees a very high entropy value, but is more expensive (time-wise) than simply using the current time as the source.
        //String result = EncodingUtil.convertToHex( Crypto.generateDigest('MD5', Blob.valueOf(Crypto.getRandomLong().format())) );
        
        /*
        // https://salesforce.stackexchange.com/questions/4073/how-to-generate-a-guid-uuid
        Blob b = Crypto.GenerateAESKey(128);
        String h = EncodingUtil.ConvertTohex(b);
        String guid = h.SubString(0,8)+ '-' + h.SubString(8,12) + '-' + h.SubString(12,16) + '-' + h.SubString(16,20) + '-' + h.substring(20);
        String result = guid;
        */
        
        return result;
    }
    
}