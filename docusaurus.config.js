// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

const lightCodeTheme = require('prism-react-renderer/themes/github');
const darkCodeTheme = require('prism-react-renderer/themes/dracula');

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: 'Catena-X - Knowledge Agents',
  tagline: 'Providing Catena-X With Skills and Federated Inference Services',
  url: 'https://catena-x.net/',
  baseUrl: '/product-knowledge/',
  onBrokenLinks: 'log',
  onBrokenMarkdownLinks: 'log',
  favicon: 'img/favicon.ico',
  organizationName: 'catenax-ng/product-knowledge', // Usually your GitHub org/user name.
  projectName: 'catenax-ng.github.io/product-knowledge', // Usually your repo name.
  trailingSlash: false,
  noIndex: true,

  presets: [
    [
      'classic',
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          sidebarPath: require.resolve('./sidebars.js'),
          // Please change this to your repo.
          editUrl: 'https://github.com/catenax-ng/product-knowledge/edit/main/',
        },
        blog: {
          showReadingTime: true,
          // Please change this to your repo.
          editUrl:
            'https://github.com/catenax-ng/product-knowledge',
        },
        theme: {
          customCss: require.resolve('./src/css/custom.css'),
        },
      }),
    ],
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      navbar: {
        title: 'Catena-X',
        logo: {
          alt: 'Catena-X Logo',
          src: 'img/logo.svg',
        },
        items: [
          {
            type: 'doc',
            docId: 'intro',
            position: 'left',
            label: 'Documentation',
          },
          {
            to: '/blog', label: 'News', position: 'left'
          },
          {
            href: 'https://github.com/catenax-ng/product-knowledge.git',
            label: 'GitHub',
            position: 'right',
          },
        ],
      },
      footer: {
        style: 'dark',
        links: [
          {
            title: 'Docs',
            items: [
              {
                label: 'Get Started',
                to: '/docs/intro',
              },
              {
                label: 'Architecture',
                to: '/docs/architecture',
              },
              {
                label: 'How To',
                to: '/docs/howto',
              },
            ],
          },
          {
            title: 'Community',
            items: [
              {
                label: 'MS Teams - DevOps Support channel',
                href: 'https://teams.microsoft.com/l/channel/19%3a9a3c4a05a3514d07b973c13e7b468709%40thread.tacv2/CX%2520-%2520CoP%2520DevSecOps?groupId=17b1a2dc-67fb-4a49-a2ed-dd1344321439&tenantId=1ad22c6d-2f08-4f05-a0ba-e17f6ce88380',
              },
            ],
          },
          {
            title: 'More',
            items: [
              {
                label: 'Catena-X Automotive Network',
                href: 'https://catena-x.net/'
              },
              {
                label: 'Icons used from svgrepo with CC0 License',
                href: 'https://www.svgrepo.com/',
              },
              {
                label: 'GitHub',
                href: 'https://github.com/catenax-ng/product-knowledge',
              },
            ],
          },
        ],
        copyright: `Copyright © ${new Date().getFullYear()} Catena-X Test Data Generator - funded by BMWK, Inc. Built with Docusaurus.`,
      },
      prism: {
        theme: lightCodeTheme,
        darkTheme: darkCodeTheme,
      },
    })
};

module.exports = config;