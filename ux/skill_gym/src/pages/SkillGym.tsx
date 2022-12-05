import { AssetView, OntologyHub, OntologyView } from '@catenax-ng/skill-modules';
import { useState } from 'react';

export default function SkillGym() {
  const [selectedOntology, setSelectedOntology] = useState<string>('')
  return (
    <>
      <AssetView />
      {selectedOntology.length > 0 &&
        <iframe title="WebVowl" width="100%" height={500} src={`https://service.tib.eu/webvowl/#url=${selectedOntology}`} />
      }
      {/* <OntologyView dataUrl={jsonUrl} /> */}
      <OntologyHub onOntologySelect={setSelectedOntology} />
    </>
  );
}
