//
// Catena-X Ontology Tools
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.tools;

import de.uni_stuttgart.vis.vowl.owl2vowl.export.types.BackupExporter;
import org.semanticweb.owlapi.formats.RDFJsonLDDocumentFormat;
import org.semanticweb.owlapi.formats.RDFXMLDocumentFormat;
import org.semanticweb.owlapi.model.*;

import org.semanticweb.owlapi.apibinding.OWLManager;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.OutputStream;
import java.io.PrintStream;
import java.util.ArrayList;

import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

/**
 * Command line tool to merge several ontology files into
 * a single one.
 */
public class OntologyMerger {
   /** ontology manager */
   OWLOntologyManager manager = OWLManager.createOWLOntologyManager();
   /** the output format */

   OWLDocumentFormat ontologyFormat = new RDFXMLDocumentFormat();

   /** 
    * run the merge command on the given files and output the result to the console  
    * @param args a set of arguments
    */
   public void run(String[] args) throws Exception {
      run(args,System.out);
   }

   public static String CX_ONTOLOGY_IRI= "https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/cx_ontology.ttl";
   public static String CX_ONTOLOGY_TITLE= "Catena-X Ontology";
   public static String CX_ONTOLOGY_VERSION= "0.8.6-SNAPSHOT";

   /**
    * run the merge command on the given files and output the result to the console  
    * @param args a set of arguments
    * @param outStream to use for output 
    */
    public void run(String[] args, PrintStream outStream) throws Exception {
      ArrayList<String> remainingArgs=new ArrayList<>();
      String iri=CX_ONTOLOGY_IRI;
      String title = CX_ONTOLOGY_TITLE;
      String version = CX_ONTOLOGY_VERSION;

      String styleSheet=null;
      boolean isVowl=false;
      try {
         for(int count=0;count<args.length;count++) {
            if("-styleSheet".equals(args[count])) {
               ++count;
               if(count<args.length) {
                  styleSheet=args[count];
                  // special logic to circumvent the buggy stylesheet approach
                  if(styleSheet.endsWith("vowl.xslt")) {
                     styleSheet=null;
                     isVowl=true;
                  }
               }
            } else if("+jsonld".equals(args[count])) {
              ontologyFormat=new RDFJsonLDDocumentFormat();
            } else if("-iri".equals(args[count])) {
               ++count;
               if(count<args.length) {
                  iri=args[count];
               }
             } else if("-version".equals(args[count])) {
               ++count;
               if(count<args.length) {
                  version = args[count];
               }
             } else if("-title".equals(args[count])) {
               ++count;
               if(count<args.length) {
                  title = args[count].replace("\"", "");
               }
             } else {
               remainingArgs.add(args[count]);
            }
         }
         ByteArrayOutputStream bos=new ByteArrayOutputStream();
         run(remainingArgs.toArray(new String[0]),iri,title,version,bos,isVowl);
         if(styleSheet!=null) {
            StreamSource sheet = new javax.xml.transform.stream.StreamSource(styleSheet);
            TransformerFactory factory=TransformerFactory.newInstance();
            Transformer transformer=factory.newTransformer(sheet);
            ByteArrayInputStream bis=new ByteArrayInputStream(bos.toByteArray());
            bos=new ByteArrayOutputStream();
            transformer.transform(new StreamSource(bis), new StreamResult(bos));
         } 
         outStream.println(bos);
         outStream.flush();
      } finally {
         if(outStream!=System.out) {
            outStream.close();
         }
      }
   }

   /** 
    * run the merge command on the given files with the given output stream
    * @param args filenames
    * @param out stream to render the ontology into
    */
   public void run(String[] args, String iri, String title, String version, OutputStream out, boolean isVowl) throws Exception {
      ArrayList<OWLOntology> imports=new ArrayList<>();

      for (String arg : args) {
         try {
            OWLOntology myOntology=manager.loadOntologyFromOntologyDocument(new File(arg));
            imports.add(myOntology);
         } catch(Exception e) {
            System.err.printf("Could not import ontology %s because of %s. Ignoring.%n",arg,e);
         }
      }
      
      OWLOntology newOntology = imports.size()==1 ? imports.get(0) : null;

      if(newOntology==null) {
          IRI oIri=IRI.create(iri);
          newOntology = manager.createOntology(oIri,imports,false);
          OWLNamedIndividual oInd = manager.getOWLDataFactory().getOWLNamedIndividual(oIri);
          OWLDataProperty dcTitle = manager.getOWLDataFactory().getOWLDataProperty(IRI.create("http://purl.org/dc/elements/1.1/title"));
          OWLDataProperty owlVersionInfo = manager.getOWLDataFactory().getOWLDataProperty(IRI.create("http://www.w3.org/2002/07/owl#versionInfo"));
          //OWLLiteral versionLiteral = manager.getOWLDataFactory().getOWLLiteral(version);
          OWLDataPropertyAssertionAxiom hasTitle = manager.getOWLDataFactory().
                  getOWLDataPropertyAssertionAxiom(dcTitle,oInd,title);
          OWLDataPropertyAssertionAxiom hasVersion = manager.getOWLDataFactory().
                  getOWLDataPropertyAssertionAxiom(owlVersionInfo,oInd,version);
          manager.addAxiom(newOntology,hasTitle);
          manager.addAxiom(newOntology,hasVersion);
      }

      if(isVowl) {
         OntologyConverter converter=new OntologyConverter(newOntology);
         converter.clearLoadingMsg();
         BackupExporter exporter = new BackupExporter();
         try {
            converter.export(exporter);
         } catch (Exception var3) {
            throw new IllegalStateException(var3);
         }
         String json=exporter.getConvertedJson();
         new PrintStream(out).print(json);
      } else {
         newOntology.getOWLOntologyManager().saveOntology(newOntology,ontologyFormat, out);
      }
   }

   /** 
    * main entry 
    * @param args command line arguments 
    */
   public static void main(String[] args) throws Exception {
      new OntologyMerger().run(args);
   }

}


