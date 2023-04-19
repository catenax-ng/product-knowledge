// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

const lightCodeTheme = require('prism-react-renderer/themes/github');
const darkCodeTheme = require('prism-react-renderer/themes/dracula');

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: 'Tractus-X Agents Kit',
  tagline: 'Reference Implementation of Semantic Federated Dataspace Components',
  url: 'https://catenax-ng.github.io',
  baseUrl: '/product-knowledge/',
  onBrokenLinks: 'log',
  onBrokenMarkdownLinks: 'log',
  favicon: 'img/logo_tractus-x-min.ico',
  organizationName: 'catenax-ng/product-knowledge', // Usually your GitHub org/user name.
  projectName: 'catenax-ng.github.io/product-knowledge', // Usually your repo name.
  trailingSlash: false,
  noIndex: true,
  // Even if you don't use internalization, you can use this field to set useful
  // metadata like html lang. For example, if your site is Chinese, you may want
  // to replace "en" with "zh-Hans".
  i18n: {
    defaultLocale: 'en',
    locales: ['en'],
  },
  presets: [
    [
      'classic',
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          sidebarPath: require.resolve('./sidebars.js'),
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          editUrl: 'https://github.com/catenax-ng/product-knowledge/tree/feature/ART3-382-documentation',
          docLayoutComponent: "@theme/DocPage",
          docItemComponent: "@theme/ApiItem" // Derived from docusaurus-theme-openapi-docs  
        },
        blog: {
          showReadingTime: true,
          blogSidebarTitle: 'Agent News',
          blogSidebarCount: 'ALL',
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          editUrl: 'https://github.com/catenax-ng/product-knowledge/tree/feature/ART3-382-documentation',
        },
        theme: {
          customCss: require.resolve('./src/css/custom.css'),
        },
      }),
    ]
  ],

  plugins: [
    [
      'docusaurus-plugin-openapi-docs',
      {
        id: "ka",
        docsPluginId: "classic",
        config: {
          siteController: { // Note: petstore key is treated as the <id> and can be used to specify an API doc instance when using CLI commands
            specPath: "./openapi/cx_ka_agent-openapi.yaml", // Path to designated spec file
            outputDir: "./docs/development-view/KA", // Output directory for generated .mdx docs
            sidebarOptions: {
              groupPathsBy: "tag",
            },
          }
        },
      }
    ]
  ],
  themes: ["docusaurus-theme-openapi-docs"],
  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      colorMode: {
        defaultMode: 'dark',
        disableSwitch: true,
        respectPrefersColorScheme: false,
      },
      algolia: {
        apiKey: 'a97c5de3a563a32884153d3a84568be1',
        indexName: 'eclipse-tractusxio',
        appId: '5EEK7E23IM',
      },
      navbar: {
        title: 'Eclipse Tractus-X',
        logo: {
          alt: 'Eclipse Tractus-X logo',
          src: 'img/logo_tractus-x.svg',
        },
        items: [
          {
            to: "/",
            exact: true,
            position: "left",
            label: "Home",
          },
          {to: 'blog', label: 'News', position: 'left'},
          {
            to: 'docs/adoption-view/intro',
            position: 'left',
            label: 'About us',
          },
          {
            to: 'docs/development-view/architecture',
            position: 'left',
            label: 'Developer Hub',
          },
          {
            to: 'docs/Changelog',
            position: "left",
            label: "Versions",
          },
          /* {to: '/blog', label: 'Blog', position: 'left'}, */
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
            title: 'Eclipse Foundation',
            items: [
              {
                label: "Main Eclipse Foundation website",
                href: "http://www.eclipse.org",
              },
              {
                label: "Privacy policy",
                href: "http://www.eclipse.org/legal/privacy.php",
              },
              {
                label: "Website terms of use",
                href: "http://www.eclipse.org/legal/termsofuse.php",
              },
              {
                label: "Copyright agent",
                href: "http://www.eclipse.org/legal/copyright.php",
              },
              {
                label: "Legal",
                href: "http://www.eclipse.org/legal",
              },
            ],
          },
          {
            title: 'Docs',
            items: [
              {
                label: 'Adopt',
                to: '/docs/adoption-view/intro',
              },
              {
                label: 'Develop',
                to: '/docs/development-view/architecture',
              },
              {
                label: 'Deploy',
                to: '/docs/operation-view/deployment',
              }
            ],
          },
          {
            title: 'Community',
            items: [
              {
                label: "Eclipse Foundation project",
                href: "https://projects.eclipse.org/projects/automotive.tractusx",
              },
              {
                label: "GitHub Organization",
                href: "https://github.com/eclipse-tractusx",
              },
              {
                label: "Catena-X Automotive Network",
                href: "https://catena-x.net/",
              },
              {
                label: "Icons used from svgrepo with CC0 License",
                href: "https://www.svgrepo.com/",
              },
            ],
          },
          {
            title: 'Useful Links',
            items: [
              {
                label: "Report a Bug",
                href: "https://bugs.eclipse.org/bugs",
              },
              {
                label: "Documentation",
                href: "https://help.eclipse.org/latest/index.jsp",
              },
              {
                label: "How to Contribute",
                href: "https://www.eclipse.org/contribute/",
              },
              {
                label: "Mailing Lists",
                href: "https://accounts.eclipse.org/mailing-list",
              },
              {
                label: "Forums",
                href: "https://www.eclipse.org/forums/",
              },
            ],
          },
          {
            items: [
              {
                html: `
                  <img src='/img/EF_registered_wht_png.png'/>
                `
              }
            ]
          }
        ],
        copyright: `Copyright © ${new Date().getFullYear()} Eclipse Tractus-X. Built with Docusaurus.`,
      },
      prism: {
        theme: lightCodeTheme,
        darkTheme: darkCodeTheme,
      },
    }),
};

module.exports = config;