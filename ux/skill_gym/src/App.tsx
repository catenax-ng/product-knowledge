import { AssetView, OntologyView } from "@catenax-ng/skill-modules";

export default function App(){
  const jsonUrl = 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/infrastructure/consumer/resources/cx-ontology.json'
  return(
    <>
      <AssetView />
      <OntologyView dataUrl={jsonUrl} />
    </>
  )
}