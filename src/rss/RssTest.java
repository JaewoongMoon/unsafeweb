/**
 * @ RssTest.java
 * 
 * Copyright 2016 NHN Techorus Corp. All rights Reserved. 
 * NHN Techorus PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */
package rss;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Date;
import java.util.List;

import com.sun.syndication.feed.synd.SyndCategoryImpl;
import com.sun.syndication.feed.synd.SyndEntry;
import com.sun.syndication.feed.synd.SyndFeed;
import com.sun.syndication.io.FeedException;
import com.sun.syndication.io.SyndFeedInput;
import com.sun.syndication.io.XmlReader;


/**
 * <pre>
 * rss
 * RssTest.java 
 * </pre>
 *
 * @brief	: 
 * @author	: 문재웅(jwmoon@nhn-techorus.com)
 * @Date	: 2016. 4. 15.
 */
public class RssTest {

	
//	private static String url = "http://www.rfa.org/korean/in_focus/RSS";
	private static String url = "http://aegis-wall.blog.jp/index.rdf";
	
	public static void main(String[] args) throws IllegalArgumentException, FeedException, IOException {
		URL feedUrl = new URL(url);
		SyndFeedInput input= new SyndFeedInput();
		SyndFeed syndFeed = input.build(new XmlReader(feedUrl)); 
		
		
		/*RSS*/
		
		System.out.println("### getFeedType 	[" + syndFeed.getFeedType() +"]");
        System.out.println("### getLanguage 	[" + syndFeed.getLanguage() +"]");
        System.out.println("### getTitle 		[" + syndFeed.getTitle() +"]");
        System.out.println("### getPublishedDate 	[" + syndFeed.getPublishedDate() +"]");
        

        List<SyndEntry> entries = syndFeed.getEntries();        
        SyndEntry entry = null;
        
        /*발행정보*/
        for(int i=0, j=entries.size(); i<j ; i++) {
            entry = entries.get(i);
            System.out.println("### 제목 		[" + entry.getTitle() +"]");
            System.out.println("### URL 			[" + entry.getUri() +"]");
            System.out.println("### 설명 	[" + entry.getDescription().getValue() +"]");
            System.out.println("### 발행일 [" + entry.getPublishedDate() +"]");
//            System.out.println("### 발행자 [" + entry.getAuthor() +"]");
//            System.out.println("### 테스트 [" + entry.getSource()  +"]");
         // Get the Categories
            for (SyndCategoryImpl category : (List<SyndCategoryImpl>) entry.getCategories()) {
                System.out.println("Category: " + category.getName());
            }
            System.out.println("===================================================================");
        }
        
        /*날짜변환*/
        // 1460951921000
//        Date date = new Date
	}
}
