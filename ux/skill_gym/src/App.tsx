import { AssetView, OntologyView, OntologyViewWebVowl } from "@catenax-ng/skill-modules";

export default function App(){
  return(
    <>
      <AssetView />
      {/*
      <OntologyView dataUrl='https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/infrastructure/consumer/resources/cx-ontology.json' />
      */}
      <OntologyViewWebVowl dataUrl='https://raw.githubusercontent.com/catenax-ng/product-knowledge/feature/KA-125-ontology-hub/ontology/cx.json'/>
    </>
  )
}