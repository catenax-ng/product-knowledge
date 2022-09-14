//
// Test the tool to merge ontologies into single file
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.tools;

import org.junit.jupiter.api.Test;
import java.io.ByteArrayOutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.stream.Collectors;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.io.ByteArrayInputStream;
import org.w3c.dom.*;
import javax.xml.parsers.*;

/**
 * Test class for the merger tool
 */
public class OntologyMergerTest {
    
    OntologyMerger merger=new OntologyMerger();

    /**
     * read the CX ontology, merge it and understand it as an xml document 
     */
    @Test
    public void testMerger() throws Exception {
        ByteArrayOutputStream out=new ByteArrayOutputStream();
        String[] fileList=Files.list(Path.of("../"))
            .filter( path -> path.toFile().getName().endsWith("_ontology.ttl"))
            .map( path -> path.toFile().getAbsolutePath())
            .collect(Collectors.toList()).toArray(new String[0]);
        merger.run(fileList,out);
        String result=new String(out.toByteArray());
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        ByteArrayInputStream input = new ByteArrayInputStream(result.getBytes("UTF-8"));
        Document doc = builder.parse(input);
        assertNotNull(doc,"The ontology xml could be successfully parsed.");
    }

}