@isTest
public class DateUtilityTest {
    @isTest
    private static void testParseDate() {
        System.assertEquals(Date.newInstance(2020,1,1),		DateUtility.parseDate('2020-01-01'));
        System.assertEquals(Date.newInstance(2020,1,1),		DateUtility.parseDate('2020-01-01T01:09:00Z'));
        System.assertEquals(Date.newInstance(2020,1,1),		DateUtility.parseDate('01/01/2020'));
        System.assertEquals(Date.newInstance(2020,1,1),		DateUtility.parseDate('1/1/2020'));
        System.assertEquals(Date.newInstance(2020,1,1),		DateUtility.parseDate('01/01/2020 05:08:00.000-0800'));
        System.assertEquals(null,							DateUtility.parseDate(null));
        System.assertEquals(null,							DateUtility.parseDate(''));
        System.assertEquals(null,							DateUtility.parseDate('ab/de/1201'));
        System.assertEquals(null,							DateUtility.parseDate('13/01/2020'));
        System.assertEquals(null,							DateUtility.parseDate('2020-13-01'));
        
    }
    
    @isTest
    private static void testParseTime() {
        System.assertEquals(null, DateUtility.parseTime( null ));
        System.assertEquals(null, DateUtility.parseTime( '' ));
        System.assertEquals(null, DateUtility.parseTime('12:00'));
        System.assertEquals(null, DateUtility.parseTime(':00'));
        System.assertEquals(null, DateUtility.parseTime('12:'));
        System.assertEquals(null, DateUtility.parseTime('12:am'));
        System.assertEquals(null, DateUtility.parseTime(':'));
        System.assertEquals(null, DateUtility.parseTime('12:020am'));
        System.assertEquals(null, DateUtility.parseTime('122:00am'));
        System.assertEquals(null, DateUtility.parseTime('12:w0am'));
        System.assertEquals(null, DateUtility.parseTime('52:00am'));
        System.assertEquals(null, DateUtility.parseTime('-2:00am'));
        System.assertEquals(null, DateUtility.parseTime('12:98am'));
        System.assertEquals(null, DateUtility.parseTime('12:-2am'));
        
        System.assertEquals(Time.newInstance( 0, 0, 0, 0 ), DateUtility.parseTime('12:00am'));
        System.assertEquals(Time.newInstance( 0, 30, 0, 0 ), DateUtility.parseTime('12:30am'));
        System.assertEquals(Time.newInstance( 0, 32, 0, 0 ), DateUtility.parseTime('12:32am'));
        System.assertEquals(Time.newInstance( 1, 0, 0, 0 ), DateUtility.parseTime('1:00am'));
        System.assertEquals(Time.newInstance( 1, 30, 0, 0 ), DateUtility.parseTime('1:30am'));
        System.assertEquals(Time.newInstance( 12, 0, 0, 0 ), DateUtility.parseTime('12:00pm'));
        System.assertEquals(Time.newInstance( 12, 30, 0, 0 ), DateUtility.parseTime('12:30pm'));
        System.assertEquals(Time.newInstance( 12, 32, 0, 0 ), DateUtility.parseTime('12:32pm'));
        System.assertEquals(Time.newInstance( 13, 0, 0, 0 ), DateUtility.parseTime('1:00pm'));
        System.assertEquals(Time.newInstance( 13, 30, 0, 0 ), DateUtility.parseTime('1:30pm'));
        System.assertEquals(Time.newInstance( 13, 33, 0, 0 ), DateUtility.parseTime('1:33pm'));
        System.assertEquals(Time.newInstance( 19, 30, 0, 0 ), DateUtility.parseTime('7:30pm'));
    }
}