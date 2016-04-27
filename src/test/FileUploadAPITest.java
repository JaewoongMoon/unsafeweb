/**
 * @ FileUploadAPITest.java
 * 
 * Copyright 2016 NHN Techorus Corp. All rights Reserved. 
 * NHN Techorus PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */
package test;

import java.io.File;
import java.io.InputStream;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 * <pre>
 * test
 * FileUploadAPITest.java 
 * </pre>
 *
 * @brief	: 
 * @author	: 문재웅(jwmoon@nhn-techorus.com)
 * @Date	: 2016. 4. 20.
 */
public class FileUploadAPITest {

	public static void main(String[] args) {
		
		String dirPath = "FILE_upload";
		//log.debug("파일명 : " + item.getName());
		String fileName = "test.txt";
		File directory = new File(dirPath);
		if(!directory.exists()){
			directory.mkdir();
			System.out.println("DONE");
		}
	}
}
