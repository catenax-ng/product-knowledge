import React from 'react';
import clsx from 'clsx';
import styles from './styles.module.css';

const FeatureList = [
  {
    title: 'Get Informed',
    Svg: require('@site/static/img/agent_kit.svg').default,
    description: (
      <>
          We ask you to make yourself familiar with our Documentation first by starting with our <a href="/product-knowledge/docs/adoption-view/intro">Introduction</a> document.
      </>
    ),
  },
  {
    title: 'Get Involved',
    Svg: require('@site/static/img/agent_kit.svg').default,
    description: (
      <>
          Engage into Agent-Oriented Dataspaces with our <a href="/product-knowledge/docs/development-view/architecture">Architecture</a> document.
      </>
    ),
  },
  {
    title: 'Get Started',
    Svg: require('@site/static/img/agent_kit.svg').default,
    description: (
      <>
          Deploy our Ready-Made Artifacts with our <a href="/product-knowledge/docs/operation-view/deployment">Deployment</a> guide.
      </>
    ),
  }
];

function Feature({Svg, title, description}) {
  return (
    <div className={clsx('col col--4')}>
      <div className="text--center">
        <Svg className={styles.featureSvg} role="img" />
      </div>
      <div className="text--center padding-horiz--md">
        <h3>{title}</h3>
        <p>{description}</p>
      </div>
    </div>
  );
}

export default function HomepageFeatures() {
  return (
    <section className={styles.features}>
      <div className="container">
        <div className="row">
          {FeatureList.map((props, idx) => (
            <Feature key={idx} {...props} />
          ))}
        </div>
      </div>
    </section>
  );
}
