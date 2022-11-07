import { AssetView, OntologyView, OntologyViewWebVowl } from '@catenax-ng/skill-modules';

export default function SkillGym() {
  const jsonUrl =
    'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/infrastructure/consumer/resources/cx-ontology.json';

  return (
    <>
      <AssetView />
      {/* <OntologyView dataUrl={jsonUrl} /> */}
      <OntologyViewWebVowl dataUrl='https://raw.githubusercontent.com/catenax-ng/product-knowledge/feature/KA-125-ontology-hub/ontology/cx.json'/>
    </>
  );
}
