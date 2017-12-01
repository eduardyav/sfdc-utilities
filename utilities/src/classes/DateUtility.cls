/**
 * 
 * 
 */
public with sharing class DateUtility {
    
    /**
    * parseDate; null is invalid Date; yyyy-mm-dd and locale-specific e.g. mm/dd/yyyy or dd/mm/yyyy formats supported
    **/
    public static Date parseDate( String inDate ) {
        System.debug( '>>> [DateUtility] => [parseDate] => [inDate]: ' + inDate );
        Date dateRes = null;
        //  1 - Try locale specific mm/dd/yyyy or dd/mm/yyyy    
        try {
            String candDate = inDate.substring( 0, Math.min(10, inDate.length() ) ); // grab date portion only m[m]/d[d]/yyyy , ignore time
            dateRes = Date.parse( candDate );
        }
        catch ( Exception e ) {}
        
        if ( dateRes == null ) {
            //  2 - Try yyyy-mm-dd          
            try {
                String candDate = inDate.substring( 0, 10 ); // grab date portion only, ignore time, if any
                dateRes = Date.valueOf( candDate );
            }
            catch ( Exception e ) {} 
        }
        System.debug( '>>> [DateUtility] => [parseDate] => [dateRes]: ' + String.valueOf( dateRes ) );
        return dateRes;
    }
    
    /**
     * parseTime; null is invalid Time; only '1:00am' format supported
     * 12 am - 00:00
     * 12 pm - 12:00
     * Returns Time object (UTC is assumed.)
     **/
    public static Time parseTime( String inTime ) {
        System.debug( '>>> [DateUtility] => [parseTime] => [inTime]: ' + inTime );
        Time timeRes = null;
        if ( (inTime == null) || (inTime == '') || (inTime.length() < 6) || (inTime.length() > 7) ) return timeRes;
        
        // Get the part of the day
        Boolean am = inTime.containsIgnoreCase( 'am' );
        Boolean pm = inTime.containsIgnoreCase( 'pm' );
        if ( !( am || pm ) ) return timeRes;
        
        // Get rid of the am/pm part
        String timePart = inTime.substring( 0, (inTime.length() - 2) );
        System.debug( '>>> [DateUtility] => [parseTime] => [timePart]: ' + timePart );
        
        List<String> parts = timePart.split( ':' );
        System.debug( '>>> [DateUtility] => [parseTime] => [parts]: ' + parts );
        
        if ( parts.size() != 2 ) return timeRes;
        
        // Get the hour part
        String hourPart = parts[0];
        System.debug( '>>> [DateUtility] => [parseTime] => [hourPart]: ' + hourPart );
        // Get the minutes part
        String minutesPart = parts[1];
        System.debug( '>>> [DateUtility] => [parseTime] => [minutesPart]: ' + minutesPart );
        
        Integer hour = 0;
        try {
            hour = Integer.valueOf( hourPart );
        } catch ( System.TypeException e ) {
            System.debug( '>>> [DateUtility] => [parseTime] => TypeException: ' + e.getMessage() );
            return timeRes;
        }
        Integer minutes = 0;
        try {
            minutes = Integer.valueOf( minutesPart );
        } catch ( System.TypeException e ) {
            System.debug( '>>> [DateUtility] => [parseTime] => TypeException: ' + e.getMessage() );
            return timeRes;
        }
        Integer seconds = 0;
        Integer milliseconds = 0;
        
        // Chek intervals
        if ( (hour < 1) || (hour > 12) ) return timeRes;
        if ( (minutes < 0) || (minutes > 60) ) return timeRes;
        
        if ( am ) {
            if ( hour == 12 ) hour = 0;
        } else if ( pm ) {
            if ( hour < 12 ) hour += 12;
        }
        
        timeRes = Time.newInstance( hour, minutes, seconds, milliseconds );
        System.debug( '>>> [DateUtility] => [parseTime] => [timeRes]: ' + timeRes );
        return timeRes;
    }
    
    /**
     * 
     * 
     **/
    public static Long getMiliseconds( Date dt, Time tm) {
        return 0;
    }
    
    /**
     * 
     * 
     **/
    public static DateTime getGmtDateTimeInTimeZone( Date dateGmt, Time timeGmt, String timeZoneId ) {
       System.debug(dateGmt+'----'+timeGmt);
        DateTime dtGmt = DateTime.newInstanceGmt( dateGmt, timeGmt );
        System.debug( '>>> [DateUtility] => [getGmtDateTimeInTimeZone] => [dtGmt]: ' + dtGmt );
        System.debug( '>>> [DateUtility] => [getGmtDateTimeInTimeZone] => formatGMT(): ' + dtGmt.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss') );
        
        // hours offser needs to be negated since we need to find the correct GMT time for the given timezone from input GMT time
        Timezone tz = Timezone.getTimeZone( timeZoneId );
        Integer hoursOffset = -( tz.getOffset( dtGmt ) / ( 1000 * 60 *60 ) );      
        System.debug( '>>> [DateUtility] => [getGmtDateTimeInTimeZone] => ' + tz.getID() + ' offset for GMT is ' + hoursOffset + ' hours' );
        
        // Calcute correct GMT time for the given timezone
        DateTime dtGmtNew = dtGmt.addHours( hoursOffset );
        System.debug( '>>> [DateUtility] => [getGmtDateTimeInTimeZone] => GMT dtGmtNew: ' + dtGmtNew + ' formatGMT()' + dtGmtNew.formatGMT( 'yyyy-MM-dd\'T\'HH:mm:ss' ) );
        System.debug( '>>> [DateUtility] => [getGmtDateTimeInTimeZone] => In ' + tz.getID() + ' format()' + dtGmtNew.format('yyyy-MM-dd\'T\'HH:mm:ss', tz.getID() ) );
        
        return dtGmtNew;
        
    }
    
}