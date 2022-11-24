import { AssetView, OntologyView } from '@catenax-ng/skill-modules';

export default function SkillGym() {
  return (
    <>
      <AssetView />
      {/* <OntologyView dataUrl={jsonUrl} /> */}
      <iframe title="WebVowl" width="100%" height={700} src="https://service.tib.eu/webvowl/#url=https://raw.githubusercontent.com/catenax-ng/product-knowledge/feature/KA-125-ontology-hub/ontology/address_ontology_vowl.json" />;
    </>
  );
}
